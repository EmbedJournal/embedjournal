---
title: "BeagleBone - Detailed Technical Review"
date: 2013-06-09T23:24:23+00:00
author: Siddharth
layout: post
thumbnail: post-thumb.jpg
permalink: /beaglebone-a-quick-review/
dsq_thread_id: "3298573222"
categories: [ "Hardware", "Review" ]
tags: [ "Beagle Bone" ]
---

 

[<img class="aligncenter  wp-image-299" alt="beaglebone" src="/images/posts/2013/05/beaglebone.jpg" width="614" height="598" srcset="/images/posts/2013/05/beaglebone.jpg 1024w, /images/posts/2013/05/beaglebone-300x292.jpg 300w" sizes="(max-width: 614px) 100vw, 614px" />](/images/posts/2013/05/beaglebone.jpg)BeagleBone is a credit-card-sized Linux computer that connects to the Internet and runs software such as Android 4.0 and <a title="Ubuntu for ARM" href="https://wiki.ubuntu.com/ARM" target="_blank">Ubuntu</a>. BeagleBone is nothing but a striped down version of its better known preceders <a title="BeagleBoard" href="http://beagleboard.org/Products/BeagleBoard" target="_blank">BeagleBoard</a>. BeagleBone has plenty of input & outputs and the processing power for real-time analysis is provided by  <a title="Element 14's TI page" href="http://in.element14.com/texas-instruments" target="_blank">Texas Instruments AM335x 720MHz ARMA(r) processor</a>. BeagleBone can be complemented with <a title="Bone Capes" href="http://beagleboard.org/cape" target="_blank">cape</a> plug-in boards to augment functionality. It allows developers to evaluate Sitara, AM335x ARM Cortex-A8 processors with a single cable, under 10-second Linux boot; enabling development in less than 5 minutes. Adding cape plug-in boards to the popular BeagleBone computer allows hobbyists, makers and developers to quickly and easily augment BeagleBone's capabilities with LCD screens, motor control and battery power, as well as the ability to create their own circuits.

There are now more than 50 capes for display (DVI-D, HDMI, VGA, LCD ), motor control, prototyping, power supply (battery, solar ) and more with public design materials. You can find all their officially recognised caped <a title="bone capes all in one" href="http://circuitco.com/support/index.php?title=BeagleBone_Capes" target="_blank">here</a>.

The board uses a <a title="PMIC data sheet" href="http://www.ti.com/product/tps65217b" target="_blank">TI TPS65217B PMIC</a> to generate stable supply voltages regardless of input power variation. +5V DC power can be supplied to the BeagleBone through a barrel connector or from the mini-USB, both of which are located near the large RJ45 Ethernet connector.

The mini-USB type-A OTG/device client-mode socket is multi-functional. In addition to providing an alternative source of power, it gives access to an on-board front-end two-port USB client-side hub. (This is not related to the separate host-mode USB socket described later). One port of the hub goes directly to the USB0 port of the <a title="am3358" href="http://www.ti.com/product/am3358" target="_blank">TI AM3358</a>/9 SoC, while the other port connects to a dual-port FTDI FT2232H USB-to-serial converter to provide board-to-external-host serial communications and/or JTAG debugging. The BeagleBone's Linux serial console is available through this USB serial connection.

The SoC's USB0 connection to the front-end hub works in one of two modes, and you can toggle between them at any time: it either presents the SD card as a mountable USB storage device to the host, or it provides an ethernet-over-USB networking interface which yields a simple method of quick-start. The Ethernet-over-USB facility is additional to the BeagleBone's normal 10/100 Ethernet interface, which is directly implemented in the SoC rather than hanging off USB as in some other designs.

In addition to the USB OTG Device or client-mode facilities already described, BeagleBone also provides one host-mode USB type-A socket on the other end of the board. This is driven from the USB1 connection on the AM3358/9 SoC, and provides access to USB host peripherals such as mice, keyboards, storage, and wifi or Bluetooth dongles, or a USB hub for further expansion.

## **SPECIFICATIONS:**

#### **PROCESSOR:**

AM335X 720MHz ARM Cortex-A8 is the processor used in BeagleBone. The Frequency of the processor can be superscaled upto 720MHz. The processor has the following features,****

  * 3D graphics accelerator
  * ARM Cortex-M3 for power management
  * 2x PRU 32-bit RISC CPU's

#### **CONNECTIVITY:**

  * USB client: power, debug and device
  * USB host
  * Ethernet (10/100 Ethernet RJ45 socket, IPv4 and IPv6 networking)
  * HDMI
  * 2x 46 pin headers

#### **SOFTWARE COMPATIBILITY: **

  * 4GB microSD card w/ Angstrom Distribution
  * Cloud9 IDE on Node.JS w/ BoneScript library

#### **SUPPORTED OPERATING SYSTEMS:**

  * <span style="line-height: 13px;">Angstrom</span>
  * Debian
  * Ubuntu
  * Fedora
  * Arch-Linux
  * Gentoo
  * Sabayon
  * Build-root
  * Nerves Er lang/OTP

#### **BeagleBone Cheat Sheet: **

If you intend to buy a BeagleBone then this is one sheet you can't keep away from. It's popularly circulated in the internet and called the Bone Cheat Sheet. Thanks to the person who took the effort to put up such a good work.

<p style="text-align: center;">
  <a href="/images/posts/2013/06/beaglebone_diagram.jpg"><img class="size-medium wp-image-547 aligncenter" title="BeagleBone Pin Configurations" alt="" src="/images/posts/2013/06/beaglebone_diagram-300x300.jpg" width="300" height="300" srcset="/images/posts/2013/06/beaglebone_diagram-300x300.jpg 300w, /images/posts/2013/06/beaglebone_diagram-150x150.jpg 150w, /images/posts/2013/06/beaglebone_diagram.jpg 450w" sizes="(max-width: 300px) 100vw, 300px" /></a>
</p>

These are the other two reference sheets that you might want to have a look before choosing the best,

<div id='gallery-6' class='gallery galleryid-546 gallery-columns-2 gallery-size-thumbnail'>
  <figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/beaglebone-a-quick-review/beaglebone_p9_pinout/'><img width="150" height="150" src="/images/posts/2013/06/BeagleBone_p9_pinout-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="" srcset="/images/posts/2013/06/BeagleBone_p9_pinout-150x150.jpg 150w, /images/posts/2013/06/BeagleBone_p9_pinout-300x300.jpg 300w, /images/posts/2013/06/BeagleBone_p9_pinout.jpg 512w" sizes="(max-width: 150px) 100vw, 150px" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/beaglebone-a-quick-review/beaglebone_p8_pinout/'><img width="150" height="150" src="/images/posts/2013/06/BeagleBone_p8_pinout-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="" srcset="/images/posts/2013/06/BeagleBone_p8_pinout-150x150.jpg 150w, /images/posts/2013/06/BeagleBone_p8_pinout-300x300.jpg 300w, /images/posts/2013/06/BeagleBone_p8_pinout.jpg 512w" sizes="(max-width: 150px) 100vw, 150px" /></a>
  </div></figure>
</div>

### **Summary:**

  * Extensive I/O: 2 I2C, 5 UART, SPI, CAN, 66 GPIO, 8 PWM, 8 ADC
  * +5V DC power from barrel connector or USB device port
  * Two 46-pin 3.3-V peripheral headers with multiplexed LCD signals
  * On-board USB-to-serial/JTAG over one shared USB device port
  * Single USB 2.0 type A host port
  * Dual USB hub on USB 2.0 type mini-A OTG device port
