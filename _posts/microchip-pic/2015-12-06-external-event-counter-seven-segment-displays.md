---
title: "External Event Counter - Seven Segment Displays"
date: 2015-12-06T21:30:12+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /external-event-counter-seven-segment-displays/
dsq_thread_id: "2701807862"
popular_post: true
category: "Microchip PIC"
tags: [ "Interface", "Theory" ]
---

External event counters are pretty useful things to have around. Once I had a feud with a shopkeeper for selling 4 motors in 3 different RPMs. Well, I don't know if you have ever tried making a robot that had wheels rotating at different speeds, I did. It wasn't a very memorable experience.

A The shopkeeper agreed that the RPM on one of the motors was of a different RPM and other 'slightly-off' but the others where just fine. It took me a lot of time to convince him that his definition of 'slight' was just unacceptable.

Anyway, I brought that up because, external event counters can be used for a variety of reasons. One of them is to make your own tachometer (and I did it) to prove your argument in a street fight. But of-course you need to be jobless to start with.

In my previous post we discussed the basic [interface seven segment displays](/interface-7-segment-display-with-microcontroller/) and how the concept of persistence of vision can be used to used to decrease the pin count of the embedded device.

Counters can either count up from zero or count down to zero. In the embedded space, down counter gives a marginal improvements in performance as most processors have a decrement and jump if not zero kind of instructions. But don't worry, that was just "fun facts" you don't have to worry about it. Your optimizing C compiler will take care that for you.

In this post, we will discuss a basic application of the concept that we discussed earlier and proceed along to make a physical counter that keeps track of an external event (key press).

First, we will take up the task to write different data into all the 4 digits of the 7 segment display. Let's say we want to print 1234 on the display. Here is a flow chart that will help you better understand the concept of persistence of vision (POV).

{% include image.html src="pov-seven-segment-display.png" %}

So if you write 1 to the data bus and enable the first segment, you will have to do the first step. Likewise, write 2 to data bus and enable the second segment. Similarly do the third and fourth step. Once this cycle is finished, repeat the above steps at a frequency, for the sake of argument, lets say 50 Hz.

If you did it correctly, you should see a static 1234 appear over the 4 digits of the 7 segment display. This is how you should program the above logic.

```c
#include <xc.h>
#include <stdint.h>
#include "delays.h"

#pragma config OSC=HS,WDT=OFF,FCMEN=ON,XINST=OFF,IESO=OFF,LVP=OFF

/*
* Hardware connetions,
* PORT B is connected to the 7 segment display
* PORT c Pins 0, 1, 2 , 3, are used as enable pins for segments
*/

void main()
{
    uint8_t lookup[] = {
        0x3f,0x06,0x5b,0x4f,0x66,
        0x6d,0x7d,0x07,0x7f,0x6f
    };
    int idx,idy;
    ADCON1=0x0F;
    TRISB = 0x00;
    TRISC = 0x00;
    while(1)
    {
        idy=0x08;
        for(idx=1;idx<=4;idx++){
            LATB = lookup[idx];
            LATC = idy;
            idy = idy >> 1;
            dealy_ms(5);
        }
    }
}
```

Here is a small video that I made to demonstrate the working of the above procedure.

{% include youtube.html src="IpFqXNPH1NU" %}

### Event Counter

Now that the persistence of vision section has been dealt with, we can get started with the counter. For this post we will use a micro switch for providing the input to the microcontroller. But in practical application any digital input (such as that from a IR interruption system) can be used to increment the counter.

Here is a flowchart to help you understand the working of the counter. Since the controller runs endlessly in a while(1) loop, there is not Stop block in the flowchart.

{% include image.html src="flowchart.png" %}

In the main function, the controller first checks if there is a counter overflow condition. If there is overflow, it will reset it back to 0. After this it tests the state of the input switch. If the switch is pressed, it increments the counter. After this, it send the value of the counter to the seg_wrt() function to write the data to the display.

Here is a program to implement the above logic in embedded C.

```c
#include <xc.h>
#include <stdint.h>
#include "delays.h"

#pragma config OSC = HS,WDT=OFF,FCMEN=ON,XINST=OFF,IESO=OFF,LVP=OFF

/*Macro For Segment Enable Pins*/
#define SEG_EN1 LATCbits.LATC1
#define SEG_EN2 LATCbits.LATC0
#define SWITCH PORTDbits.RD0

void seg_wrt(unsigned char);

void main()
{
    unsigned char ctr = 0; // Counter variable
    ADCON1 = 0x0F; // Make all pins Digital
    TRISC = 0x00; // Enable Pins
    TRISB = 0x00;
    TRISD = 0x0F; // 7 segment data Port
    while(1) {
        if (ctr%99 == 0)
            ctr = 0;        // reset the counter if it reaches 100
        if (SWITCH == 1) {
            // In here if switch pressed.
            ctr++;          // increment the counter.
            delay_ms(20);   // bebounce the press.
        }
        seg_wrt(ctr);
    }
}

/*Function to write data in the 7 segment display*/
void seg_wrt(unsigned char val)
{
    uint8_t lookup[] = {
        0x3f,0x06,0x5b,0x4f,0x66,
        0x6d,0x7d,0x07,0x7f,0x6f
    };
    int unit,ten;
    int idx = 0;
    unit = val/10; // separate the two digit data into units and tens
    ten = val%10;
    for(idx=0;idx<1000; idx++) {
        LATB = lookup[unit]; // write the units place
        SEG_EN1 = 1; // Segment 1 ON
        delay_ms(10);
        SEG_EN1 = 0; // Segment 1 OFF

        LATB = lookup[ten]; // write the tens place
        SEG_EN2 = 1; // Segment 2 ON
        delay_ms(10);
        SEG_EN2 = 0; // Segment 2 OFF
    }
}
```

Here is a demonstration of the above procedure,

{% include youtube.html src="7EUbdQuakY4" %}

I hope this post was helpful in understanding the interface of 7 Segment Displays and how they can be used to display numeric data. In the upcoming posts we will start working with these displays to make some real projects.

**Edit History**:

  * Article first published 15th Aug 2013
  * Code updated to xc8 compiler and republished 6th Dec 2015
