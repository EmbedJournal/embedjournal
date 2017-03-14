---
title: Getting Started with PIC Microcontrollers
date: 2013-10-13T08:04:33+00:00
author: Siddharth
layout: post
permalink: /getting-started-with-pic-microcontrollers/
dsq_thread_id: "3290736684"
categories: [ "Embedded Theory", "Microchip PIC" ]
tags: [ "Intro" ]
---

Having worked with any one Microcontroller, moving from one of its family to another is A just a matter of matter knowing the right tools and understanding how things have to be done in terms of software (compiler specific addressing like that of the SRFs) and hardware (circuitry, design practices, etc., ) In this post we will have a look at everything you will need while getting started with PIC microcontrollers.

### Thing you will need,

Here is a very small list of things that you will need to start working with PIC micros.

  1. The Microcontroller
  2. Datasheet for that device
  3. A suitable programmer tool
  4. MPLAB IDE and a C compiler.
  5. A computer with internet connection
  6. And some basic electronics components and tools

### Getting the hardware ready,

This is step zero towards working on any embedded platform. You MUST have the hardware at your disposal. You can either buy an evaluation board for your device or make on A a perf board. Fortunately, there is not much work need to have a bare bone version of the evaluation board with just the absolute necessary components. For any given controller, you will need to build the reset circuit, plug in a crystal oscillator and power it up for it work standalone. You might want to add a little ICSP connector to program the chip without having to pull it off its socket but then its not really needed if you are okay with pulling the controller off the circuit each time you have to reprogram it. Otherwise there is nothing that is really needed for the operation of the controller. Beyond this, its all application specific stuffs and will change from one project to another.

<p style="text-align: left;">
  For simplicity sake you can make something like this that conveniently sits on a breadboard allowing you to do all the prototyping on the breadboard.
</p>

<p style="text-align: center;">
  <a href="/images/posts/2013/08/parts.jpg"><img class="aligncenter  wp-image-1690" src="/images/posts/2013/08/parts.jpg" alt="parts" width="768" height="432" srcset="/images/posts/2013/08/parts.jpg 960w, /images/posts/2013/08/parts-300x169.jpg 300w" sizes="(max-width: 768px) 100vw, 768px" /></a>
</p>

<p style="text-align: left;">
  As you can see the above board has only what is needed (except the power LED) on it and it has a very small footprint. To make such a circuit, all you need is the datasheet to tell you which pin is for what. Most of the time there is an application circuit in the datasheet vary close to the pin description or in the corresponding chapters Eg., the oscillator circuit will probably be there in the section devoted to the external oscillators.
</p>

<h3 style="text-align: left;">
  Programmer/Debugger Tool
</h3>

[<img class="wp-image-1957 alignright" src="/images/posts/2013/10/pickit2.png" alt="pickit2" width="275" height="410" srcset="/images/posts/2013/10/pickit2.png 492w, /images/posts/2013/10/pickit2-202x300.png 202w" sizes="(max-width: 275px) 100vw, 275px" />](/images/posts/2013/10/pickit2.png)There are a lot lot of programmers for the PIC micros. One of the most commonly used and programmer/debugger is the PICkit 2.A It has a lot cool features like acting as a serial monitor and logic analyzer. It was really stable and rugged. Like they say,A good things are not meant to last. I some how managed to brick my PICkit 2 a few weeks back. That's whenA I bought this attractive, supposedly upgraded version of the PICkit 2... The all new PICkit 3!! There are a lot of drawbacks in this product and the cost was a more than the its predecessor. I already knew all its drawbacks, but listening to all of it form David Jones in his video blog (<http://www.eevblog.com/>) at one stretch, reduced my impression further. If you are planing to buy this product then I suggest you to see the video I have attached below. **Beware**: He gives it the "most retarded product award" at the end the video. If you have already ordered it, think twice before watching it.



Now that we have all the cons some of the pros are,A support for more device and future devices from Microchip. Microchip has already stopped support for PICkit2 in some of its newer devices. Presently there are a handful of chips that are not compatible with PICkit 2 in a year or so there will probably be a lot to that list. Besides, all the problems that are currently there could be fixed with a simple software update. The hardware is what that cannot be changed. Whether Microchip guys give us the update or the user community cracks it open for us is a question that only time can answer.

<h3 style="text-align: left;">
  Setting up the IDE
</h3>

The next thing that you will have to worry about is the development environment. Download the Mplab X or Mplab 8 IDE form the <a title="Visit page" href="http://www.microchip.com/stellent/idcplg?IdcService=SS_GET_PAGE&nodeId=1406&dDocName=en019469&part=SW007002" target="_blank">microchip website</a>. The page is fully populated with details of the new Mplab X IDE. If you happen to be one of those classic Mplab 8 lovers you'll have to scroll down to the very bottom of the page to find an unobtrusive link to a Mplab v8.X Download any one of those IDE's and install them in your computer. The next thing to do would be to download one of the compiler that Microchip offers. Here is a list of all the compiler that they provide.

  * C18 Compiler
  * Hitech C compiler
  * XC 8 Compiler

Here at EmbedJournal we use all the above compilers interchangeably. All of them are almost the same and have minor differences. The C18 compiler has been around for some time and has a lot of sample code and libraries. The XC 8 is an advancement over the c18 compiler and hence offers more features. While installing the compilers, install it in the default directory and ask it to add the path to Mplab's environment variables. By doing this you just let your IDE know that there is compiler installed and ready to be used.

### New Project! New File!

The next thing to do will be to create a new project workspace and start populating it with your source code. Here is a step by step image gallery that will help you do it. During the creation of the project you will have to specify the device, programmer and the compiler you are going to be using for the project. Though all the parameters can be changed from the project properties window, it is advisable to have already installed the compiler and decided upon the device you are going to be working on.

<div id='gallery-12' class='gallery galleryid-1936 gallery-columns-5 gallery-size-thumbnail'>
  <figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-create-1.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-create-1-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-create-2.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-create-2-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-create-3.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-create-3-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-create-4.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-create-4-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-create-5.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-create-5-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-create-6.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-create-6-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-create-7.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-create-7-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-new-file-1.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-new-file-1-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-new-fine-2.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-new-fine-2-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/10/mplab-x-new-fine-3.png'><img width="150" height="150" src="/images/posts/2013/10/mplab-x-new-fine-3-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure>
</div>

Once you have created the workspace and the new file you can write your program or take a sample hello world program and build it to make sure everything is in it place. Once you have a fully built error free code, you can either program it to the controller or debug in with the debugger.

### Programming/ Debugging your code:

Microchip PIC micros can be programmed and debugged directly from the IDE without having to use any other tools (that is if you are using one of the standard programmer or their clone). If you happen to be using one of those third party tools with serial interface, I'm afraid you have reached an impasse here. <span style="text-decoration: underline;"><strong>Programmer ToolBox</strong></span> On the top you will see a set of icons like this one here. It's the build and program window. This the window that you will most probably work with all the time. The icons based on the numbers given to them are explained below.

<p style="text-align: center;">
  <a href="/images/posts/2013/10/mplab-x-programming-window.png"><img class="size-full wp-image-1966 aligncenter" src="/images/posts/2013/10/mplab-x-programming-window.png" alt="mplab x programming window" width="239" height="65" /></a>
</p>

  1. **Build** - This is used to build your project. It builds those parts that was changes since the last buld.
  2. **Clean Build** - This deletes the intermediate files created by previous builds and rebuilds the entire project.
  3. **Program** - Program the HEX file into the controller
  4. **Read** - Read the device memory
  5. **Hold in Reset** - The MCLR pin is held LOW
  6. **Build for Debugging** - A special type of build for debugging.

<span style="text-decoration: underline;"><strong>Debugger ToolBox</strong></span> If you are planning to debug your code, you will have to build it specially for the debugger session. The code is compiled and then converted into an image and this image is burned into the device. This image will have information of all the breakpoints that you put on your code. You are allowed to use three break points as a lite user. From what I see 3 breakpoint is just enough for almost all the works if you use them wisely. If you already have any experience in using a debugger then this is nothing far from it. Again you can find the icons explained according to their numbers. [<img class="aligncenter size-full wp-image-1965" src="/images/posts/2013/10/mplab-x-debugger.png" alt="mplab x debugger" width="287" height="60" />](/images/posts/2013/10/mplab-x-debugger.png)

  1. **Finish Debug** - Stops the execution of user program in the target
  2. **Pause** - Pauses the execution of user programA in the target
  3. **Reset** A - Resets the target memory to POR values.
  4. **Continue** - Executes the user program in the target
  5. **Step Over** - Runs over a particular loop without animating into it. Useful when there is a delay loop.
  6. **Step Into** - Move into a particular loop and animate into it.
  7. **Run to Cursor** - The program runs up to the cursor and halts there.
  8. **Set PC at Cursor** - It sets the PC to the point where the cursor is placed
  9. **Focus Cursor at PC** - Moves the cursor to the location pointed by the PC

I hope this article was helpful to an extent for beginners and those who want to migrate into the PIC family of controllers. If you feel that I have missed something or if something is not clear, leave a comment below and I will get back as soon as I can.