---
id: 821
title: "Workaround for 'SD Card Initialization Failed!' in Arduino"
date: 2013-06-19T16:33:08+00:00
author: Siddharth
layout: post
permalink: /arduino-sd-card-initialization-failed/
dsq_thread_id: "2728571509"

image: /wp-content/uploads/2013/06/DSC09425.jpg
categories: [ "Arduino", "Embedded Systems", "How-To's" ]
tags: [ "arduino", "embedded system", "sd card" ]
---

[
  
<img class="aligncenter size-large wp-image-828" src="/images/posts/2013/06/DSC09425-1024x576.jpg" alt="Arduino sd card" width="618" height="347" srcset="/images/posts/2013/06/DSC09425-1024x576.jpg 1024w, /images/posts/2013/06/DSC09425-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/06/DSC09425.jpg)

I was working on a project that involved the use of a SD (Secure Digital) card to log data into a text file. I chose Arduino as it A had a vary stable FAT (File Allocation Table) library. I had an Arduino Mega at my disposal and built a resistive network to step down the logic levels of the Arduino SPI bus at 5v to the SD card's at 3v3. I was getting voltage levels that were withing the absolute maximum ratings of the SD card.

I have some experience with Arduino in the past (all good ones), and I expected things to work out of the box. But to my surprise I was mistaken. When I burned one of the example sketch to check the Card Info, I got this error "SD card initialization failed".

<pre>Initializing SD card initialization failed. Things to check:
* is a card is inserted?
* Is your wiring correct?
* did you change the chipSelect pin to match your shield or module?</pre>

Then after some research I discovered that, the Arduino SD library is just a colorful wrapper for theA <a title="sd fat library" href="https://code.google.com/p/sdfatlib/" target="_blank">SDfatlib</a>, and the actual library has much more options and can be used to debug properly. When I tested the quick start sketch form the newly installed library, I got this error message,

<pre>SD chip select is the key hardware option.
Common values are:
Arduino Ethernet shield, pin 4
Sparkfun SD shield, pin 8
Adafruit SD shields and modules, pin 10

Enter the chip select pin number: 4

SD card initialization failed.
Do not reformat the card!
Is the card correctly inserted?
Is chipSelect set to the correct value?
Is there a wiring/soldering problem?
errorCode: 0x1, errorData: 0x0

Restarting...</pre>

One after the other I tried all their example sketches without any luck. Then as usual I suspected my resistive network, especially after reading thisA _"Is there a wiring/soldering problem?".A _Built another one and then another! Yet the problem persisted.

I read in some forum posts that the resistive network introduces a latency in the SPI bus and could be the reason for the problem. So I decided to buy a low costA <a title="datasheet" href="http://www1.futureelectronics.com/doc/WIZNET%20INC/W5100.pdf" target="_blank">W5100</a>A Ethernet shield which has a SD card slot (Image of which is featured in the heading of this post).

Most of the Ethernet shields have SD card slot, it would be pointless buying one without it. But again the problem was not solved. It took me a while to find out the solution.

<div class="box success  ">
  <div class="box-inner-block">
    <i class="fa tie-shortcode-boxicon"></i> The solution to this problem, is that you have to let digital Pin 10 as output (for the SD library to work) and put out a logic HIGH by addingA "digitalWrite(10,HIGH);". For Arduino Mega you have to do exactly the same ignore pin 53 completely though the comment asks you to change it to 53. A 
  </div>
</div>

So after making the change, the CardInfo sketch should look like this.

<pre class="">/*************** Some code Here *************************/
Serial.print("\nInitializing SD card...");
// On the Ethernet Shield, CS is pin 4. It's set as an output by default.
// Note that even if it's not used as the CS pin, the hardware SS pin
// (10 on most Arduino boards, 53 on the Mega) must be left as an output
// or the SD library functions will not work.


/********************* Add these Two Lines **********************/
pinMode(10, OUTPUT); // change this to 53 on a mega A // don't follow this!!
digitalWrite(10, HIGH); // Add this line
/***************************************************************/


// we'll use the initialization code from the utility libraries
// since we're just testing if the card is working!
/*************** Some code Here *************************/</pre>

Good news is that you can add this line to all the code and it works perfectly fine (atleast for me).A I hope this solves the "SD Card Initialization Failed" problem. If you notice any other problem please leave a comment and I will get back to you.A <a href="http://embedjournal.com/subscribe/" target="_blank">Subscribe to our posts and newsletters</a>A to stay updated with the upcoming series of this tutorial.
