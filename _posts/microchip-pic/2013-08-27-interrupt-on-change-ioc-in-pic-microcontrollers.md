---
title: "Interrupt On Change (IOC) in PIC Microcontrollers"
date: 2013-08-27T18:27:26+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /interrupt-on-change-ioc-in-pic-microcontrollers/
dsq_thread_id: "2728571858"
category: "Microchip PIC"
tags: [ "Basics", "Theory" ]
---

The interrupt on change is a cool feature on microcontrollers. Like you guessed, the interrupt occurs when there is a state change in any of the port pin associated with this feature. In PIC microcontrollers, PORT B  has the Interrupt on Change feature. The controller jumps into the interrupt vector when there is a change in the state of any of the pins in the port.

In my previous post on [interfacing matrix keypad](/interface-4x4-matrix-keypad-with-microcontroller/), we used the conventional polling technique to poll for the data. In this post we will see how the same task can be done with interrupt on change. This is probably the best example that I can think of for demonstrating the interrupt on change feature as the entire PORT B is used by the keypad.

The keypad is not always used in the system. It is mostly used while staring up the system or making some configuration settings. In either case it is used for a small fraction of the controller's up time, so checking it in each run is purely a waste of time. Lets see how this can be done with interrupts.

### Whats an Interrupt?

An interrupt is a way of letting the controller know that something important happened without having it to look at the possibility each time. This saves a lot of time; time spent in checking for that event. Besides saving time, it is more accurate in reading that event without any sampling issues.

The idea is this, either you can keep looking at the power indicator on the wall and check if the power is back or switch on the fan and be notified once it is there.

### Modifying the code to work with IOC

There was not much to change in the code that we wrote for the matrix keypad interface [here](/interface-4x4-matrix-keypad-with-microcontroller/). If you open that code in a separate window and compare it with this code you will see that there is not much difference between them. The major working logic of that program has been moved into the ISR and some IOC related configuration is made in the main program.

**Note:** The code in the [4x4 matrix keypad interface](/interface-4x4-matrix-keypad-with-microcontroller/) was written for the C18 compiler and this one below is for the HI-Tech C Compiler for PIC Microcontrollers. If you are not familiar with this compiler, have a look at my previous post on [migrating to the Hi-Tech C compiler](/migrating-to-hi-tech-c-compiler-from-the-microchip-c18-compiler/) its not really that difficult.

```c
// Matrix Keypad Interface with Interrupt on Change  /////////////////////////
#include <p18f4520.h>
#include "delay.h"
#pragma config OSC=HS,WDT=OFF,FCMEN=ON,XINST=OFF,IESO=OFF,LVP=OFF

#define HIGH 1
#define LOW 0
#define R1 PORTBbits.RB0
#define R2 PORTBbits.RB1
#define R3 PORTBbits.RB2
#define R4 PORTBbits.RB3
#define C1 PORTBbits.RB4
#define C2 PORTBbits.RB5
#define C3 PORTBbits.RB6
#define C4 PORTBbits.RB7
#define SEG_EN1 LATCbits.LATC1
#define SEG_EN2 LATCbits.LATC0

unsigned char val;

void update(unsigned char);
void seg_wrt();

void main(void)
{
    ADCON1 = 0x0F;      // Disable all analog channel
    TRISD = 0x00;       // PORT D Output
    TRISC = 0x00;       // PORT C output
    TRISB = 0xF0;       // PORT B upper nibble Input Lower Nibble Output
    LATD = 0X00;        // 7 Segment port.
    LATC = 0x00;        // all segment enables pins are off
    LATB = 0xF0;        // Initial value for keypad port

    RBPU = LOW;         // Enable Weak internal pull-ups in pin RB4 and RB5
    RBIE = HIGH;        // Enable PORT B interrupt
    RBIF = LOW;         // PORT B interrupt flag
    GIE = HIGH;         // Global Interrupt enable.

    while(1){
	// Add code
        seg_wrt();
    }
}	// End of void main()

void interrupt IOC_ISR(void)
{
    if(RBIF && RBIE)
    {
	   LATB = 0xf0;
        if(C1 == LOW){
            R1 = HIGH;
            if(C1 == HIGH)
                update(16);
            else {
                R2 = HIGH;
                if(C1 == HIGH)
                    update(15);
                else {
                    R3 = HIGH;
                    if(C1 == HIGH)
                        update(14);
                    else update(13);
		}
            }
	}
	if(C2 == LOW){
            R1 = HIGH;
            if(C2 == HIGH)
            	update(12);
            else {
            	R2 = HIGH;
            	if(C2 == HIGH)
                    update(11);
                else{
                    R3 = HIGH;
                    if(C2 == HIGH)
                        update(10);
                    else update(9);
            	}
            }
	}
	if(C3 == LOW){
            R1 = HIGH;
            if(C3 == HIGH)
            	update(8);
            else {
            	R2 = HIGH;
            	if(C3 == HIGH)
                    update(7);
              	else{
                    R3 = HIGH;
                    if(C3 == HIGH)
                        update(6);
                    else update(5);
            	}
            }
	}
	if(C4 == LOW){
            R1 = HIGH;
            if(C4 == HIGH)
            	update(4);
            else {
            	R2 = HIGH;
            	if(C4 == HIGH)
                    update(3);
                    else{
                    	R3 = HIGH;
                    	if(C4 == HIGH)
                            update(2);
                        else update(1);
            	}
            }
	}

	LATB = 0xF0;
	RBIF = LOW;
    }

}

void update(unsigned char data)
{
    val = data;
}

void seg_wrt() {
    unsigned char lookup[]={
        0x3f,0x06,0x5b,0x4f,0x66,
        0x6d,0x7d,0x07,0x7f,0x6f
    };
    long unit,ten;
    long idx = 0;
    unit = val/10;
    ten = val%10;
    for(idx=0;idx<100; idx++)
    {
    	LATD = lookup[unit];
    	SEG_EN1 = HIGH;
    	DelayUs(100);
    	SEG_EN1 = LOW;
    	LATD = lookup[ten];
    	SEG_EN2 = HIGH;
    	DelayUs(100);
    	SEG_EN2 = LOW;
    }
}
```

As far as the hardware is considered, there is absolutely no change and the output is also essentially the same. Only, now you have the while (1) loop all for yourself.

### Wrapping up!

This Interrupt on change feature can actually be considered as 8 separate external interrupts that are mapped on to the same interrupt vector. The only drawback is that there is no way to prioritize the interrupts. But cheer up!! you can always use it in applications that can tolerate some time lag in servicing the ISR.
