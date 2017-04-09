---
title: "Arduino Like Serial / UART Library for PIC 18 Microcontrollers"
date: 2014-05-23T13:48:26+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /arduino-like-serial-uart-library-pic-18-microcontrollers/
dsq_thread_id: "3290732954"
category: "Microchip PIC"
tags: [ "Arduino", "Ideas" ]
---

In my last post describing the [implementation of a circular buffer](/implementing-circular-buffer-embedded-c/) I mentioned that I was working on a serial UART library for PIC 18. Well it is now completed! Yesterday I tested all the functions of the library and its working like a charm!

In this post I will explain some key aspects of the code and how to download and use it in your code.

### What is UART?

Universal Asynchronous Receiver and Transmitter is a serial communication protocol. It is an 'asynchronous communication protocol' meaning it does not have a clock line (read about the [use of clock line in digital communication protocols](/need-for-clock/)) to sync the data transfer.

For it to be defined as a protocol we have to have some ground rules so that the transmitter and receiver can understand what each other are trying to say. So that's when we have the baud rate (can be referred to as bit rate or rarely as bandwidth), Start and Stop bits.

I will not go into the details of the serial communication protocol in general it's a post for another day! But if you really can't resist the urge, our friends at [MaxEmbedded](http://maxembedded.com/2013/09/21/serial-communication-rs232-basics/) have done a wonderful job in explaining the basics. Do have look.

Like I mentioned in my [previous post](/implementing-circular-buffer-embedded-c/), I wanted the serial transmission and reception to be handled by interrupts and that's exactly how I have done it. The best part is that I have tried to make the functions look and behave mostly like the Arduino serial library.

### Why use interrupts for reception and not for transmission?

Well it's not as unfair as it may seem... we have good reason to do it! When interrupt based serial communication is discussed, most of the time people write the reception in interrupt mode and transmission in polling mode.

The reason is that the incoming byte is time sensitive. That is if we are busy doing something else while a byte is at the received register, then the successive byte can overwrite the existing byte and the previous byte will be lost forever.

On the other hand, the transmission is bound by the program and you can control when the transmission has to happen and it'vs up to the receiving device to take care of how to receive it. So what we do is, write the data to be transferred serially to the transmit register and wait for the data to be sent out and then move on to the next byte/task.

I have used interrupts in both transmit and receive functions just to demonstrate  its use in both the cases!

### Serial Interrupt Mechanism

The serial reception interrupt is pretty straight forward. When there is a byte in the RXREG (reception register in PIC micros) the controller interrupts and jumps to the interrupt vector and grabs the byte and stores it in the RAM. Then the user program can then use this data at its discretion.

The transmission interrupt is not so trivial. Here, so long as the interrupt is enabled, the controller keeps jumping into the ISR.

The controller interrupts every time the TXREG (transmit register) is empty, that is after the data has been sent out. So all we have to do is, write the data to be sent to a buffer and then enable the transmission interrupt. Inside the ISR, we will have to add code to load the buffer on to the TXREG one after the other.

Once the last byte in the buffer is loaded, we will have to **disable the interrupts inside the ISR** this is really important. You will **HAVE** to disable the interrupt after loading the last data in the buffer is loaded. Your software should make damn sure of that. Failing to do so will result in successive interrupts which implies your program will not execute at all!

### Where is the program?

The program runs close to 400 lines so I will refrain from posting it here. You can find the code along with an example program at our GitHub Repository.

#### <a title="Vist GitHub repository" href="https://github.com/EmbedJournal/PIC-Hardware-UART" target="_blank">Download from GitHhub<br /> </a>

I have commented the code enough so I don't think there is any need for a description here. Besides, the most important part of the code, dealing with the circular buffer and their use has already been discussed. If you still have some thing to ask, leave a comment and I will get back to you as soon as possible.

I have also added some functions to perform string operations at the end of the file that is for the GPS module interface that I am working on right now! Feel free to have a look but if you don't like it, you know where to find the back space!
