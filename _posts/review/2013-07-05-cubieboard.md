---
title: Cubieboard a $50 Single Board Computer
date: 2013-07-05T13:45:38+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Naveen
thumbnail: post-thumb.jpg
permalink: /cubieboard/
dsq_thread_id: "3298574154"
category: "Review"
tags: [ "DevKit" ]
---

Lets welcome the new comer in the league of single board computers (SBCs). Yes the [Cubieboard](http://cubieboard.org/) is a new single board computer heading up in the market. It has already been in the market for some time but has not gained popularity.

{% include image.html src="cubieboard.jpg" %}

Cubieboard is a small, high performance ARM box. It is hacker friendly, flexible and very low cost ARM development board.It uses the China's favorite low cost, Allwinner A10 chip. These SOCs are dirt cheap and are as common as potatoes in the Chinese electronics market. This Allwinner and Rockchip are the reason behind such low cost tablets and smart phones from these countries.

The Cubieboard has a SATA connector.Yes that's right you can just plugin a hard disk and get started straight away. The board ships with SATA connectors, Box enclosure and a USB cable for powering up the board.

Unlike it's competitors, the Cubieboard has the ability to connect a hard disk which is really a breakthrough for many hardware hackers who run Linux servers for various reasons such as Network Attached Storage (NAS).

{% include image.html src="cubieboard-nas.jpg" %}

The trade off for these added features is the increase in size. The foot print of the Cubieboard is much larger than that of the raspberry pi or the beagle bone. In CubieBoard most of the components are mounted on the top of the board only few are soldered at bottom. The Ethernet PHY, NAND flash, line-in-connector and the 2 expansion headers are mounted on back of the board.

### Technical Specifications:

{% include image.html src="cubieboard-parts.jpg" %}

|------------------+---------------------------------------------------------|
|Specification     | Ships with                                              |
|:----------------:+---------------------------------------------------------|
|CPU               |1G ARM cortex-A8 processor, NEON, VFPv3, 256KB L2 cache  |
|GPU               |Mali400, OpenGL ES GPU                                   |
|Memory            |1GB DDR3 @480MHz                                         |
|Video output      |HDMI 1080p Output                                        |
|Networking        |10/100M Ethernet, optional WiFi                          |
|Internal Memory   |4GB NAND Flash                                           |
|IO                |2 x USB Host, 1 x MicroSD slot, 1 x SATA, 1 x IR sensor  |
|Interfaces        |96 extend pin interface, including I2C, SPI, RGB/LVDS, CSI/TS, FM-IN, ADC, CVBS, VGA, SPDIF-OUT, R-TP, and more |
|Software          |Official Android distribution available (not pre-installed), Linux |
|Power             |Requires regulated 5VDC 2A power supply with a 4.0mm(ext. diameter) x 1.7mm (int. diameter) barrel plug |
|------------------+---------------------------------------------------------|
{: .table .table-bordered }

#### Enclosure:

The Cubieboard has an official enclosure unlike the raspberry pi or the beagelbone. The best part is that the enclosure is really cheap (just $8) and can be purchased along with the hardware. Here is an image of the enclosure.

{% include image.html src="cubieboad-case_transparent.png" %}

#### Baseboard for Cubieboard:

George Ioakimedes of IO Technologies, LLC (a USA based company) is announcing the availability of their Baseboard for Cubieboard. This is a very important addition to the Cubieboard community.

As George explains it,a Baseboard is a developer board and, like the Cubieboard, is very extensible and can connect to a variety of devices including sensors. To simplify the connection to additional devices, it is common to have an additional printed circuit called daughter board or baseboard. This board is a baseboard, because it acts as a base to the Cubieboard. The Cubieboard can take power from this baseboard.

{% include image.html src="cubieboard-baseboard.jpg" %}

He also adds this - Personally I think using one power supply for everything and having on-board switching regulators for 5.0V and 3.3V is very useful for people wanting to connect devices to the GPIO headers. What good is this development board if you don't start connecting things to it and with this board you have 3.3V and 5.0V available on the header as well as powering the Cubieboard. Also having the audio amplifier on board is nice (for some people), with a speaker header for those applications which require sound. Then you could create a nice little box with screen, speakers, and Cubieboard.

And at $29.99 (plus shipping) this card is a deal because it will adapt your Cubieboard to a touch screen, VGA, LVDS, and most importantly brings Cubieboard's 96 pin connector out to 0.103 pitch headers.

#### **Verdict:**

The Cubieboard has been in the market for some time now but has not penetrated as fast as the raspberry pi but it has some striking features that cannot be overlooked. If you are a hardcore Linux Freak and know your way around the system then this is a good place to experiment and as expected this is a *big NO for beginners*. Not much documentation is available in the Internet and their own website seems to have very little detail.
