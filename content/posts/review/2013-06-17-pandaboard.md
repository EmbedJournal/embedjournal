---
title: "PandaBoard, Technical Reference and Review."
date: 2013-06-17T10:20:56+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Naveen
thumbnail: post-thumb.png
permalink: /pandaboard/
dsq_thread_id: "3298571283"
category: "Review"
tags: [ "DevKit" ]
---

A PandaBoard is a low-cost, low-power single board development platform from the famous Texas Instruments OMAP4430 system. It is capable of running all major flavors of Linux with native support from Ubuntu. It has been on the list of Linux hackers for quite some time now and has a huge archive of project documentation from die-hard Linux fans all over the world.

{% include image.html src="pandaboard.png" %}

PandaBoard consists of CPU and GPU which runs at higher clock rates which is a good news for the developers. The additional feature regarding the clock is that the PandaBoard has a RTC, but this feature is not of much help the developers as the PandaBoard RTC doesn't have a battery back up. Then you have to think of some alternative means to add a power supply to feed the RTC. Which might look really absurd.

This means that once the power is plugged out of the board clock is disabled. Don't worry programmers,we have a solution to this, nothing is impossible in Engineering. To solve this we need to use the Network Time Protocol (NTP) to synchronize the clock, provided the board should have an Internet access. Another way is by Software Clock which can set the clock at the time of booting of the board.

The PandaBoard is exclusively for Linux based developers as the board runs the Linux Kernel with the Android or Firefox OS.  The PandaBoard has an integrated SGX 540 Graphics Processor and provides an HDMI output of 1080 pixels. Here comes an another headache to all my fellow developers - the GPU driver has to written ,by the very difficult and inefficient reverse engineering method.

### Block Diagram of the PandaBoard:

{% include image.html src="pandaboard-block-diagram.png" %}

### Key Features:

  * Dual core 1GHz ARM Cortex-A9 Processor
  * Wired 10/100 Ethernet
  * Bluetooth Connectivity
  * Wireless Ethernet
  * Primary persistent storage is in SD and whose memory is extended to 32 GB
  * Dual Core 1.2 GHz CPU and 384 MHz GPU
  * Supports DVI and HDMI video outputs
  * Has 2 USB ports.

### Expansions Headers Details:

Primary difference between the BeagleBoard expansion and the PandaBoard expansion is the removal of the McBSP support from the header. As the McBSP was one of the least used features of the expansion header, they were replaced with additional chip select lines for the McSPI. This allows for a greater number of SPI devices to be used on the expansion header.

|-----+---------------------------+-------------------------|
| PIN | BeagleBoard/BeagleBoardXM | PandaBoardES/PandaBoard |
|-----+---------------------------+-------------------------|
| 1   | 1V8                       | 1V8                     |
| 2   | 5V                        | 5V                      |
| 3   | MMC2_DAT7                 | MMC2_DAT7               |
| 4   | MCBSP3_DX                 | MCSPI1_CS3              |
| 5   | MMC2_DAT6                 | MMC2_DAT6               |
| 6   | UART2_TX                  | UART4_TX                |
| 7   | MMC2_DAT5                 | MMC2_DAT5               |
| 8   | UART2_RX                  | UART4_RX                |
| 9   | MMC2_DAT4                 | MMC2_DAT4               |
| 10  | MCBSP3_DR                 | MCSPI1_CS1              |
| 11  | MMC2_DAT3                 | MMC2_DAT3               |
| 12  | MCSPI4_SIMO               | MCSPI1_SIMO             |
| 13  | MMC2_DAT2                 | MMC2_DAT2               |
| 14  | MCBSP1_CLKX               | MCSPI1_CS2              |
| 15  | MMC2_DAT1                 | MMC2_DAT1               |
| 16  | MCSPI4_CS0                | MCSPI1_CS0              |
| 17  | MMC2_DAT0                 | MMC2_DAT0               |
| 18  | MCSPI4_SOMI               | MCSPI1_SOMI             |
| 19  | MMC2_CMD                  | MMC2_CMD                |
| 20  | MCSPI4_SCLK               | MCSPI1_SCLK             |
| 21  | MMC2_CLK0                 | MMC2_CLK0               |
| 22  | MCBSP1_FSR                | GPMC_AD15               |
| 23  | I2C2_SDA                  | I2C4_SDA                |
| 24  | I2C2_SCL                  | I2C4_SCL                |
| 25  | REGEN                     | REGEN                   |
| 26  | nRESET                    | nRESET                  |
| 27  | GND                       | GND                     |
| 28  | GND                       | GND                     |
|-----+---------------------------+-------------------------|
{: .table .table-bordered }

### Component Listing:

Here are the list of components that are used in the PandaBoard with reference to their vendors and part ID. If you are planning to purchase one of these then you should have a closer look at the components used and the actual license behind the components they have used.

|--------------------------+----------+---------------------|
|Function                  | Vendor   | Part ID             |
|--------------------------+----------+---------------------|
|Application Processor     | TI       | OMAP4460 / OMAP4430 |
|Memory                    | Elpida   | EDB8064B1PB-8D-F    |
|Power Management IC       | TI       | TWL6030             |
|Audio IC                  | TI       | TWL6040             |
|Connectivity              | LSR      | LS240-WI-01-A20     |
|4 Port USB Hub/Ethernet   | SMSC     | LAN9514-JZX         |
|DVI Transmitter           | TI       | TFP410PAP           |
|3.5 MM Dual Stacked Audio |KYCON     | STX-4235-3/3-N      |
|--------------------------+----------+---------------------|
{: .table .table-bordered }

### Display Connection:

|-------------+----------------+----------------+-------------------|
| Description | PandaBoard     | Display        | Cable Type        |
|-------------+----------------+----------------+-------------------|
| H2H         | HDMI Out       | HDMI In        | HDMI-A to HDMI-A  |
| H2D         | HDMI Out       | DVI In         | HDMI-A to DVI-D   |
| D2D         | DVI Out        | DVI In         | HDMI-A to DVI-D   |
| D2H         | DVI Out        | HDMI In        | HDMI-A to HDMI-A  |
|-------------+----------------+----------------+-------------------|
{: .table .table-bordered }

### PandaBoard Accessories & Peripherals:

The PandaBoard comes as is. That is it cannot be used fully out of the box. There are a list of accessories that you might have to purchase in order to use all the above features to its fullest extent. You can find a list of all the officially approved accessories [here](http://pandaboard.org/content/resources/Accessories).

### Conclusion:

PandaBoard is a good choice if you are a seasoned Linux user looking forward to some real beast in terms of processing and computation powers. For beginners and intermediate level users you might have to wait a little longer to use this board. There are other boards that will suit your need properly.

Also read our review on some other popular SBCs such as [BeagleBone](/beaglebone-a-quick-review/), [RaspberryPi](/raspberry-pi-lets-take-a-bite/) and [Cubieboard](/cubiebord/).
