---
id: 1685
title: Standalone BreadBoard Breakout for PIC Microcontrollers
date: 2013-08-09T15:39:03+00:00
author: Siddharth
layout: post
permalink: /breadboard-breakout-for-pic-microcontrollers/
dsq_thread_id: "3298312963"

image: /wp-content/uploads/2013/08/DSC09678.jpg
categories: [ "Embedded Systems", "PIC Microcontroller" ]
tags: [ "circuit design", "DIY", "PIC" ]
---

I wanted to make a breadboard breakout for PIC microcontrollersA after seeingA thisA <a title="visit adafruit.com" href="http://www.adafruit.com/products/91" target="_blank">arduino breadboard breakout from adafruit</a>. This product is fully standalone and yet has very small footprint so that it can be conveniently plugged into the breadboard. The most amazing part was that it still had 2 rows on each side of the breadboard for the user to jump wires.

First I thought of making a breakout board for the 40 Pin DIP package that I usually use. Then I realized that is was almost impossible to fit the controller & its circuitry and still have pace on the breadboard for other use. So I decided to use the 28 PIN package (similar to the arduino) to have a fair game.

This is the image of the fully standalone breadboard breakout for Microcontrollers that I made earlier today. By saying fully standalone I mean to say that the board doesn't need any other external component for the controller to work (except ofcourse the power supply). This board, like the adafruit's board also leaves 2 rows on the breadboard for the user.

[<img class="aligncenter size-large wp-image-1688" alt="DSC09673" src="/images/posts/2013/08/DSC09673-1024x576.jpg" width="618" height="347" srcset="/images/posts/2013/08/DSC09673-1024x576.jpg 1024w, /images/posts/2013/08/DSC09673-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/08/DSC09673.jpg)

One major challenge I faced while making this board is the lack board room. I wanted to give it the same feel as the adafruit's breakout board. Hence, the dimensions of the board wereA already decided. I also did not want the board to look really messy with wires jumping here and there on the top side. On the bottom side I obviously cannot have wires jumping around as it has to be plugged into the breadboard.

### Circuit Diagram

The one thing that has to be appreciated with PIC microcontrollers is that they maintain uniform PIN arrangements. This is not just true in between controllers of the same series but controller with same pin count.

For example, I built this board for PIC 18F2550 and this is perfectly compatible with PIC 16F72

[<img class="aligncenter size-full wp-image-1692" alt="circuit" src="/images/posts/2013/08/circuit.png" width="724" height="441" srcset="/images/posts/2013/08/circuit.png 724w, /images/posts/2013/08/circuit-300x183.png 300w" sizes="(max-width: 724px) 100vw, 724px" />](/images/posts/2013/08/circuit.png)

This is the circuit that I had to get into the perf board. The male headers had to be soldered to the bottom side while the others remain on the upper side. After a lot modifications and alterations, I was able to get the circuit into the perf board.

### Cheat Sheet

The board can be powered off the Pickit 2 or can be externally powered with the power connector. It has an on-board reset switch, crystal, ICSP connector and power indicator.

<p style="text-align: center;">
  <a href="/images/posts/2013/08/parts.jpg"><img class="aligncenter  wp-image-1690" alt="parts" src="/images/posts/2013/08/parts.jpg" width="691" height="389" srcset="/images/posts/2013/08/parts.jpg 960w, /images/posts/2013/08/parts-300x169.jpg 300w" sizes="(max-width: 691px) 100vw, 691px" /></a>
</p>

<p style="text-align: left;">
  Port A is as usual analog and has only 6 pins. Port B and C are 8 bit wide and are separately addressable. Port C is broken into two nibbles (high and low). You can also see that there is a lot of room for prototyping on the breadboard after the breakout board has been inserted.
</p>

<h3 style="text-align: left;">
  Another Look
</h3>

Here is the back side of the board. Inspite of my best efforts, I could not do without a wire in the bottom side. Its a little messy, but solves the purpose very well.

<p style="text-align: center;">
  <a href="/images/posts/2013/08/DSC09682.jpg"><img class="aligncenter  wp-image-1687" alt="DSC09682" src="/images/posts/2013/08/DSC09682.jpg" width="738" height="414" srcset="/images/posts/2013/08/DSC09682.jpg 1920w, /images/posts/2013/08/DSC09682-300x169.jpg 300w, /images/posts/2013/08/DSC09682-1024x576.jpg 1024w" sizes="(max-width: 738px) 100vw, 738px" /></a>
</p>

<p style="text-align: left;">
  This board occupies a very small space on the breadboard, which allows us to use the remaining space for other peripherals. It is also really useful for rapid prototyping and proof of concepts. I look forward to do a lot of projects with this breakout board in future.
</p>