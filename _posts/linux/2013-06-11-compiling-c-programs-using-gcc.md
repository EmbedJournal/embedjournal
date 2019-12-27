---
title: "Compiling C Programs Using GCC"
date: 2013-06-11T23:22:10+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /compiling-c-programs-using-gcc/
dsq_thread_id: "3290507807"
category: "Linux"
tags: [ "CLI" ]
---

{% include image.html src="gnu-gcc.png" %}

C is the most widely used programming language for Embedded Systems. Even today most of the low level tasks of operating systems are done in C. Linux is a native C environment and so, the two together make a good pair and cannot be easily missed. C is a high level language and hence needs a compiler to compile the the code into machine understandable language.

The most widely used compiler is the GCC (GNU C Compiler). It was released in the year 1987 and was the first component to be taken up by GNU. GCC is not just a compiler for C but it is a collection of compilers for a variety of languages such as, C, C++, Java and some more languages. This post will be restricted to compiling C programs with GCC toolchain.

You can always have a cool development environment to compile C in just one click. But that spoils all the fun doesn't it? Well not just the fun but the insight you will get on how things are done underneath the GUI is totally lost. Most people who use GCC due to the compulsion  of a curriculum in colleges seem to know just these line to compile and execute a program.

```shell
$ gcc filename.c
$ ./a.out
```

Well if you are one of them, all I can say is you are missing the whole point even if it is a completely legal compilation. Let us get started with examining the above commands before going into the details.

This `gcc filename.c` is the bare minimum you have to add so that your program is compiled. Someone felt you are not smart enough to know what is really needed. In Linux, the 	`gcc` is a command and what ever follows it with a hyphen prefix is a option to that program.

There are numerous options in Linux for each command and it is impossible to know all the options. So don't bother to learn all of them at a time, just start with what you really need and keep adding to the stack.

In Linux file system, the current working directory is referred to as . (dot) and its parent directory is referred to as .. (dot dot).  Hence the statement `./a.out` is used to execute a file called `a.out` in the current working directory. The file `a.out` is created as the name of the output executable file if no specific output file name was given during compilation.

The file name a.out is really annoying. especially if you are compiling more than one C program in the CWD (current working directory) then each time the new executable file will overwrite the existing one.

And yeah, Linux doesn't pop up saying "there is another file with the same name do you what to replace it" :-). Besides all these you might want to give your output file a sensible name to identify it later on.

Here is how to specify the output file name during compilation and execute it likewise,

```shell
$ gcc filename.c -o executable.file
$ ./executable.file
```

#### **Suggestions:**

Most people have a feeling that if the program runs they don't have to worry about the warnings it may throw. Warnings are given for a reason and play a vital role. They mean that you have bent the rules some where in your program and it might break at some point in future. So it is advisable to use the -Wall option along with your compilation so that it will point all warnings.

If you are lazy (like me) to write gcc -Wall each time you can add an alias to gcc as gcc -Wall in the .bashrc file in the home directory. This can be done by adding this line anywhere in that file,

```shell
alias gcc='gcc -Wall'
```

This line essentially replaces 'gcc' with 'gcc -Wall' is a command line equivalent of C macros. Think of all your repeated options and add them to that file makes life much simpler.

#### **Probable Pitfalls:**

Auto complete in the command prompt is a cool feature. But on the down side, is that if you get too habitual you might type "gcc filename.c -o fil" and hit <kbd>Tab</kbd> to auto finish, it as `gcc filename.c -o filename.c` and hit Enter, Oops, you are replacing the C Source file (filename.c) with the executable file (filename.c). You can say goodbye to your source code there is no way to retrieve it.

What I have written in this post is just an introduction to GCC and how to work with them. There is a lot more than this.. and just for your information, the manual page of GCC is a little over 45,000 lines. If I am not mistaken it has one the longest man pages in the whole of Linux. So spend some time reading about GCC and how to use it.
