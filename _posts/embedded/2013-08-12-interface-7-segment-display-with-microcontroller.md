---
title: "Interface 7 Segment Display with Microcontroller"
date: 2013-08-12T19:15:44+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /interface-7-segment-display-with-microcontroller/
dsq_thread_id: "2701815486"
category: "Embedded"
tags: [ "Basics", "Interface", "Theory" ]
---

The 7 segment display is widely used to display numeric data. They are limited by the number of segments (LEDs) they have and hence are not suitable for displaying text. There are some variants of this kind of displays that have 11 segments which enables them to display text also.

{% include image.html src="seven-segment.png" %}

This post will deal with the basics of 7 segment displays and how to interface them with microcontrollers. As the name suggests, there are 7 segments to display a number and an additional decimal point. These are essentially LEDs that turn on according to the excitation given by the controller that gives the appearance of the number.

These segments are named with alphabets A through G with a DP (Decimal Point) or in some cases an eighth alphabet H. These 8 pins corresponding to each of the segments are connected to the port pins of a microcontroller.

While addressing these segments, (in most cases) A is the LSB and DP(H) is the MSB. If you are using a development board, you should read it's documentation before addressing them.

### Types of 7 Segment Displays

**Are there two of 'em?**

Yes, there are two types of 7 segment displays. They look alike and there is no way to tell which one you have by just seeing it. If you desoldered it from somewhere, hope you have some marking over it. Though it is not impossible, you will have a difficult time making out what-is-what without part names.

{% include image.html src="common-anode-cathode-schematic.png" %}

These types are based on which type of pin each LED is tied together. If all the cathodes are grouped to give a singe cathode it called **Common Cathode** type displays. Similarly there is a **Common Anode** type which as the name suggests, has the cathode of all the LED put together to form a single cathode.

### Wiring them up to a Microcontroller

Here is the circuit diagram my development board has. I guess this is the best way to connect these displays. Any other method I can think of uses more pins for the microcontroller.

{% include image.html src="7-segment-multiplexed.png" %}

This connection has a common data bus for all the segments and has a separate enable line for each segment that is used to turn ON and turn OFF that particular segment.

So far it appears as though, only one segment can be used at time as the data lines are shared with all the 4 segments.

ie., If you latch something to the data bus, and enable all the pins,(send it a logic HIGH from the MCU) then the same data will be displayed on all the four segments.

If that were the case, then the whole point of having a 4 digit display would be lost. That is when we will exploit the disability (well not exactly) of the human eye.

### Concept of Persistence of Vision (POV)

The human eye has the ability to hold a memory of light signal for some time after they are gone. Put it numerically, your eye will hold the light signal for a little over one quarter of a second. This time is directly proportional to the brightness of the light signal.

So if you turn ON and OFF a light faster than that, you won't be able to notice the light going OFF. Our microcontroller instructions are operated in a few hundred nanoseconds, toggling a pin or a set of pins at 50 or 60 Hertz is no big deal.

In an older article, have already discussed [persistence of vision](/external-event-counter-seven-segment-displays/) at lengths. You can check that out if you have any uncertainties. Here is the video from that post, just in case you are too lazy to follow the link.

{% include youtube.html src="IpFqXNPH1NU" %}

### Logic to use all the 4 digits of the display

To use all the 4 displays to display 4 different data at the same time, you should follow this sequence.

  1. Write data to be displayed to Segment 1 into the data latch.
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

**Common Cathode Configuration:**

|-------+-------+-------+-------+-------+-------+-------+-------+-------+------|
|Num    |H      |G      |F      |E      |D      |C      |B      |A      |HEX   |
|:-----:+:-----:+:-----:+:-----:+:-----:+:-----:+:-----:+:-----:+:-----:+:----:|
|0      |       |       |       |1      |1      |1      |1      |1      |0x3F  |
|1      |       |       |       |       |       |       |1      |1      |0x06  |
|2      |       |1      |       |1      |1      |       |1      |1      |0x5B  |
|3      |       |1      |       |       |1      |1      |1      |1      |0x4F  |
|4      |       |1      |1      |       |       |1      |1      |       |0x66  |
|5      |       |1      |1      |       |1      |1      |       |1      |0x6D  |
|6      |       |1      |1      |1      |1      |1      |       |1      |0x7D  |
|7      |       |       |       |       |       |1      |1      |1      |0x07  |
|8      |       |1      |1      |1      |1      |1      |1      |1      |0x7F  |
|9      |       |1      |1      |       |1      |1      |1      |1      |0x6F  |
|-------+-------+-------+-------+-------+-------+-------+-------+-------+------|
{: .table .table-bordered }

**Common Anode Configuration:**

|-------+-------+-------+-------+-------+-------+-------+-------+-------+------|
|Num    |H      |G      |F      |E      |D      |C      |B      |A      |HEX   |
|:-----:+:-----:+:-----:+:-----:+:-----:+:-----:+:-----:+:-----:+:-----:+:----:|
|0      |1      |1      |       |       |       |       |       |       |0xC0  |
|1      |1      |1      |1      |1      |1      |1      |       |       |0xFC  |
|2      |1      |       |1      |       |       |1      |       |       |0xA4  |
|3      |1      |       |1      |1      |       |       |       |       |0xB0  |
|4      |1      |       |       |1      |1      |       |       |1      |0x99  |
|5      |1      |       |       |1      |       |       |1      |       |0x92  |
|6      |1      |       |       |       |       |       |1      |       |0x82  |
|7      |1      |1      |1      |1      |1      |       |       |       |0xF8  |
|8      |1      |       |       |       |       |       |       |       |0x80  |
|9      |1      |       |       |1      |       |       |       |       |0x90  |
|-------+-------+-------+-------+-------+-------+-------+-------+-------+------|
{: .table .table-bordered }

### Look Up Table

Once you have all the values to be written to the display you have to create the lookup table. The lookup table is nothing but an array which has all the above values. So the code looks into this array and fetches the data to be written to the display.

``` c
// Common Cathode Configuration
unsigned char lookup[10] = {
    0x3f, 0x06, 0x5b, 0x4f, 0x66,
    0x6d, 0x7d, 0x07, 0x7f, 0x6f
};
// Common Anode Configuration
unsigned char lookup[10] = {
    0xc0, 0xfc, 0xa4, 0xb0, 0x99,
    0x92, 0x82, 0xf8, 0x80, 0x90
};
```

So a reference to lookup[5] will return the actual display equivalent of 5 for the 7 segment display.

In upcoming posts we will discuss a lot more about the programming of 7 segment displays.
