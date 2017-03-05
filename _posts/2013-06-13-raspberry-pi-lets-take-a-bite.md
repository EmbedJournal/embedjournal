---
id: 636
title: "Raspberry Pi: Let's take a bite from it!"
date: 2013-06-13T09:43:20+00:00
author: Siddharth
layout: post
permalink: /raspberry-pi-lets-take-a-bite/
dsq_thread_id: "3296171215"

image: /wp-content/uploads/2013/06/main2-Rasp.-Pi1.jpg
categories: [ "Embedded Hardware", "Tech Review" ]
tags: [ "review", "specification" ]
---

[<img class="aligncenter size-large wp-image-672" alt="Raspberry Pi" src="/images/posts/2013/06/Raspberry_Pi_Volt-1024x706.jpg" width="620" height="427" />](/images/posts/2013/06/Raspberry_Pi_Volt.jpg)

The Raspberry Pi is a credit card sized single-board computer. This you must have heard at least a thousand times, against my better judgement I have planned to use the same opening statement for this post.

RaspberryA Pi comes as two variants and they choose to call it Model A and Model B. Model A has one USB port and there is no in- builtA Ethernet controller ,whereas Model B had 2 USB ports and standard 10/100 Ethernet controller. Due to the lack of in builtA A Ethernet controller Model A never really made it into the market. But still it's not totally our of business some developers prefer Model A over Model B as it's cost is ultra low.

Actually Model A can also have Ethernet access by using an USB - Ethernet or by a Wi-Fi adapter. But the cost of the USB Ethernet adaper or the Wi-fi adaper combined with Model A's cost will be much higher than Model B raspberry Pi (if you have a spare adapter then it's a totally different issue).

Raspberry Pi has no RTC and hence no built in time stamping. This issue must be handled by an Operating System. The Operating SystemA should poll an NTP server each time it boots or ask the user to enter the time while booting the system.A However, an external RTC (like the DS1307) with battery backup can be configured through theA IA2CA interface to obtain the time stamp.

### **Specification:A **

  * A 5V supply via Micro USB or GPIO Header as Power source.
  * Internal memory of 512 MB or 256 MB. Expansion of memory is not possible like the PC's.
  * A ARM1176JZF-S 700 MHzA processor
  * In-Built 2 USB ports.
  * 3.5mm jack,HDMI,I2S for audio output.
  * Raw LCD panels,HDMI,PAL,NTSC,composite A RCA for Video outputs.
  * On-Board network access by the built-in 10/100 A Ethernet in Model B.

### **Raspberry Pi Pin Mapping:**

<p style="text-align: center;">
  <a href="/images/posts/2013/06/Raspberry-Pi-pin-map.jpg"><img class="aligncenter  wp-image-670" alt="Raspberry Pi pin map" src="/images/posts/2013/06/Raspberry-Pi-pin-map.jpg" width="350" height="431" srcset="/images/posts/2013/06/Raspberry-Pi-pin-map.jpg 500w, /images/posts/2013/06/Raspberry-Pi-pin-map-244x300.jpg 244w" sizes="(max-width: 350px) 100vw, 350px" /></a>
</p>

### **Raspberry Pi Pin Description:**

**SPI:**
  
`GPIO 10 - MOSI<br />
GPIO 9 - MISO<br />
GPIO 11 - SCLK<br />
GPIO 7 - CE1<br />
GPIO 8 - CE0`
  
**UART:A **
  
`GPIO14 - TXD<br />
GPIO15 - RXD`
  
**IA2C:**
  
`GPIO2 - SDA0<br />
GPIO3 - A SCl0`
  
**PWM and CLK:**
  
`GPIO18 - PWM<br />
GPIO4 - GPCLK0`

### **Related Images:**

These are theA useful images that I found scattered in the internet while writing this post. None of then are made my EmbedJournal and are not verified. Please read proper documentation before experimentation or you might end up bricking your Raspberry Pi

<div id='gallery-8' class='gallery galleryid-636 gallery-columns-3 gallery-size-thumbnail'>
  <figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/raspberry-pi-lets-take-a-bite/1005121_3053570676351_401256140_n/'><img width="150" height="150" src="/images/posts/2013/06/1005121_3053570676351_401256140_n-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="Raspberry Pi" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/raspberry-pi-lets-take-a-bite/1005966_3053570076336_42710313_n/'><img width="150" height="150" src="/images/posts/2013/06/1005966_3053570076336_42710313_n-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="Raspberry Pi" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon portrait'>
    <a href='http://embedjournal.com/raspberry-pi-lets-take-a-bite/935211_3053571116362_1637189207_n/'><img width="150" height="150" src="/images/posts/2013/06/935211_3053571116362_1637189207_n-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="Raspberry Pi pin maping" srcset="/images/posts/2013/06/935211_3053571116362_1637189207_n-150x150.jpg 150w, /images/posts/2013/06/935211_3053571116362_1637189207_n-530x525.jpg 530w" sizes="(max-width: 150px) 100vw, 150px" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/raspberry-pi-lets-take-a-bite/643px-raspberrypi_video_api_03-svg/'><img width="150" height="150" src="/images/posts/2013/06/643px-Raspberrypi_video_API_03.svg_-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/raspberry-pi-lets-take-a-bite/1001846_3053574196439_1970775339_n/'><img width="150" height="150" src="/images/posts/2013/06/1001846_3053574196439_1970775339_n-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="Raspberry Pi pin maping" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/raspberry-pi-lets-take-a-bite/raspberry-pi-gpio-layout-revision-2-e1347664831557/'><img width="150" height="150" src="/images/posts/2013/06/Raspberry-Pi-GPIO-Layout-Revision-2-e1347664831557-150x150.png" class="attachment-thumbnail size-thumbnail" alt="Raspberry Pi pin maping" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/raspberry-pi-lets-take-a-bite/968929_3053573716427_371315020_n/'><img width="150" height="150" src="/images/posts/2013/06/968929_3053573716427_371315020_n-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="Raspberry Pi pin maping" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon portrait'>
    <a href='http://embedjournal.com/raspberry-pi-lets-take-a-bite/7078_3053570276341_22496991_n/'><img width="150" height="150" src="/images/posts/2013/06/7078_3053570276341_22496991_n-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="Raspberry Pi pin maping" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/raspberry-pi-lets-take-a-bite/can_2515_board_pin_description/'><img width="150" height="150" src="/images/posts/2013/06/CAN_2515_Board_Pin_Description-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" /></a>
  </div></figure>
</div>

### **Supported Operating Systems:**

  * AROS****
  * Haiku****
  * Linux****
  * Android (Gingerbread, Ice-cream sandwich) ****
  * Arch Linux ARM****
  * Slackware Linux
  * Debian****
  * Gentoo Linux****
  * PiBang Linux****
  * RISC ****
  * Unix****
  * Fedora****
  * Web OS****
  * Plan 9 A ****

### **Limitations:**

Raspberry Pi has a huge list of advantages and most blogs have already posted them. Here are some of its limitations,

  * Memory is limited to just 512 MB or 256 MB.
  * Expansion of Memory is not possible.
  * Graphics Quality is not up to the mark.
  * Raspberry Pi can't handle the A demands of some modem software's.

### **Summary:**

Raspberry Pi is a, small, cheap, rugged, efficient computing solution. It is suitable for embedded applications that involves the use of a powerful Operating System.A It cost dirt cheap and can be useful one way or the other, Go for it!