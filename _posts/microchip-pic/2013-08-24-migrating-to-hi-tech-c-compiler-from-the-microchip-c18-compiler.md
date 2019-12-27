---
title: "Migrating to HI-TECH C Compiler from the Microchip C18 Compiler"
date: 2013-08-24T21:39:52+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /migrating-to-hi-tech-c-compiler-from-the-microchip-c18-compiler/
dsq_thread_id: "3292578747"
category: "Microchip PIC"
tags: [ "Tools" ]
---

Migrating to [HI-TECH C compiler](http://www.microchip.com/stellent/idcplg?IdcService=SS_GET_PAGE&nodeId=1406&dDocName=en535448) for PIC MCU is not really a hard task. The developers have taken much care in keeping it that way. In addition to the existing features of the C18 compiler, there are a lot of other added features in the HI-TECH C compiler. This post will give you an introduction to the compiler, its features and how to write C programs in it.

This compiler can be used to program all 8 bit PIC MCUs. There is one compiler for [PIC 18](http://www.microchip.com/stellent/idcplg?IdcService=SS_GET_PAGE&nodeId=1406&dDocName=en542861) series and another for [PIC 10/12/16](http://www.microchip.com/stellent/idcplg?IdcService=SS_GET_PAGE&nodeId=1406&dDocName=en542849) series. You can choose the compiler based on the family of controller that you are working with. Most of the time the code is interchangeable between the compilers, only the device specific references such as the configuration bits and SFRs may differ.

### Why the HI-TECH C compiler?

{% include image.html src="HTSoft.gif" %}

The Microchip C18 compiler has been around for quite some time and has a lot documentation and device specific library functions. Yet, I feel that the HI-TECH C compiler is much more elegant and easy to program. Some of the major features are listed below.

  1. You no longer have to write PORTBbits.RB0 to access PORT B pin 0. Just use RB0 and you are done. Now this saves a lot of time and gives more readability to the code. The same is true for all SFRs (INTCONbits.GIE is now just GIE). The reason is that the previous method used structures (more specifically bit-fields) to access the port pins. Now the individual bits are mapped on to their respective addresses.
  2. Using Interrupts in your code can never be this easy. You can create an ISR like you would create a function and place the keyword 'interrupt' in between the return type and function name.
  3. Functions like printf() & scanf() are now available in HI-TECH C compiler under the header file stdio.h. The c18 compiler does not have this feature.
  4. In C18 compiler global data chunks larger than 256 bytes cannot be accommodated without having to modify the linker scripts. I had one hell of a time adding fonts for a GLCD code I wrote some time back. On the other hand, the HI-TECH C compiler takes care of the work for you.
  5. If you are a linux user, HI-TECH C compiler has a good integration.
  6. There are no device specific header files in the HI-TECH C compiler. You just have to include htc.h to all your source codes. The compiler determines which device you are using from the project properties and includes the necessary headers. This reduces the time taken to port the code form one device to another.
  7. Some people have reported to have better code optimization with this compiler. I have neither verified it personally nor did I verify the authenticity of the information (I came across this information in a forum thread).

### Install the compiler

You can download the lite version of the compiler. A lite version compiler is sufficient for any hobby project that you can think off. If you ever feel that a lite version compiler is not good enough for the work you are doing, start optimizing your code to run fast or occupy less space. If you still can't reduce the size, the project is no longer a hobby project and you ought to buy a pro version and start selling your product.

Follow the on screen instruction to install the compiler. Check the options to add the path to the MPLAB environment variables so that the IDE knows where you have installed the compiler.

### Working with HI-TECH C compiler

After the installation, you can see the compiler in the list of available compilers when creating a new project in the IDE. Choose this compiler and choose next. After the project is created, add a C source file and start coding your C program.

In all the programs, you will have to add this line, `#include<htc.h>` this will include header file for the PIC MCU that you choose while creating the project. Once this is added you will have to add code for the configuration bits. This is really important and most of the time, it will prevent the program from executing if you forget to add the pragma for the configuration bits. I will write a tutorial on configuration bits, their purposes and uses some time soon.

```c
#pragma config OSC=HS,WDT=OFF,FCMEN=ON,XINST=OFF,IESO=OFF,LVP=OFF
```

After this its the user's space and you can add code and include custom header files. You can address the bits of SFRs with their name as they appear in the data sheet. here is an example code that I wrote to demonstrate the features of the compiler.

Timer 0 is configured to interrupt every 20 milliseconds. In the ISR the LED pin (RD0) is toggled every 5th time the interrupt occurs. hence this gives a delay of 100 milliseconds.

```c
#include<htc.h>
#pragma config OSC=HS,WDT=OFF,FCMEN=ON,XINST=OFF,IESO=OFF,LVP=OFF

void interrupt Timer_ISR(void)
{
    if (TMR0IF && TMR0IE)
    {
        static unsigned char ctr;
        if(ctr%4 == 0)
        {
            TMR0H = 0x9E;       // preload for Timer0 MSB
            TMR0L = 0x58;       // preload for Timer0 LSB
            TMR0IF = 0;
            if(RD0 == 1)
            RD0 = 0;            // LED OFF
            else
            RD0 = 1;            // LED ON
        }
        ctr++;
        }
}

void main()
{
    ADCON1 = 0x0F;
    TRISD = 0x00;
    T08BIT = 0;       // Timer0 8-bit/16-bit Control bit
    T0CS   = 0;       // TMR0 Clock Source Select bit
    T0SE   = 0;       // TMR0 Source Edge Select bit
    PSA    = 0;       // Prescaler Enable bit
    T0PS2  = 0;
    T0PS1  = 0;       // Prescaler set to 1:4
    T0PS0  = 1;
    TMR0H = 0x9E;     // preload for Timer0 MSB
    TMR0L = 0x58;     // preload for Timer0 LSB
    PEIE = 1;         // peripheral interrupt enable
    TMR0IE = 1;       // Timer Interrupt enable
    GIE = 1;          // global interrupt enable
    TMR0ON = 1;       // Timer0 On/Off Control bit
    while(1){
    // do nothing here the ISR will handle the bit toggle
    }
}
```

I hope this post was, to an extent, helpful in getting started with developing embedded software with HI-TECH C compiler.
