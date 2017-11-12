---
title: "Race condition in reading RTC timekeeping registers"
date: 2015-07-11T08:35:10+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /rtc-registers-read-atomic-values/
dsq_thread_id: "3923345886"
category: "Embedded"
tags: [ "RTC", "Algorithm" ]
---

Most of you must have used a Real Time Clock (RTC) at some point. RTCs are small ICs that have a separate battery backup and allow you to keep  track of time. Typical place where you can expect to see an RTC in action is your computer. They are used to keep track of time when your computer is powered off. Another more obvious application is digital clocks, not to mention that [making your own digital clock](/make-a-digital-clock/) is an interesting intermediate level project.

### The race condition

There is a good chance that your RTC isn't giving out atomic values when you read through various registers associated with timekeeping. This means that if an update to one of those registers happens while you are reading, you may end up with the wrong value. Therein lies your race condition.

### Atomic Access

In software terms, atomic access to a variable means that only one process (in a multithreading system) can have access to it at any given time. In the embedded world, one may think that all variables are atomic as there is no multithreading. But on the contrary, Interrupt Service Routines (ISR) are a close match to a separate thread and may cause what is called as a race condition, if variables are shared across the main program and the ISR.

**Counter Overflows**

This is the most common type of race condition that can happen to you. If you have been doing any embedded programming, you should have hit this problem in the first few months.

Let's say you are working on an 8 bit system and you have a uint16_t counter that is being incremented by an ISR. The rest of your code is using this variable for some application. A read of the variable is such that the upper byte is taken first and then shifted 8 times and then the lower byte is ORed with it. There can be a time when, after you read the higher byte, the lower byte was incremented by the ISR.

### How serious is this?

What's the big deal? missed a count this time in the LSB, next time everything is fine. It shouldn't kill anything right?

Well you would be right majority of the time. You will have the correct value or one less than the correct value. But what if the lower byte was a big number in itself and got incremented to rollover to the higher order byte?

To better understand this issue, let's assume the 16 bit variable has 0x51FF In this case, when reading, you will read 0x51 first and then read 0xFF and put them together to get 0x51FF. But assume that after reading 0x51, the ISR incremented the variable by one. This makes the variable 0x5200. But we have already read 0x51 to a local copy. Now you read the second byte, which has the updated value as 0x00. When put together to get 0x5100, what we actually get is a number much less than 0x5200. In this case you have not just missed a measly one count but 256 counts!! (and worse yet, you will gain 257 in the subsequent read) All the code that was working like a charm for all this while may crumble depending on the implementation.

### How it happens in the RTC?

Most external RTCs are SPI or I2C based and gives byte access to the timekeeping registers. A single read (I2C/SPI) will return the year then subsequent reads will give us the month, day and so on until all the time keeping registers are read.

Applying the same example in this case, when you are trying to read time at 10:30:59 from the RTC, if the RTCs was not designed properly (there are quite a lot of them) when you read 10:30 the seconds register may get incremented and you will read 10:30:00 instead of 10:31:00. Here you have lost one full minute, but if you had considered the time to be 10:59:59, you would be having 10:00:00 instead of 11:00:00 which is an hour!

Needless to say, the next read will return a time that is  ahead by the time you lost. This little jump in time is enough to challenge even the best of software. The worst part of such a bug is that it's not something that happens all time and you might have thousands of products running in the field for years without having to face this issue at all.

### How is this fixed?

Most advanced RTCs have built in features to prevent such mistakes. They allow you to create a timestamp that can be triggered with the pulse of a pin and then allow you to read from this saved value. Another popular strategy is to create a timestamp as soon as there is some activity on the data lines.

These are hardware fixes that people have come up with for this issue. This is how you kill a mosquito with a machine gun.

### What's wrong with this approach?

Unfortunately not all RTC manufactures are as keen in giving you a hardware fix. What if you have an RTC that does not have this feature? what if you had a [MCP7941](http://ww1.microchip.com/downloads/en/DeviceDoc/20002266F.pdf) in your design? Why this part? yes, you guessed it. If you are using it and you are lucky you will hit this bug in the initial stages of your testing. If Microchip has this issue then chances are a lot more of them could be having this issue as well.

Above all, this fix isn't portable. Tomorrow you may change the RTC and you are back to square one.

### what's the optimal fix?

Fortunately for us, there is a simple enough software fix to overcome this. All you have to do is read the time more one more time if the seconds is zero from the last read. So you will have something like this in your get time routine,

``` c
getRTCTime(&t);
if (t.ss == 0)
    getRTCTime(&t);
```

This single extra read guarantees that you have the correct time. This takes very little time to implement and it's such a useful feature that  warrants this line in all RTC drivers even if your RTC is nice enough to fix it for you. This additional read is not going to cost you much in terms of performance but most certainly it will help you preserve your sanity.
