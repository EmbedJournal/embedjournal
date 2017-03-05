---
id: 2342
title: Serial Ports are dead? Think again!
date: 2014-05-30T13:15:02+00:00
author: Siddharth
layout: post
permalink: /pc-serial-port-not-dead/
dsq_thread_id: "2728589255"

image: /wp-content/uploads/2014/05/2014-05-24-17.14.16_compressed.jpg
categories: [ "General Posts" ]
tags: [ "DIY" ]
---

<!--NoAds-->

Your Desktop-PC doesn't have a Serial Port in the back side? Don't be so sure of it. If youA can't see, doesn't mean it ain'tA there!

All you have to do is look properly.

If you are a full-time laptop user, stop right here! This article is of no help toA you.A Good old desktop users might have a shot at a native COM port in your computer! Just read alongaEUR|

### What is this UART anyway?

UART isA one of the mostA preferred form of debugging in embedded platforms. Be it an 8 bit system handling meager tasks or a massive 64 bit system running Linux. All of them support the [UART protocol](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver/transmitter). UART, as a protocol, is primitive (it should take you roughly 15 minutes to know it all). For this reason, it is very easy to implement it in the chip's silicon, making itA very easy for us to configureA and get it up and running almost immediately.

Since motherboards operate at 3.3 volts, they had to put out these UART lines through [RS232 levels](https://en.wikipedia.org/wiki/RS-232) to increase the cable distance. This also addressesA the problem of logic level compatibility between the interface hardware. The sender up's his level to RS232 and expects the receiver to bring it to his level somehow.

For this reason, a massive [D-Sub 9 connector or DE-9 Connector](https://en.wikipedia.org/wiki/D-subminiature)A (often [mistakenly referred to as the DB-9 connector](http://www.nullmodem.com/DB-9.htm)) was chosen to improve stability of the contact. It later turned out the connector was too fat to be on laptops any more. Slowly this trend crept into the PC market as well and motherboards manufacturers stopped putting those connectors. Most (if not all) of todayaEURtms laptops and desktops don'tA ship with a serial port connector on them.

### Other alternatives?

Wait, all is not lost!

SomeA popular alternatives areA USB to Serial converters such as [FTDI's FT232](http://www.ftdichip.com/Products/ICs/FT232R.htm)A or [Silicon lab's CP10x](https://www.silabs.com/products/interface/usb-bridges/Pages/usb-bridges.aspx) to emulate a serial port thru USB on our new computers.A I mentions these two as they are most popular chips.

<span style="text-decoration: underline;">Dishonorable mention:</span> There is this third USB to serial converter from the infamous Prolific Technologies Inc. Those were the dark days when I was forced to goA on a wild goose chase looking for the ever-eluding prolific USBA serial driver.

There are some other not-so-popular alternatives suchA as, a PCI/PCIExpress card to achieve the same functionality. Apart from this, the USB standard advertises a [Communications Device Class (CDC)](https://en.wikipedia.org/wiki/USB_communications_device_class)A which didn't kick off very well for a lot of reasons.

### Can we do something about this?

Like I said, most of the processors and controllers, come with UART. The engineers (the BSP developers) who work on the motherboard, before they are released to the market use them to run peripheral troubleshooting and debugging. The manufacturers just do not put an external port to access it. ThisA means there is a smallA probability that there is still a UARTA port on our motherboards.

I opened my computer one day for cleaning and noticed that there were a lot unsoldered connectors on my motherboard (an Asus P7H55 MLX). Force of habit, I was looking through the silk screen for names when I came across the pads for a 10 pin box connector named aEURoeCOM 2aEUR.

<div class="box warning  aligncenter">
  <div class="box-inner-block">
    <i class="fa tie-shortcode-boxicon"></i> Following this method can damage your motherboard and/or void your warranty. Do this at your own risk. Also, the connector on the motherboards are not RS232 levels They are raw 3.3v logic signals.
  </div>
</div>

My hand automatically reached out for the soldering iron and in no time I had the box connector in place and a 10 pin FRC wire pushed on to it.

[<img class="aligncenter size-large wp-image-2343" src="/images/posts/2014/05/2014-05-24-17.14.16_compressed-1024x768.jpg" alt="serial Port connector" width="618" height="463" srcset="/images/posts/2014/05/2014-05-24-17.14.16_compressed-1024x768.jpg 1024w, /images/posts/2014/05/2014-05-24-17.14.16_compressed-300x225.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2014/05/2014-05-24-17.14.16_compressed.jpg)

### Matching the pinout

Then I looked up the serial port 10 pin connection pin out. I knew if they put it on a system as sophisticated as the motherboard, they would surely have followed the standard pinouts. But I wasn't going leave any stone un turned. I verified the power lines and then started a serial port application on my machine and sent out 0xAA to see a square wave on the scope and then short the TX to what I thought was the RX and did a successful [loopback test](https://en.wikipedia.org/wiki/Loopback).

Originally my Idea was to make a long wire out of it and then made a PCB with the DE9 connector. But then long back I had purchased a PCI Serial card. As luck would have it, the connector had a UART to RS232 converter in it.

[<img class="aligncenter size-large wp-image-2345" src="/images/posts/2014/05/2014-05-24-17.23.11_compressed-768x1024.jpg" alt="PCI serial Port connector" width="618" height="824" srcset="/images/posts/2014/05/2014-05-24-17.23.11_compressed-768x1024.jpg 768w, /images/posts/2014/05/2014-05-24-17.23.11_compressed-225x300.jpg 225w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2014/05/2014-05-24-17.23.11_compressed.jpg)

Now all I had to do was to connect the other end of the FRC connector to the DE9 connector that came with the PCI cardA and put itA toA one of my computer's chassis slots.

Here is the full version of the wire running from the motherboard to the back of my computer,

[<img class="aligncenter size-large wp-image-2344" src="/images/posts/2014/05/2014-05-24-17.18.15_compressed-768x1024.jpg" alt="serial Port connector full view" width="618" height="824" srcset="/images/posts/2014/05/2014-05-24-17.18.15_compressed-768x1024.jpg 768w, /images/posts/2014/05/2014-05-24-17.18.15_compressed-225x300.jpg 225w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2014/05/2014-05-24-17.18.15_compressed.jpg)

But certainly having a native serial port is a big relief. There was a risk meddling with my motherboard like that but, I must admit it was worth it!