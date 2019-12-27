---
title: "Raspberry Pi: Let's take a bite from it!"
date: 2013-06-13T09:43:20+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /raspberry-pi-lets-take-a-bite/
dsq_thread_id: "3296171215"
category: "Review"
tags: [ "Raspberry Pi" ]
---

{% include image.html src="raspberry-pi2.jpg" %}

The Raspberry Pi 2 is a credit card sized single-board computer. This you must have heard at least a thousand times, against my better judgment I have planned to use the same opening statement for this post.

Raspberry Pi comes as two variants and they choose to call it Model A and Model B. Model A has one USB port and there is no in- built Ethernet controller ,whereas Model B had 2 USB ports and standard 10/100 Ethernet controller. Due to the lack of in-built  Ethernet controller Model A never really made it into the market. But still it's not totally out of business. Some developers prefer Model A over Model B as it's cost is ultra low.

Actually Model A can also have Ethernet access by using an USB - Ethernet or by a WiFi adapter. But the cost of the USB Ethernet adapter or the Wi-fi adapter combined with Model A's cost will be much higher than Model B raspberry Pi (if you have a spare adapter then it's a totally different issue).

Raspberry Pi has no RTC and hence no built in time stamping. This issue must be handled by an Operating System. The Operating System should poll an NTP server each time it boots or ask the user to enter the time while booting the system. However, an external RTC (like the DS1307) with battery backup can be configured through the IA2C interface to obtain the time stamp.

### Specification:

  * A 5V supply via Micro USB or GPIO Header as Power source.
  * Internal memory of 512 MB or 256 MB. Expansion of memory is not possible like the PC's.
  * An ARM1176JZF-S 700 MHz processor
  * In-Built 2 USB ports.
  * 3.5mm jack,HDMI,I2S for audio output.
  * Raw LCD panels,HDMI,PAL,NTSC,composite  RC for Video outputs.
  * On-Board network access by the built-in 10/100 Ethernet in Model B.

### Raspberry Pi Pin Mapping:

{% include image.html src="pi-pin-mapping.jpg" %}

### Raspberry Pi Pin Description:

```text
/* SPI */
GPIO 10 - MOSI
GPIO 9 - MISO
GPIO 11 - SCLK
GPIO 7 - CE1
GPIO 8 - CE0

/* UART */
GPIO14 - TXD
GPIO15 - RXD

/* I2C */
GPIO2 - SDA0
GPIO3 - SCl0

/* PWM and CLK */
GPIO18 - PWM
GPIO4 - GPCLK0
```

### Limitations:

Raspberry Pi has a huge list of advantages and most blogs have already posted them. Here are some of its limitations,

  * Memory is limited to just 512 MB or 256 MB.
  * Expansion of Memory is not possible.
  * Graphics Quality is not up to the mark.
  * Raspberry Pi can't handle the  demands of some modem software's.

### Summary:

Raspberry Pi is a, small, cheap, rugged, efficient computing solution. It is suitable for embedded applications that involves the use of a powerful Operating System. It costs dirt cheap and can be useful one way or the other, Go for it!
