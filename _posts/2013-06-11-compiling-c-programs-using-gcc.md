---
title: Compiling C Programs Using GCC
date: 2013-06-11T23:22:10+00:00
author: Siddharth
layout: post
permalink: /compiling-c-programs-using-gcc/
dsq_thread_id: "3290507807"
categories: [ "Linux" ]
tags: [ "CLI" ]
---

<p style="text-align: center;">
  <a href="/images/posts/2013/06/gcc_sm.png"><img class="aligncenter  wp-image-615" alt="gcc_sm" src="/images/posts/2013/06/gcc_sm.png" width="330" height="392" srcset="/images/posts/2013/06/gcc_sm.png 550w, /images/posts/2013/06/gcc_sm-253x300.png 253w" sizes="(max-width: 330px) 100vw, 330px" /></a>
</p>

C is the most widely usedA programming language for Embedded Systems. Even today most of the low level tasks of operating systems are done in C. Linux is a native C environment and so, the two together make a good pair and cannot be easily missed. A C is a high level language and hence need a compiler to compile the the code into machine understandable language.

The most widely used compiler is the GCC (GNU C Compiler). It was released in the year 1987 and what the first component to be taken up by GNU. GCC is not just a compiler for C but it is a collection of compilers for a variety of languages such as, C, C++, Java and some more languages. This post will be restricted to compiling C programs with GCC toolchain.

You can always have a cool development environment to compile C in just one click. But that spoils all the fun doesn't it? Well not just the fun but the insight you will get on how things are done underneath the GUI is totally lost. Most people who use GCC due to the compulsion A of a curriculum in colleges seem to know just theses line to compile and execute a program.

`siddharth@desktop$ gcc filename.c<br />
siddharth@desktop$ ./a.out`

Well if you are one of them, all I can say is you are missing the whole point even if it is a completely legal compilation. Let us get started with examining the above commands before going into the details.

This "_gcc filename.c"_A is the bare minimum you have to add so that your program is compiled. Someone felt you are not smart enough to know what is really needed. In Linux, the '_gcc'_A is a command and what ever follows it with a " - " prefix is a option to that program.

Example, "_gcc -Wall filename.c_" A is '_gcc'_ command with '_-Wall_' option (enable all warnings)A to augment its functionality. A There are numerous options in Linux for each command and it is impossible to know all the options. So don't bother to learn all of them at a time, just start with what you really need and keep adding to the stack dYtm,

In Linux file system, the current working directory is refereed to as . (dot) and its parent directory is referred to as .. (dot dot). A Hence the statement "_./a.out_" is used to execute a file calledA _a.out_A in the current working directory. The file a.out is created as the name of the output executable file if no specific output file name was given during compilation.

The file name a.out is really annoying. especially if you are compiling more than one C program in the CWD (current working directory) then each time the new executable file will overwrite the existing one.

And yeah, Linux doesn't pop up saying "there is another file with the same name do you what to replace it" :-). Besides all these you might want to give you output file a sensible name to identify it later on.

Here is how to specify the output file name during compilation and execute it likewise,

`siddharth@desktop$ gcc filename.c -o executable.file<br />
siddharth@desktop$ ./executable.file`

#### **Suggestions:**

Most people have a feeling that if the program runs they don't have to worry about the warnings it may throw. Warnings are give for a reason and play a vital role. They mean that you have bent the rules some where in your program and it might break at some point in future. So it is advisable to use the -Wall option along with your compilation so that it will point all warnings.

If you are lazy (like me) to write gcc -Wall each time you can add a alias to gcc as gcc -Wall in the .bashrc file in the home directory. This can be done by adding this line anywhere in that file,

`alias gcc='gcc -Wall'`

This line essentially replaces 'gcc' with 'gcc -Wall' is a command line equivalent of C macros. Think all you all your repeated options and add them to that file makes life much simpler.

#### **Probable Pitfalls:**

Linus does not integrate file types with their extensions. That is, a file called virus.exe could be your shopping list with just some text and numbers. Linux has a feature of auto complete in the command prompt which works by hitting the Tab key. If you type "gcc fil" and hit Tab it will try to match "fil" to any possible file name in the CWD. If found it will auto complete the file name for you. Cool feature right??

Yes it is cool! but on the down side, if you get too habit oriented you might typeA "gcc filename.c -o fil" and hit the Tab key to auto finish it asA "gcc filename.c -o filename.c" and hit Enter. This means, you are replacing the C Source file (filename.c) with the executable file (filename.c). You can say goodbye to your source code there is no way to retrieve it.

What I have written in this post is just an introduction to GCC and how to work with them. There is a lot more than this.. and just for your information, the manual page of GCC is a little over 45,ooo lines if I am not mistaken it is one the longest manuals in the whole of Linux commands. So spend some time reading about GCC and how to use it. There are a lot many people who are better qualified than me to discuss this topic.