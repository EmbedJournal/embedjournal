---
title: "Need for Clock Line in Digital Communication"
date: 2013-06-15T10:12:50+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /need-for-clock/
dsq_thread_id: "2728591622"
category: "Embedded"
tags: [ "Basics", "FAQ" ]
---

> What is the need for a clock line in digital communication protocols?

This was a question that was posted on a Facebook page. I was surprised to see no one had posted a response. Probably they felt that the question was below standard, lame, stupid or on the worst case they did _NOT_ know it themselves!

That thought was disturbing. This is a concept that everyone (well, not exactly everyone) should be aware of  not in detail but at least the outline. If you already knew the answer read and find out if I am right. If you didn't then here is your chance to know it.

#### Clock Pulse:

The clock line, constantly pulses the logic level high and low with a time duration "t<sub>b</sub>" in between each pulse denoted by pulse width in the image below. Most of the time "t<sub>b</sub>" is a constant and equal to one bit duration. Hence this line produces a pulsating wave form as shown below. The time period or the clock period is the time take for one complete cycle containing the high period and the low period.

{% include image.html src="clock-pulse.png" %}

There are two types of communication systems that are possible. One is with a clock line and called synchronous and the other is without it and called asynchronous. There is not much difference between the two types of communication

#### Synchronous Communication:

In the synchronous type, one of the devices indulging in the communication has to generate the clock pulse and source it to the other devices in the the bus.

Typically the device that generated the clock is called the Master and it starts the conversation. The clock pulse sent out by the master is used by the slaves to determine the length of each bit in the coming data stream.

#### Asynchronous Communication:

The asynchronous communication there is no need for any clock line.

In some cases the sender and receiver agree upon some predefined clock period and generate their own clock pules and use them for extracting the information from the bit stream and in others the sender sends the data at a fixed rate and the receiver has the ability to measure the duration of each pulse to determine the length of each bit.

Since the devices do not decide upon a fixed baud rate before in the later method (explained above), the first message the sender sends, what is usually, 0x55 and 0xAA. The reason for this particular data to be transmitted is that, they have alternating 0's and 1's in them to produce a clock pulse-like data so that the receiver suitably configures its systems to the length of each bit so that it can extract the message bits form the bit stream later on.

#### What is the Need?

It must have been obvious by now that a clock line is used to calculate the duration of one bit so that the receiver is able to poll the status of the pin at exact locations so that it is reliably able to extract the data from the serial line. The number of times the receiver polls the line in one bit duration varies from just one to how many ever is possible. Just one sample per bit is not a very reliable means to extract the information and making a lot of samples is an over kill. The most logical number of polls per bit would be 3 to get the exact state of the pin along with an idea of the error in synchronization.

I hope this post was helpful to an extent and helped you in some way.
