---
title: Cubieboard a $50 Single Board Computer
date: 2013-07-05T13:45:38+00:00
author: Siddharth
layout: post
thumbnail: post-thumb.jpg
permalink: /cubieboard/
dsq_thread_id: "3298574154"
categories: [ "Hardware", "Review" ]
tags: [ "DevKit" ]
---

<p style="text-align: left;">
  <a href="/images/posts/2013/07/Cubieboard.jpg"><img class="aligncenter size-full wp-image-1085" alt="Cubieboard" src="/images/posts/2013/07/Cubieboard.jpg" width="722" height="450" srcset="/images/posts/2013/07/Cubieboard.jpg 722w, /images/posts/2013/07/Cubieboard-300x187.jpg 300w" sizes="(max-width: 722px) 100vw, 722px" /></a>
</p>

<p style="text-align: left;">
  Lets welcome the new comer in the league of SBC (<a href="http://en.wikipedia.org/wiki/Single-board_computer" target="_blank">single board computers</a>). Yes the <a href="http://cubieboard.org/" target="_blank">Cubieboard</a> is a new single board computer A heading up in the market. Its already been the market for some time but not yet popular. Cubieboard is a small, high performance ARM box. It is hacker friendly, extendable and very low cost ARM development board.It uses the China's favorite low cost, A <a href="http://en.wikipedia.org/wiki/Allwinner_A1X" target="_blank">Alwinner A10 </a>chip. These chips are dirt cheap and are as common as potatoes in the Chinese electronics market. This Allwinner and <a href="http://en.wikipedia.org/wiki/Rockchip" target="_blank">Rockchip</a> are the reason behind such low cost tablets and smartphones from these countries.
</p>

<p style="text-align: left;">
  The Cubieboard has a SATA connector.Yes thats right you can just plugin a hard disk and get started straight away. The board ships with SATA connectors, Box enclosure A and a USB cable for powering up the board.
</p>

<p style="text-align: left;">
  Unlike it's competitors, the Cubieboard has the ability to connect a hard disk which is really a breakthrough for many hardware hackers who run Linux servers for various reasons such as NAS (<a href="http://en.wikipedia.org/wiki/Network-attached_storage" target="_blank">Network Attached Storage</a>).
</p>

<p style="text-align: left;">
  <a href="/images/posts/2013/07/cubieboard1.jpg"><img class="aligncenter size-large wp-image-1086" alt="cubieboard with hard disk" src="/images/posts/2013/07/cubieboard1-1024x768.jpg" width="618" height="463" srcset="/images/posts/2013/07/cubieboard1-1024x768.jpg 1024w, /images/posts/2013/07/cubieboard1-300x225.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" /></a>
</p>

The trade of for these added features is the increase in size. The foot print of the Cubieboard is much larger than that of the raspberry pi or the beagle bone. In Cubie Board most of the components are mounted on the top of the board only few are soldered at bottom. The Ethernet PHY, NAND flash, line-in-connector and the 2 expansion headers are mounted on back of the board.

#### <strong style="font-size: 13px; line-height: 19px;">Technical Specifications:</strong>

[<img class="aligncenter size-full wp-image-1082" alt="Cubieboard" src="/images/posts/2013/07/Cubieboard-6.jpg" width="748" height="489" srcset="/images/posts/2013/07/Cubieboard-6.jpg 748w, /images/posts/2013/07/Cubieboard-6-300x196.jpg 300w" sizes="(max-width: 748px) 100vw, 748px" />](/images/posts/2013/07/Cubieboard-6.jpg)

<table style="width: 100%;" border="5" frame="box" rules="all" cellspacing="0" align="CENTER">
  <tr>
    <th>
      CPU
    </th>
    
    <td>
      1G ARM cortex-A8 processor, NEON, VFPv3, 256KB L2 cache
    </td>
  </tr>
  
  <tr>
    <th>
      GPU
    </th>
    
    <td>
      Mali400, OpenGL ES GPU
    </td>
  </tr>
  
  <tr>
    <th>
      Memory
    </th>
    
    <td>
      1GB DDR3 @480MHz
    </td>
  </tr>
  
  <tr>
    <th>
      Video output
    </th>
    
    <td>
      HDMI 1080p Output
    </td>
  </tr>
  
  <tr>
    <th>
      Networking
    </th>
    
    <td>
      10/100M Ethernet, optional WiFi
    </td>
  </tr>
  
  <tr>
    <th>
      Internal storage
    </th>
    
    <td>
      4GB NAND Flash
    </td>
  </tr>
  
  <tr>
    <th>
      IO
    </th>
    
    <td>
      2 x USB Host, 1 x MicroSD slot, 1 x SATA, 1 x IR sensor
    </td>
  </tr>
  
  <tr>
    <th>
      Extended interfaces
    </th>
    
    <td>
      96 extend pin interface, including I2C, SPI, RGB/LVDS, CSI/TS, FM-IN, ADC, CVBS, VGA, SPDIF-OUT, R-TP, and more
    </td>
  </tr>
  
  <tr>
    <th>
      Software
    </th>
    
    <td>
      Official Android distribution available (not pre-installed), Linux
    </td>
  </tr>
  
  <tr>
    <th>
      Power
    </th>
    
    <td>
      Requires regulated 5VDC 2A power supply with a 4.0mm(ext. diameter) x 1.7mm (int. diameter) barrel plug
    </td>
  </tr>
</table>

#### Enclosure:

The cubieboard has an official enclosure unlike the raspberry pi or the beagelbone. The best part is that the enclosure is really cheap (just $8) and can be purchased along with the hardware. Here is an image of the enclosure.

<p style="text-align: center;">
  <a href="/images/posts/2013/07/case_transparent.png"><img class="aligncenter  wp-image-1084" alt="cubieboard case_transparent" src="/images/posts/2013/07/case_transparent.png" width="586" height="437" srcset="/images/posts/2013/07/case_transparent.png 915w, /images/posts/2013/07/case_transparent-300x224.png 300w" sizes="(max-width: 586px) 100vw, 586px" /></a>
</p>

#### Baseboard for cubieboard:

George Ioakimedes of IO Technologies, LLC (a USA based company) is announcing the availability of their Baseboard for Cubieboard. This is a very important addition to the Cubieboard community.

As George explains it. aEURoeA Baseboard is a developer board and, like the Cubieboard, is very extensible and can connect to a variety of devices including sensors. To simplify the connection to additional devices, it is common to have an additional printed circuit called daughterboard or baseboard. This board is a baseboard, because it acts as a base to the Cubieboard. The Cubieboard can take power from this baseboard.aEUR

[<img class="aligncenter size-large wp-image-1087" alt="baseboard for cubieboard" src="/images/posts/2013/07/baseboard11-1024x682.jpg" width="618" height="411" />](/images/posts/2013/07/baseboard11.jpg)

He also adds this. aEURoePersonally I think using 1 power supply for everything and having on board switching regulators for 5.0V and 3.3V is very useful for people wanting to connect devices to the GPIO headers. What good is this development board if you donaEURtmt start connecting things to it and with this board you have 3.3V and 5.0V available on the header as well as powering the Cubie. Also having the audio amplifier on board is nice (for some people), with a speaker header for those applications which require sound. Then you could create a nice little box with screen, speakers, and CubieboardaEUR

And at $29.99 (plus shipping) this card is a deal because it will adapt your Cubieboard to a touch screen, VGA, LVDS, and most importantly brings Cubieboards 96 pin connector out to 0.100aEUR3 pitch headers.

#### **Verdict:**

The cubieboard has been in the market for some time know but has not penetrated the as fast as the raspberry pi but it has some striking features that cannot be overlooked. If you are a hardcore Linux Freak and know your way around the system then this is a good place to experiment and as expected this is a big NO for beginners. Not much documentation is available in the internet and their own website seems to have very little detail.