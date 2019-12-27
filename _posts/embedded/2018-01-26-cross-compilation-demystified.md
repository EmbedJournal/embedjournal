---
title: "Cross Compilation Demystified"
date: 2018-01-26T10:39:00+0530
author: Siddharth
permalink: /cross-compilation-demystified/
dsq_thread_id: "Qope2pudez"
category: "embedded"
tags: [ "XCompile", "Basics" ]
---

Cross-compiling is an integral part of embedded software development. Most established projects adhere to set of well defined contract to achieve this. But still, there are many other (smaller) projects which employ subtle variations to achieve the same effect. Owing to this, a lot of beginners get thrown off guard when enlisted to cross-compile modules.

In this article we will discuss some general principles and methods to adopted in different projects to get an idea of what to expect (and what to provide) in a project. Hopefully, this will in someday help you cross-compile without breaking a sweat.

{% include toc.html %}

Before we get into the specifics, we will take a detour and explain cross-compilation for the beginners. Those of you who are already familiar with the basics, feel free to [skip the intro section](#cross-compilation-techniques).

# What is cross-compilation?

It is the process of building an executable from source with a suitable compiler ([cross-compiler][1]) in one machine that can be directly executed in another. That is, the build and host machines are not of the same architecture (more on these terms [later][11]).

In other words, it is compilation of sources in one architecture that can be run on another with a suitable compiler.

## What is the need for cross-compilation?

Predominantly, cross-compilation is used in the embedded world (it is used elsewhere as well) where the host platform (where the application will run) is severely limited in resources. On the other hand, the build machine (usually) has a lot more juice (CPU, GPU, RAM, etc.,) to produce machine code that can be executed directly in another architecture.

These limitations in the host system preclude the possibility of having a compiler on-board and ergo, the need for cross-compilation.

## Can you get anything cross-compiled easily?

Short answer, no.

It depends on a lot of things. For starters, the software's author must have had cross compilation in the road map for the project and refrained from using OS/architecture specific constructs.

There are other factors such as, assumptions made on [endianness][2], [alignment][3] or [word size][4], that can cause serious breakage in functionality when cross compiled. Going into the details on each of those topics and how exactly they surface is beyond the scope of this article, but Wikipedia has some nice write-ups if you are so inclined.

With that said, there are still a vast majority of small projects, that with little effort can be cross compiled successfully.

## Typical cross-compilation process

In essence, cross-compilation is just a matter of `export CC=some-arch-gcc` followed by a `make` in the same shell. Although this can theoretically work (perhaps on small projects), the real world isn't as straightforward as you might expect. Partly, due to the complexity in requirement of the system you are trying to cross-compile.

## Dependency resolution

The biggest hurdle in cross compilation is meeting all dependencies of a given software package. In standard compilation, when you come across a build time dependency, it's just a matter of apt-get/yum install pre-compiled version of that package. This also ensures all dependencies of that package is met: which is _actually_ the most tricky part.

When cross compiling, the task of dependency resolution is left to us. Let's consider the scenario where you are tasked with cross compiling curl to your target.

You will soon come to the realization that curl depends on openssl and zlib (and more depending on your need). Openssl in turn depends on pcre and some more packages. Now you have to cross compile three (or more) other packages to compile curl.

I've had times when I ended up cross compiling a dozen packages when I initially set out for one. Fret not, soon it won't seem too hard and later it will be part and part of your development life. Now that we have covered the basics, let us jump into the actual topic.

# Cross-Compilation techniques

You might be surprised at the number of ways in which you can get something cross-compiled. As explained above, its just a matter of exporting a bunch of variables to your shells environment and then initiating the compilation process. In the following sections we will see some of the popular methods.

## Autotools based subsystems

Autotools does put some method to the madness. If you aren't familiar with autotools, you can get an overall idea in [this stackoverflow answer][5]. The `configure` and `config.guess` scripts seem to have taken away much of the incoherence and standardized the system. Most of the time, it's just `./cofigure CC=arm-linux-gnueabihf-gcc` followed by the usual `make`. Obviously, it comes with a learning curve, that is made a lot simpler if you are familiar with pure make systems.

### Understanding host, target, and build

To work effectively with autotools, you will need to clearly distinguish the terms, host, target and build. Do note that from the compilers perspective, there are some slight variations in the definitions of these terms. For the sake of simplicity we will leave that out for now.

**host:** The system that is going to run the software once it is built.

**build:** The system where the build process is being executed. When cross-compilation, this cannot be the same as host.

**target:** This is a rather confusing option: this specifies where the software being built will run on interacting with another architecture. Simply put, this option is used only when you are building toolchains/debuggers for the host. Confused? well you could read about [the Canadian cross][6], to get a better picture.

This only exists, or rather has a meaning, when the software being built may interact specifically with a system that differs from the one it's being executed on (our host). This is the case for compilers, debuggers, profilers and analyzers and other tools in general.

### Install prefix

Of course, `configure` can do a lot more that that depending on what all the project has be setup for. One of the most useful argument to configure script is the `--prefix=path/to/install/direcory/` this is useful if you are installing to a non-standard path (which you will most of the time in an embedded perspective).

## Pure make based subsystems

Plain GNU Make recipes with no flavors is called pure make based subsystems. Pure make systems are probably the most cluttered method of cross-compilation. This is due to the fact that, the make subsystem doesn't impose any rules on how things have to be done. As a result, each project came up it's own way to skin the cat.

But don't lose hope, it's not as bad as it sounds. Somehow the community has settled down with some broad rules/methods. But there will still be the occasional outliers who will force you to dig deeper into the makefiles. Depending on the project, you will have to resort one or many of the methods below.

### Exporting compiler prefix

Cross compiler binaries are usually named in the format `arch-platform-abi-gcc`. An example of that would be `arm-linux-gnueabihf-gcc`. Here we can see that the gcc is prefixed with `arm-linux-gnueabihf-`.

You are expected to export `CROSS_COMPILE=arm-linux-gnueabihf-` and then perform the build.

Pretty straightforward right? wait, now comes the annoying part. Some projects prefer to export `CROSS_COMPILE=arm-linux-gnueabihf`, ie., without the trailing `-` character.

Personally, I prefer the one with the hyphen in it as it allows me to do,

```make
CC := $(CROSS_COMPILE)gcc
AR := $(CROSS_COMPILE)ar
```

This way, when I don't export anything to `CROSS_COMPILE`,  I end up  compiling for host machine as `CC` would evaluate to just `gcc`.

### Exporting toolchain path

In most places, you don't really export toolchain path separately. You pass the compiler prefix and the underlying make system expects to find the toolchain in your system's environment (usually the `PATH` variable). But this approach doesn't scale very well when you have more than one compiler with the same name. Therefore, some projects expect you to explicitly state the toolchain path.

Usually its is called `TOOLCHAIN_PATH` but there is no said rule on this. it can vary from project to project you will have to look into the makefile and/or the documentation to see what it is expecting.

### Exporting absolute path to cross-compiler:

In projects that do not take `TOOLCHAIN_PATH`, it can be particularly hard if you have more than one compiler of the same name installed in your computer. One way to deal with this, is to keep only the path to the compiler you plan on using in your environment's `PATH`.

There is also another way to deal with such scenarios: you could pass an absolute path to the cross-compiler to the make system as,

```shell
export CC=/opt/arm/gcc-6.3.1linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc
```

This approach (IMHO) is cleaner as you don't have to fiddle with the systems `PATH` variable.

Now that we have a fair idea of the different practices that are followed, we can lay down some rules/guidelines to make a project cross compilation friendly.

# Guidelines for cross-compilation

Before you make a project cross compilation friendly, think _if_ the project needs to work on a machine (host) that is not the machine it which it was built for (build).

For example, the [GLCD Emulator (GLEM)][7] that I created is almost always meant to be operated on the build machine as it is a tool that helps creating embedded GUI during development phase. On the other hand, for a project like [limpid][8], I knew cross-compilation has to be a design goal as the library is expected to be used for communication/integration with embedded applications.

## Allow make variables to be overridden

In makefiles, use the conditional assignment operator `?=` (assign only if not set) as apposed to regular assignments such as `=` and `:=` wherever necessary. This give the users the ability to override some of your variables from command line like so, `CC=arm-linux-gcc make all`.

## Don't hard code anything

This is true for paths, compiler names, tool names, etc., If you need to access some tool, conditionally assign it to a variable and then use that instead.

Some people feel the need to hard code the PWD in their make recipes as they did not [understand the difference between `=` and `:=`][10] and getting the PWD seemed impossible at that time. As it turn out, this is rookie mistake and turns off people. Just take the longer route and read and understand the difference.

## Verbosely list all dependencies

Listing all external dependencies of a project is a good starting point for cross compilation. This gives your users an estimate of the effort needed to your code compiled to their host. It also reduces the number of emails you get asking for clarifications.

## Stick to the generic stuffs

This is more of a note on portability. If you plan on having a wider coverage for your project, you should stick to things that are generic read about [POSIX][9].

For instance, if you want your project to be able to run on a windows platform (sinful as it can be), you might want to stay aways from stuffs like Unix domain sockets.

## Don't over engineer

One of the common mistakes that people do when staring off a project is to start big, use your sense of proportion.

Don't employ auto tools for a small project (sub 50k lines of code) it just adds too much clutter to your working directory. Don't adopt a multi-makefile chaining solution for sub 10k lines of code project, a single makefile would do perfectly fine.

## Provide for more than one way to skin the cat

People like to have more than one way to get a project cross compiled. This can be due to a variety of reasons, it may be just be that they have a personal preference (I do). Or they may already have a build system in place that provides some interface for cross compilation and would like to integrate with minimum to no code change.

This may not always come in handy given the number of ways there exists, but its certainly better than having only one.

## Documentation

This is probably this single most important thing to do in your project if you expect others to work/contribute on top of it. A single README file form you on the top level of the repository explaining the working with a preliminary cross-compilation example will be a huge help for anyone attempting to use your project.

Never, ever, skimp of this.

# Conclusion

To wrap it all up, I think I've covered most of what came to my mind about cross compilation. Like I said earlier, at the end of the day, it all boils down to a bunch of exports followed by a make. But surprisingly enough, a lot of people get stuck here. Hopefully this article helped some people get over their fear/fret for cross compilation. Leave your feedback/suggestions in the comments section below.

```text
Edit History:
30 Aug 2018 - Correct heading levels to match new styles
```

[1]: https://en.wikipedia.org/wiki/Cross_compiler
[2]: https://en.wikipedia.org/wiki/Endianness
[3]: https://en.wikipedia.org/wiki/Data_structure_alignment
[4]: https://en.wikipedia.org/wiki/Word_(computer_architecture)
[5]: https://stackoverflow.com/a/26832773/8294130
[6]: https://en.wikipedia.org/wiki/Cross_compiler#Canadian_Cross
[7]: https://github.com/cbsiddharth/glem
[8]: https://github.com/cbsiddharth/limpid
[9]: https://en.wikipedia.org/wiki/POSIX
[10]: https://www.gnu.org/software/make/manual/html_node/Flavors.html#Flavors
[11]: /cross-compilation-demystified/#what-is-the-need-for-cross-compilation
