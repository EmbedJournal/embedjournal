---
title: "Getting Started with PIC Microcontrollers"
date: 2013-10-13T08:04:33+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /getting-started-with-pic-microcontrollers/
dsq_thread_id: "3290736684"
category: "Microchip PIC"
tags: [ "Intro" ]

gallery:
  - src:  mplab-x-create-1.png
    name: "Step One"
  - src:  mplab-x-create-2.png
    name: "Step Two"
  - src:  mplab-x-create-3.png
    name: "Step Three"
  - src:  mplab-x-create-4.png
    name: "Step Four"
  - src:  mplab-x-create-5.png
    name: "Step Five"
  - src:  mplab-x-create-6.png
    name: "Step Six"
  - src:  mplab-x-create-7.png
    name: "Step Seven"
---

Having worked with any one Microcontroller, moving from one of its family to another is  just a matter of knowing the right tools and understanding how things have to be done in terms of software (compiler specific addressing like that of the SRFs) and hardware (circuitry, design practices, etc., ) In this post we will have a look at everything you will need while getting started with PIC microcontrollers.

### Things you will need,

Here is a very small list of things that you will need to start working with PIC micros.

  1. The Microcontroller
  2. Datasheet for that device
  3. A suitable programmer tool
  4. MPLAB IDE and a C compiler.
  5. A computer with internet connection
  6. And some basic electronic components and tools

### Getting the hardware ready,

This is step zero towards working on any embedded platform. You MUST have the hardware at your disposal. You can either buy an evaluation board for your device or make one on a perf board. Fortunately, there is not much work needed to have a bare bone version of the evaluation board with just the absolute necessary components. For any given controller, you will need to build the reset circuit, plug in a crystal oscillator and power it up for it to  standalone. You might want to add a little ICSP connector to program the chip without having to pull it off its socket but then its not really needed if you are okay with pulling the controller off the circuit each time you have to reprogram it. Otherwise there is nothing that is really needed for the operation of the controller. Beyond this, it's all application specific stuff and will change from one project to another.

For simplicity you can make something like this that conveniently sits on a breadboard allowing you to do all the prototyping on the breadboard.

{% include image.html src="breadboard-breakout-part.jpg" post="2013-08-09-breadboard-breakout-for-pic-microcontrollers" %}

As you can see the above board has only what is needed (except the power LED) on it and it has a very small footprint. To make such a circuit, all you need is the datasheet to tell you which pin is for what. Most of the time there is an application circuit in the datasheet very close to the pin description or in the corresponding chapters Eg., the oscillator circuit will probably be there in the section devoted to the external oscillators.

### Programmer/Debugger Tool

{% include image.html src="pickit2.png" %}

There are a lot of programmers for the PIC micros. One of the most commonly used programmer/debugger is the PICkit . It has a lot of  cool features like acting as a serial monitor and logic analyzer. It was really stable and rugged. Like they say, good things are not meant to last. I some how managed to brick my PICkit 2 a few weeks back. That's when I bought this attractive, supposedly upgraded version of the PICkit 2... The all new PICkit 3!! There are a lot of drawbacks in this product and the cost was a little more than the its predecessor. I already knew all its drawbacks, but listening to all of it form David Jones in his video blog (<http://www.eevblog.com/>) at one stretch, reduced my impression further. If you are planing to buy this product then I suggest you to see the video I have attached below. **Be warned**, He gives it the "most retarded product award" at the end the video. If you have already ordered it, think twice before watching it.

{% include youtube.html src="LjfIS65mwn8" %}

Now that we have all the cons,  let us look on it's brighter side. It has support for more devices and future devices from Microchip. Microchip has already stopped support for PICkit2 in some of its newer devices. Presently there are a handful of chips that are not compatible with PICkit 2 in a year or so there will probably be a lot in that list. Besides, all the problems that are currently there could be fixed with a simple software update. The hardware is what that cannot be changed. Whether Microchip gives us the update or the user community cracks it open for us is a question that only time can answer.

### Setting up the IDE

The next thing that you will have to worry about is the development environment. Download the Mplab X or Mplab 8 IDE form the [microchip website](http://www.microchip.com/stellent/idcplg?IdcService=SS_GET_PAGE&nodeId=1406&dDocName=en019469&part=SW007002). The page is fully populated with details of the new Mplab X IDE. If you happen to be one of those classic Mplab 8 lovers you'll have to scroll down to the very bottom of the page to find an unobtrusive link to Mplab v8.X Download any one of those IDEs and install them in your computer. The next thing to do would be to download one of the compiler that Microchip offers. Here is a list of all the compiler that they provide.

* C18 Compiler
* Hitech C compiler
* XC 8 Compiler

Here at EmbedJournal we use all the above compilers interchangeably. All of them are almost the same and have minor differences. The C18 compiler has been around for some time and has a lot of sample code and libraries. The XC 8 is an advancement over the c18 compiler and hence offers more features. While installing the compilers, install it in the default directory and ask it to add the path to Mplab's environment variables. By doing this you just let your IDE know that there is compiler installed and ready to be used.

### New Project! New File!

The next thing to do will be to create a new project workspace and start populating it with your source code. Here is a step by step image gallery that will help you do it. During the creation of the project you will have to specify the device, programmer and the compiler you are going to be using for the project. Though all the parameters can be changed from the project properties window, it is advisable to have already installed the compiler and decided upon the device you are going to be working on.

{% include gallery.html list=page.gallery %}

Once you have created the workspace and the new file you can write your program or take a sample hello world program and build it to make sure everything is in it place. Once you have a fully built error free code, you can either program it to the controller or debug in with the debugger.

### Programming/ Debugging your code:

Microchip PIC micros can be programmed and debugged directly from the IDE without having to use any other tools (that is if you are using one of the standard programmer or their clone). If you happen to be using one of those third party tools with serial interface, I'm afraid you have reached an impasse here. <span style="text-decoration: underline;"><strong>Programmer ToolBox</strong></span> On the top you will see a set of icons like this one here. It's the build and program window. This is the window that you will most probably work with most of the time. The icons based on the numbers given to them are explained below.

{% include image.html src="mplab-x-programming-window.png" %}

1. **Build** - This is used to build your project. It builds those parts that was changes since the last buld.
2. **Clean Build** - This deletes the intermediate files created by previous builds and rebuilds the entire project.
3. **Program** - Programs the HEX file into the controller
4. **Read** - Read the device memory
5. **Hold in Reset** - The MCLR pin is held LOW
6. **Build for Debugging** - A special type of build for debugging.

<span style="text-decoration: underline;"><strong>Debugger ToolBox</strong></span> If you are planning to debug your code, you will have to build it specially for the debugger session. The code is compiled and then converted into an image and this image is burnt into the device. This image will have information of all the breakpoints that you put on your code. You are allowed to use three break points as a lite user. From what I see 3 breakpoints are just enough for almost all the work if you use them wisely. If you already have any experience in using a debugger then this is nothing far from it. Again you can find the icons explained according to their numbers.

{% include image.html src="mplab-x-debugger-window.png" %}

1. **Finish Debug** - Stops the execution of user program in the target
2. **Pause** - Pauses the execution of user program in the target
3. **Reset**  - Resets the target memory to POR values.
4. **Continue** - Executes the user program in the target
5. **Step Over** - Runs over a particular loop without animating into it. Useful when there is a delay loop.
6. **Step Into** - Move into a particular loop and animate into it.
7. **Run to Cursor** - The program runs up to the cursor and halts there.
8. **Set PC at Cursor** - It sets the PC to the point where the cursor is placed
9. **Focus Cursor at PC** - Moves the cursor to the location pointed by the PC

I hope this article was helpful to an extent for beginners and those who want to migrate into the PIC family of controllers. If you feel that I have missed something or if something is not clear, leave a comment below and I will get back as soon as possible.
