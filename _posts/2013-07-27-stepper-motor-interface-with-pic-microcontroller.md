---
id: 1404
title: Stepper Motor Interface with PIC Microcontroller
date: 2013-07-27T07:25:12+00:00
author: Siddharth
layout: post
permalink: /stepper-motor-interface-with-pic-microcontroller/
dsq_thread_id: "2701808208"

image: /wp-content/uploads/2013/07/DSC09500.jpg
categories: [ "Embedded Systems", "PIC Microcontroller" ]
tags: [ "basics", "stepper motor", "theory" ]
---

In my previous postA <a href="http://embedjournal.com/2013/07/stepper-motor-and-how-they-work/" target="_blank">Introduction to Stepper Motors and How they Work</a>, we had a look at stepper motors and how they work. This post will deal with the programming and circuitry involved in the stepper motor interface with PIC Microcontrollers.

Usually a microcontroller is used to produce the stepping sequence for the stepper motor. But this is not the only method of producing the stepping sequence.A It can be produced by using flip flops, logic gates and some knowledge about digital electronics. But this post will deal with the former method as it is better and easier.

### Need for Driver Circuits

Your microcontroller works at 5V and the stepper motor will need 12V to operate. So the microcontroller port pins can't drive the motor on their own. They need something called as the driver circuit. This circuit typically takes low level signal from controller and converts them to high voltage/current signals that are capable of exciting the stator windings.

Depending on the current and voltage requirement of the stepper motor, the driver circuit has to be built.A For this post, I will be using the smallest stepper motor that I have with me. This is just to avoid building dedicated power diver circuits.

If you don't have a small one, you will need driver circuit. For now I will assume you do have a small motor with you. If you don't, I will write a tutorial on making a driver circuit sometime in the foreseeable future.<figure id="attachment_1291" style="width: 618px" class="wp-caption aligncenter">

[<img class="size-large wp-image-1291" title="The stepper motor that I am using." src="/images/posts/2013/07/DSC09490-1024x576.jpg" alt="Stepper motor" width="618" height="347" srcset="/images/posts/2013/07/DSC09490-1024x576.jpg 1024w, /images/posts/2013/07/DSC09490-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/07/DSC09490.jpg)<figcaption class="wp-caption-text">The stepper motor that I am using.</figcaption></figure> 

### Entire Setup

<p style="text-align: left;">
  Here is the set up that I made for the interface. For a change I thought I will build this circuit over a breadboard instead of the conventional development board setup in my posts.A It took more time and looks a lot messier, but some things are worth the time spent over it. This is a fully standalone circuit which just needs a 12V supply.
</p><figure id="attachment_1293" style="width: 618px" class="wp-caption aligncenter">

[<img class="size-large wp-image-1293" title="Stepper Motor along with its entire setup on a breadboard" src="/images/posts/2013/07/DSC09500-1024x576.jpg" alt="stepper motor interface" width="618" height="347" srcset="/images/posts/2013/07/DSC09500-1024x576.jpg 1024w, /images/posts/2013/07/DSC09500-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/07/DSC09500.jpg)<figcaption class="wp-caption-text">Stepper Motor along with its entire setup on a breadboard</figcaption></figure> 

### The Circuit:

Here is the top view of the breadboard.A I have separated the circuit into various sections. Below are the schematics of each of the blocks mentioned. Click them to enlarge. I think its quiet self explanatory and nothing more needs to be said.

[<img class="aligncenter size-large wp-image-1388" src="/images/posts/2013/07/DSC09507-1024x576.jpg" alt="DSC09507" width="618" height="347" srcset="/images/posts/2013/07/DSC09507-1024x576.jpg 1024w, /images/posts/2013/07/DSC09507-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/07/DSC09507.jpg)

<div id='gallery-11' class='gallery galleryid-1404 gallery-columns-3 gallery-size-thumbnail'>
  <figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/line-follower-robot/power-supply-2/'><img width="150" height="150" src="/images/posts/2013/06/power-supply-150x150.png" class="attachment-thumbnail size-thumbnail" alt="power supply" aria-describedby="gallery-11-1603" /></a>
  </div><figcaption class='wp-caption-text gallery-caption' id='gallery-11-1603'> 5 volt Power Supply </figcaption></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/line-follower-robot/pic-basic-2/'><img width="150" height="150" src="/images/posts/2013/06/pic-basic-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-11-1602" /></a>
  </div><figcaption class='wp-caption-text gallery-caption' id='gallery-11-1602'> PIC standalone schematic </figcaption></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/stepper-motor-interface-with-pic-microcontroller/uln2003/'><img width="150" height="150" src="/images/posts/2013/07/uln2003-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-11-1501" /></a>
  </div><figcaption class='wp-caption-text gallery-caption' id='gallery-11-1501'> Stepper Motor Driver Circuit </figcaption></figure>
</div>

### Programming

The programming is really simple and can be done with just a few lines of C code. But before you go into it, you should have read my previous post on the <a title="Introduction to Stepper Motors and How they Work!" href="http://embedjournal.com/2013/07/stepper-motor-and-how-they-work/" target="_blank">stepper motor basics</a>A to understand the program fully.

In the following program I have included all the three types of stepping sequences in three arrays that are selectable with Macros. Hence to use the code for full step mode, you will have to make define a macro, FULL_STEP

For those who don't already know, <span style="color: #808000;">#ifdef MACRO_NAME</span> checks if macro <span style="color: #808000;">MACRO_NAME</span> is defined. If so, the lines that are in between theA <span style="color: #808000;">#ifdef MACRO_NAME</span> and <span style="color: #808000;">#endif</span>A statements are added to the program. If such a macro is not defined, then the lines in between the <span style="color: #808000;">#ifdef MACRO_NAME</span> and <span style="color: #808000;">#endif</span>A statements are commented out.

So basically, it is a if statement but in terms of pre-processing. Needless to say, the same logic applies to the if-else statements.

<pre lang="c" class="">/*
 * File Name: stepper.c
 * Author: Siddharth Chandrasekaran
 * Created on July 14, 2013, 7:47 PM
 * LCD Library For C18 compiler and PIC advanced 8 bit CPUs
 * Visit http://embedjournal.com for more codes.
*/
#include<p18f4520.h>
#include<delays.h>

#pragma config WDT=OFF,OSC=HS, LVP=OFF, IESO=OFF, FCMEN=ON, XINST=OFF

#define DELAY 10
#define HALF_STEP    // change this for the mode of excitation.

#ifdef HALF_STEP
#define SEQ 8
#else
#define SEQ 4
#endif
#ifdef WAVE_DRIVE
unsigned char stepping_seq[4]={0b00001000, 0b00000100, 0b00000010, 0b00000001};
#endif
#ifdef FULL_STEP
unsigned char stepping_seq[4]={0b00001100, 0b00000110, 0b00000011, 0b00001001};
#endif
#ifdef HALF_STEP
unsigned char stepping_seq[8]={0b00001000, 0b00001100, 0b00000100, 0b00000110, 
                               0b00000010, 0b00000011, 0b00000001, 0b00001001};
#endif

void main()
{
    unsigned char count = 0;
    TRISD = 0x00;
    while(1)
    {
        if (count == SEQ)
           count = 0;
        LATD = stepping_seq[count];
        Delay10KTCYx(DELAY);
        count++;
    }
}</pre>

### Video of the stepper motor in action!

In this video, I have used the wave type stepping sequence. I'm sure there is not much noticeable difference between the various types of stepping sequence so I didn't bother to record all of them. You can also see the change in speed with the change in delay in between each step.



<p style="text-align: left;">
  <a href="http://embedjournal.com/subscribe/" target="_blank">Subscribe to our blog</a>A with your email and like us on Facebook to get instant notification of updates on our latest posts and how-to tutorials delivered to your inbox.
</p>