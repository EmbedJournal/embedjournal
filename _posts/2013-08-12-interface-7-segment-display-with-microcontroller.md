---
title: Interface 7 Segment Display with Microcontroller
date: 2013-08-12T19:15:44+00:00
author: Siddharth
layout: post
thumbnail: post-thumb.png
permalink: /interface-7-segment-display-with-microcontroller/
dsq_thread_id: "2701815486"
categories: [ "Embedded Theory" ]
tags: [ "Basics", "Interface", "Theory" ]
---

The 7 segment display is widely used to display numeric data. They are limited by the number of segments (LEDs) they have and hence are not suitable for displaying text. There are some variants of this kind of displays that have 11 segments which enables them to display text also.

[<img class="aligncenter size-full wp-image-1705" src="/images/posts/2013/08/name.png" alt="name" width="509" height="318" srcset="/images/posts/2013/08/name.png 509w, /images/posts/2013/08/name-300x187.png 300w" sizes="(max-width: 509px) 100vw, 509px" />](/images/posts/2013/08/name.png)

This post will deal with the basics of 7 segment displays and how to interface them with microcontrollers. As the name suggests, there are 7 segments to display a number and an additional decimal point. These are essentially LEDs that turn on according to the excitation given by the controller that gives the appearance of the number.

These segments are named with alphabets A through G with a DP (Decimal Point) or in some cases an eighth alphabet H. These 8 pins corresponding to each of the segments are connected to the port pins of a microcontroller.

While addressing these segments, (in most cases) A is the LSB and DP(H) is the MSB. If you are using a development board, you should read it's documentation before addressing them.

### Types of 7 Segment Displays

**Are there two of 'em?**

Yes, there are two types of 7 segment displays. They look alike and there is no way to tell which one you have by just seeing it. If you desoldered it from somewhere, hope you have some marking over it. Though it is not impossible, you will have a difficult time making out what-is-what without part names.

[<img class="aligncenter size-full wp-image-1708" src="/images/posts/2013/08/Types-7-segment-displays.png" alt="Types 7 segment displays" width="795" height="354" srcset="/images/posts/2013/08/Types-7-segment-displays.png 795w, /images/posts/2013/08/Types-7-segment-displays-300x134.png 300w" sizes="(max-width: 795px) 100vw, 795px" />](/images/posts/2013/08/Types-7-segment-displays.png)

These types are based on which type of pin each LED is tied together. If all the cathodes are grouped to give a singe cathode it called **Common Cathode** type displays. Similarly there is a **Common Anode** type which as the name suggests, has the cathode of all the LED put together to form a single cathode.

### Wiring them up to a Microcontroller

Here is the circuit diagram my development board has. I guess this is the best way to connect these displays. Any other method I can think of uses more pins for the microcontroller.

[<img class="aligncenter size-full wp-image-1704" src="/images/posts/2013/08/circuit1.png" alt="circuit" width="674" height="467" srcset="/images/posts/2013/08/circuit1.png 674w, /images/posts/2013/08/circuit1-300x208.png 300w, /images/posts/2013/08/circuit1-110x75.png 110w" sizes="(max-width: 674px) 100vw, 674px" />](/images/posts/2013/08/circuit1.png)

 

This connection has a common data bus for all the segments and has a separate enable line for each segment that is used to turn ON and turn OFF that particular segment.

So far it appears as though, only one segment can be used at time as the data lines are shared with all the 4 segments.

ie., If you latch something to the data bus, and enable all the pins,(send it a logic HIGH from the MCU) then the same data will be displayed on all the four segments.

If that were the case, then the whole point of having a 4 digit display would be lost. That is when we will exploit the disability (well not exactly) of the human eye.

### Concept of Persistence of Vision (POV)

The human eye has the ability to hold a memory of light signal for some time after they are gone. Put it numerically, your eye will hold the light signal for a little over one quarter of a second. This time is directly proportional to the brightness of the light signal.

So if you turn ON and OFF a light faster than that, you won't be able to notice the light going OFF. Our microcontroller instructions are operated in a few hundred nanoseconds, toggling a pin or a set of pins at 50 or 60 Hertz is no big deal.

Here is a small video to demonstrate the concept of POV,



### Logic to use all the 4 digits of the display

To use all the 4 displays to display 4 different data at the same time, you should follow this sequence.

  1. <span style="line-height: 16px;">Write data to be displayed to Segment 1 into the data latch.</span>
  2. Enable First Segment.
  3. Wait for some time.
  4. Disable First Segment.
  5. Write the data for the next segment.
  6. Enable the Next Segment
  7. Wait for some time.
  8. Disable that Segment
  9. Do it for all the segments
 10. Repeat all the above steps.

This way you will be able to use all the 4 digits to do some useful work. The key is to know how fast is enough. If you are running too fast, it's a waste of processor time which prevents any other useful work from happening.

### Framing the data

The data (bitmap) has to be sent to the 7 segment display from the controller through the data bus. So we have to have a pre determined set of bitmaps for the numbers that we would be using.

In any kind of application, it's good practice to have a Look-up-Table for the data to be displayed on the 7 segment. The data to be displayed has to be framed separately for common cathode and common anode type displays

<table style="width: 100%;" border="5" frame="box" rules="all" cellspacing="0" align="CENTER">
  <tr align="center" valign="middle">
    <td style="background-color: #81bd00;" colspan="10">
      <strong>Common Cathode Configuration</strong>
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      <strong>Number To display</strong>
    </td>
    
    <td>
      <strong>H</strong>
    </td>
    
    <td>
      <strong>G</strong>
    </td>
    
    <td>
      <strong>F</strong>
    </td>
    
    <td>
      <strong>E</strong>
    </td>
    
    <td>
      <strong>D</strong>
    </td>
    
    <td>
      <strong>C</strong>
    </td>
    
    <td>
      <strong>B</strong>
    </td>
    
    <td>
      <strong>A</strong>
    </td>
    
    <td>
      <strong>HEX</strong>
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x3F
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x06
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      2
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x5B
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      3
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x4F
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      4
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      0x66
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      5
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x6D
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      6
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x7D
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      7
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x07
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      8
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x7F
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      9
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x6F
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td style="background-color: #81bd00;" colspan="10">
      <strong>Common Anode Configuration</strong>
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td style="border: 1px;">
      <strong>Number To display</strong>
    </td>
    
    <td>
      <strong>H</strong>
    </td>
    
    <td>
      <strong>G</strong>
    </td>
    
    <td>
      <strong>F</strong>
    </td>
    
    <td>
      <strong>E</strong>
    </td>
    
    <td>
      <strong>D</strong>
    </td>
    
    <td>
      <strong>C</strong>
    </td>
    
    <td>
      <strong>B</strong>
    </td>
    
    <td>
      <strong>A</strong>
    </td>
    
    <td>
      <strong>HEX</strong>
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      0xC0
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      0xFC
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      2
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      0xA4
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      3
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      0xB0
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      4
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      0x99
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      5
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      0x92
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      6
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      0x82
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      7
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      0xF8
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      8
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      0x80
    </td>
  </tr>
  
  <tr align="center" valign="middle">
    <td>
      9
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      0x90
    </td>
  </tr>
</table>

### Look Up Table

Once you have all the values to be written to the display you have to create the lookup table. The lookup table is nothing but an array which has all the above values. So the code looks into this array and fetches the data to be written to the display.

<pre class="lang:c decode:true">// For Common Cathode Configuration
unsigned char lookup[10]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
// For Common Anode Configuration
unsigned char lookup[10]={0xc0,0xfc,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90};</pre>

So a reference to lookup[5] will return the actual display equivalent of 5 for the 7 segment display.

In upcoming posts we will discuss a lot more about the programming of 7 segment displays.
