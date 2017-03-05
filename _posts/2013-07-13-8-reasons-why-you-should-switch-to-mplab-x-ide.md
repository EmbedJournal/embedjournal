---
id: 1216
title: 8 Reasons Why You Should Switch to MPLAB X IDE
date: 2013-07-13T12:40:39+00:00
author: Siddharth
layout: post
permalink: /8-reasons-why-you-should-switch-to-mplab-x-ide/
dsq_thread_id: "2728571357"

image: /wp-content/uploads/2013/07/Untitled3.png
categories: [ "PIC Microcontroller" ]
tags: [ "IDE", "review" ]
---

[<img class="aligncenter size-full wp-image-1201" alt="Untitled3" src="/images/posts/2013/07/Untitled3.png" width="473" height="300" srcset="/images/posts/2013/07/Untitled3.png 473w, /images/posts/2013/07/Untitled3-300x190.png 300w" sizes="(max-width: 473px) 100vw, 473px" />](/images/posts/2013/07/Untitled3.png)

The MPLAB X is an IDE for Microchip PIC microcontrollers. It has a lot of added features when compared to the older MPLAB IDE v8.xx. TheA MPLAB X is not a new version of the current MPLAB IDE v8 framework but is instead based onA [Oracle](http://en.wikipedia.org/wiki/Oracle_Corporation "Oracle Corporation")'s open-sourceA [NetBeans](http://en.wikipedia.org/wiki/NetBeans "NetBeans")A platform.

Old habits die hard they say, that's exactly what happens when you are migrating from one IDE to another for the same controller, you tend to have a hostile feeling. I still see some people have not switched over in spite of all the advertisement form Microchip. Here are 10 reasons (good reasons)A why you should change to MPLAB X IDE.

In each of the sections I have added images which you can click to enlarge.

### Docked workstation

[<img class="alignright size-medium wp-image-1205" alt="mplab x IDE" src="/images/posts/2013/07/mplab-x-IDE-300x161.png" width="300" height="161" />](/images/posts/2013/07/mplab-x-IDE.png) ****MPLAB X IDE has made a giant leap in terms of the docked workstation. This something that has to be marked as 'the' most important feature of the new IDE form Microchip. The older IDE had all the windows dangling around and was really not capable of handling projects with multiple files effectively. Here all the files of a project can be opened and tabbed.

Any window can be re sized to suit your need. You can also minimize all the windows to have only the code editor in the entire screen. The minimized windows appear as a popup and vanish after you are done with it.

### Ease of use

<p style="text-align: center;">
  <a href="/images/posts/2013/07/mplab-x-icons.png"><img class="size-full wp-image-1219 aligncenter" alt="mplab x icons" src="/images/posts/2013/07/mplab-x-icons.png" width="755" height="83" srcset="/images/posts/2013/07/mplab-x-icons.png 755w, /images/posts/2013/07/mplab-x-icons-300x33.png 300w" sizes="(max-width: 755px) 100vw, 755px" /></a>
</p>

With this IDE you don't have to remember the path of almost any tool. You can easily customize it to show in your front panel. The MPLAB X IDE already has all the frequently used tools in the front panel of the IDE. If you need more you could do so with a right click on the tools bar and choosing the customize option.

### Auto completion

[<img class="alignright  wp-image-1206" alt="mplab x include header file" src="/images/posts/2013/07/mplab-x-include-header-file-300x186.png" width="270" height="167" />](/images/posts/2013/07/mplab-x-include-header-file.png) The IDE has the auto complete feature that can be used to complete known header files and port pins without having to type it fully. As you start typing there is a box that drops down to have all the possible combination. You can ignore in and keep typing or choose one form the list. Since it shows all the list of possibilities, you will know if what you are doing is legal or not instantaneously.

If the header file or a port pin that you are trying to define does not exist, you will see a read mark on that line number indicating an error. This can be a little distinctive at first but you will get used to it soon.

### Macro and Variable Grouping

[<img class="alignright  wp-image-1223" alt="Macro grouping" src="/images/posts/2013/07/Macro-grouping-300x195.png" width="270" height="176" srcset="/images/posts/2013/07/Macro-grouping-300x195.png 300w, /images/posts/2013/07/Macro-grouping.png 506w" sizes="(max-width: 270px) 100vw, 270px" />](/images/posts/2013/07/Macro-grouping.png)This is another new feature of the MPLAB X IDE. If you place your cursor on any variable or a macro, it highlights all the other instances of the same variable. It also shows an indication on the scroll bar on all the other instances in case of a long file.

This feature is really helpful in debugging or porting code. In the picture, I have placed my cursor on one the variable index and you can see all its instances are shown up in the highlight.

### Live syntax checker

[<img class="alignright  wp-image-1225" alt="live code checker" src="/images/posts/2013/07/live-code-checker-300x161.png" width="270" height="145" />](/images/posts/2013/07/live-code-checker.png)There is a syntax checker that is running in the background that interprets your code line by line and checks the correctness of the syntax and the logic. It is capable of detecting some very common errors such as, undefined variable, unused variable and syntax error.

This also reduces the total number of errors you might have at the end of the compilation. Simply put, you won't have to correct a dozen typos and semi colons at compile time. In this example I have commented out the declaration of the variable index and you can how it reacts at all instances of index.

### Dashboard Window

[<img class="alignright  wp-image-1207" alt="mplab x program dashboard" src="/images/posts/2013/07/mplab-x-program-dashboard-251x300.png" width="176" height="210" />](/images/posts/2013/07/mplab-x-program-dashboard.png)The dashboard window is another inclusion in the MPLAB IDE. It has various useful information such as the RAM and EEPROM usage. it also gives a gist of the project properties. If you are working with multiple families of the PIC Microcontroller, this window will help you quickly understand which toolchain and programmer you have configured without having to the project properties.

It has a launcher for the project properties window, and an icon to refresh the debugger/programmer tool status. Another great feature is the icon for the data sheet launch. You can see a small PDF image in the left of the image. If you have a datasheet directory, you can give the path to this icon for launching the datasheet PDF file.

### One click Comment and Un-Comment of code

[<img class="alignright size-medium wp-image-1231" alt="one click comment" src="/images/posts/2013/07/one-click-comment-300x146.png" width="300" height="146" />](/images/posts/2013/07/one-click-comment.png)If you are testing a project, the most conventional method is to disable all the modules (sets of code) and test individual module and then recombine them. For doing this, the comment and un-comment button on the code editor can be used. with one click you are able to comment out large parts of code and revert back by selecting the commented out portion and clicking the un-comment button.

### Variable, headers and function Navigation

[<img class="alignright size-medium wp-image-1234" alt="navigation" src="/images/posts/2013/07/navigation-300x111.png" width="300" height="111" srcset="/images/posts/2013/07/navigation-300x111.png 300w, /images/posts/2013/07/navigation.png 700w" sizes="(max-width: 300px) 100vw, 300px" />](/images/posts/2013/07/navigation.png)This is another feature excursively available in the MPLAB X IDE alone. When you hover your mouse over a file included or a macro defined or a variable used, with the CTRL key pressed, you get a hyper link that can be clicked to navigate through the project to the place of declaration or to the file itself in case of the header files.

In this example I'm having the mouse over the `#include<Delays.h>` line. You can see that there is a pop up window that shows the location of the file in the hard disk. This line is now linked to the location of the file Delays.h and you can open it by clicking on it.

**To conclude**, some times in life, you will have to leave thing and move on. Now is the time to move on the more advanced IDE for the PIC microcontroller from it's manufacturers. Not all the modules available in the v8 have been ported into the MPLAB X IDE but most of it has been done and more are being done.

From what I read, microchip will stop support for v8 in the foreseeable future and you will anyways be forced to use the MPLAB X IDE. So it better be an action of choice than an action due to lack of options. In my upcoming post I will deal with the getting started with the MPLAB X IDE. <a href="http://embedjournal.com/subscribe/" target="_blank">Subscribe to our blog</a> with your email and get our posts delivered to your inbox.