---
id: 685
title: "PandaBoard : Technical Reference and Review."
date: 2013-06-17T10:20:56+00:00
author: Siddharth
layout: post
permalink: /pandaboard/
dsq_thread_id: "3298571283"

image: /wp-content/uploads/2013/06/PandaBoard_top_view.png
categories: [ "Embedded Hardware", "Tech Review" ]
tags: [ "Development Board", "Embedded Linux" ]
---

A PandaBoard is a low-cost, low-power single board development platform from the famous Texas Instruments OMAP4430 system. It is capable of ruining all major flavors of Linux with native support from Ubuntu. It has been on the list of linux hackers for quite some time now and has a huge archive of project documentation form diehard Linux fans all over the world.

[<img class="aligncenter size-full wp-image-788" alt="PandaBoard" src="/images/posts/2013/06/PandaBoard_top_view.png" width="640" height="425" srcset="/images/posts/2013/06/PandaBoard_top_view.png 640w, /images/posts/2013/06/PandaBoard_top_view-300x199.png 300w, /images/posts/2013/06/PandaBoard_top_view-310x205.png 310w" sizes="(max-width: 640px) 100vw, 640px" />](/images/posts/2013/06/PandaBoard_top_view.png)

<p style="text-align: left;">
  PandaBoard consists of CPU and GPU which runs at higher clock rates which is a good news for the developers. The additional feature regarding the clock is that the PandaBoard has a RTC (<a title="Interfacing RTC with Microcontroller" href="http://embedjournal.com/2013/05/interfacing-rtc-with-microcontroller/" target="_blank">Know more about RTC here</a>), but this feature is not of much help the developers as the PandaBoard RTC doesn't have a battery back up. Then you have to think of some alternative means to add a power supply to feed the RTC. Which might look really absurd.
</p>

<p style="text-align: left;">
  This means that once the power is plugged out of the board clock is disabled. Don't worry programmers,we have a solution to this also dYtm, nothing is impossible in Engineering. A To solve this we need to us the NTP(<em>Network Time Protocol</em>) to synchronize the clock, provided the board should have an Internet access. Another way is by Software Clock which can set the clock at the time of booting of the board dYtm,
</p>

<p style="text-align: left;">
  The PandaBoard is exclusively for Linux based developers as the board runs the Linux Kernel with the Android or Firefox OS. A The PandaBoard has an integrated SGX 540 Graphics Processor and provides an HDMI output of 1080 pixels. Here comes an another headache to all my fella developers the GPU driver has to written ,by the very difficult and inefficient reverse engineering method.
</p>

### Block Diagram of the PandaBoard:

[<img class="aligncenter size-large wp-image-786" alt="PandaBoard_block_diagram" src="/images/posts/2013/06/PandaBoard_block_diagram-1024x876.png" width="620" height="530" srcset="/images/posts/2013/06/PandaBoard_block_diagram-1024x876.png 1024w, /images/posts/2013/06/PandaBoard_block_diagram-300x257.png 300w, /images/posts/2013/06/PandaBoard_block_diagram.png 1074w" sizes="(max-width: 620px) 100vw, 620px" />](/images/posts/2013/06/PandaBoard_block_diagram.png)

### Key Features:

  * Dual core 1GHz ARM Cortex-A9 Processor
  * Wired 10/100 Ethernet
  * BluetoothA Connectivity
  * Wireless Ethernet
  * Primary persistent storage is in SD and whose memory is extended to 32 GB
  * Dual Core 1.2 GHz CPU and 384 MHz GPU
  * Supports DVI and HDMI video outputs
  * Has 2 USB ports.

### Expansions Headers Details:

Primary difference between the BeagleBoard expansion and the PandaBoard expansion is the removal of the McBSP support from the header. As the McBSP was one of the least used features of the expansion header, they were replaced with additional chip select lines for the McSPI. This allows for a greater number of SPI devices to be used on the expansionA header<em id="__mceDel">.</em>

<table style="width: 75%;" border="5" frame="box" rules="all" cellspacing="0" align="CENTER">
  <tr>
    <td align="CENTER" width="86" height="17">
      <strong>PIN</strong>
    </td>
    
    <td align="CENTER" width="156">
      <strong>BeagleBoard/BeagleBoardXM</strong>
    </td>
    
    <td align="CENTER" width="116">
      <strong>PandaBoardES/PandaBoard</strong>
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      1
    </td>
    
    <td align="CENTER">
      1V8
    </td>
    
    <td align="CENTER">
      1V8
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      2
    </td>
    
    <td align="CENTER">
      5V
    </td>
    
    <td align="CENTER">
      5V
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      3
    </td>
    
    <td align="CENTER">
      MMC2_DAT7
    </td>
    
    <td align="CENTER">
      MMC2_DAT7
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      4
    </td>
    
    <td align="CENTER">
      MCBSP3_DX
    </td>
    
    <td align="CENTER">
      MCSPI1_CS3
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      5
    </td>
    
    <td align="CENTER">
      MMC2_DAT6
    </td>
    
    <td align="CENTER">
      MMC2_DAT6
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      6
    </td>
    
    <td align="CENTER">
      UART2_TX
    </td>
    
    <td align="CENTER">
      UART4_TX
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      7
    </td>
    
    <td align="CENTER">
      MMC2_DAT5
    </td>
    
    <td align="CENTER">
      MMC2_DAT5
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      8
    </td>
    
    <td align="CENTER">
      UART2_RX
    </td>
    
    <td align="CENTER">
      UART4_RX
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      9
    </td>
    
    <td align="CENTER">
      MMC2_DAT4
    </td>
    
    <td align="CENTER">
      MMC2_DAT4
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      10
    </td>
    
    <td align="CENTER">
      MCBSP3_DR
    </td>
    
    <td align="CENTER">
      MCSPI1_CS1
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      11
    </td>
    
    <td align="CENTER">
      MMC2_DAT3
    </td>
    
    <td align="CENTER">
      MMC2_DAT3
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      12
    </td>
    
    <td align="CENTER">
      MCSPI4_SIMO
    </td>
    
    <td align="CENTER">
      MCSPI1_SIMO
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      13
    </td>
    
    <td align="CENTER">
      MMC2_DAT2
    </td>
    
    <td align="CENTER">
      MMC2_DAT2
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      14
    </td>
    
    <td align="CENTER">
      MCBSP1_CLKX
    </td>
    
    <td align="CENTER">
      MCSPI1_CS2
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      15
    </td>
    
    <td align="CENTER">
      MMC2_DAT1
    </td>
    
    <td align="CENTER">
      MMC2_DAT1
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      16
    </td>
    
    <td align="CENTER">
      MCSPI4_CS0
    </td>
    
    <td align="CENTER">
      MCSPI1_CS0
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      17
    </td>
    
    <td align="CENTER">
      MMC2_DAT0
    </td>
    
    <td align="CENTER">
      MMC2_DAT0
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      18
    </td>
    
    <td align="CENTER">
      MCSPI4_SOMI
    </td>
    
    <td align="CENTER">
      MCSPI1_SOMI
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      19
    </td>
    
    <td align="CENTER">
      MMC2_CMD
    </td>
    
    <td align="CENTER">
      MMC2_CMD
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      20
    </td>
    
    <td align="CENTER">
      MCSPI4_SCLK
    </td>
    
    <td align="CENTER">
      MCSPI1_SCLK
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      21
    </td>
    
    <td align="CENTER">
      MMC2_CLK0
    </td>
    
    <td align="CENTER">
      MMC2_CLK0
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      22
    </td>
    
    <td align="CENTER">
      MCBSP1_FSR
    </td>
    
    <td align="CENTER">
      GPMC_AD15
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      23
    </td>
    
    <td align="CENTER">
      I2C2_SDA
    </td>
    
    <td align="CENTER">
      I2C4_SDA
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      24
    </td>
    
    <td align="CENTER">
      I2C2_SCL
    </td>
    
    <td align="CENTER">
      I2C4_SCL
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      25
    </td>
    
    <td align="CENTER">
      REGEN
    </td>
    
    <td align="CENTER">
      REGEN
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      26
    </td>
    
    <td align="CENTER">
      nRESET
    </td>
    
    <td align="CENTER">
      nRESET
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      27
    </td>
    
    <td align="CENTER">
      GND
    </td>
    
    <td align="CENTER">
      GND
    </td>
  </tr>
  
  <tr>
    <td align="CENTER" height="17">
      28
    </td>
    
    <td align="CENTER">
      GND
    </td>
    
    <td align="CENTER">
      GND
    </td>
  </tr>
</table>

### Component Listing:

Here are the list of components that are used in the PandaBoard with reference to their vendors and part ID. If you are planning to purchase of of these then you should have a closer look at the components used and the actual licence behind the components they have used.

<table style="width: 75%;" border="5" frame="box" rules="all" cellspacing="0" align="CENTER">
  <tr>
    <td>
      <strong>Function</strong>
    </td>
    
    <td>
      <strong>Vendor</strong>
    </td>
    
    <td>
      <strong>Part ID</strong>
    </td>
  </tr>
  
  <tr>
    <td>
      Application Processor
    </td>
    
    <td>
      TI
    </td>
    
    <td>
      <a href="http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12843&contentId=53243" target="_blank">OMAP4460 / OMAP4430</a>
    </td>
  </tr>
  
  <tr>
    <td>
      Memory
    </td>
    
    <td>
      Elpida
    </td>
    
    <td>
      <a href="http://www.elpida.com/en/products/omap.html" target="_blank">EDB8064B1PB-8D-F</a>
    </td>
  </tr>
  
  <tr>
    <td>
      Power Management IC
    </td>
    
    <td>
      TI
    </td>
    
    <td>
      <a href="http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12845&contentId=53245" target="_blank">TWL6030</a>
    </td>
  </tr>
  
  <tr>
    <td>
      Audio IC
    </td>
    
    <td>
      TI
    </td>
    
    <td>
      <a href="http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12845&contentId=53245" target="_blank">TWL6040</a>
    </td>
  </tr>
  
  <tr>
    <td>
      Connectivity
    </td>
    
    <td>
      LSR
    </td>
    
    <td>
      <a href="http://www.lsr.com/products/radio_modules/802.11_BGN_BT/tiwi_r1.shtml">LS240-WI-01-A20</a>
    </td>
  </tr>
  
  <tr>
    <td>
      4 Port USB Hub/Ethernet
    </td>
    
    <td>
      SMSC
    </td>
    
    <td>
      <a href="http://www.smsc.com/media/Downloads_Public/Data_Sheets/9514.pdf" target="_blank">LAN9514-JZX</a>
    </td>
  </tr>
  
  <tr>
    <td>
      DVI Transmitter
    </td>
    
    <td>
      TI
    </td>
    
    <td>
      <a href="http://focus.ti.com/docs/prod/folders/print/tfp410.html" target="_blank">TFP410PAP</a>
    </td>
  </tr>
  
  <tr>
    <td>
      3.5 MM Dual Stacked Audio
    </td>
    
    <td>
      KYCON
    </td>
    
    <td>
      <a href="http://www.kycon.com/Pub_Eng_Draw/STX-4235-3-3-N.pdf" target="_blank">STX-4235-3/3-N</a>
    </td>
  </tr>
</table>

### Display Connection:

<table style="width: 75%;" border="5" frame="box" rules="all" cellspacing="0" align="CENTER">
  <tr>
    <td>
      <strong>Description</strong>
    </td>
    
    <td>
      <strong>PandaBoard Connection</strong>
    </td>
    
    <td>
      <strong>Display Connection</strong>
    </td>
    
    <td>
      <strong>Cable Type</strong>
    </td>
  </tr>
  
  <tr>
    <td>
      H2H
    </td>
    
    <td>
      HDMI Out
    </td>
    
    <td>
      HDMI In
    </td>
    
    <td>
      HDMI-A to HDMI-A
    </td>
  </tr>
  
  <tr>
    <td>
      H2D
    </td>
    
    <td>
      HDMI Out
    </td>
    
    <td>
      DVI In
    </td>
    
    <td>
      HDMI-A to DVI-D
    </td>
  </tr>
  
  <tr>
    <td>
      *D2D
    </td>
    
    <td>
      DVI Out
    </td>
    
    <td>
      DVI In
    </td>
    
    <td>
      HDMI-A to DVI-D
    </td>
  </tr>
  
  <tr>
    <td>
      *D2H
    </td>
    
    <td>
      DVI Out
    </td>
    
    <td>
      HDMI In
    </td>
    
    <td>
      HDMI-A to HDMI-A
    </td>
  </tr>
  
  <tr>
    <td colspan="4">
      *Note: Not Yet Supported
    </td>
  </tr>
</table>

### Board Revisions & Documentation:

#### PandaBoard ESA Rev B1 (Latest)

<table style="width: 75%;" border="5" frame="box" rules="all" cellspacing="0" align="CENTER">
  <tr>
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-es-b/panda-es-b-manual.pdf">User Manuals</a>
    </td>
    
    <td>
      Schematics (<a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-es-b/panda-es-b-orcard.dsn">DSN</a>) (<a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-es-b/panda-es-b-schematic.pdf">PDF</a>)
    </td>
  </tr>
  
  <tr>
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-es-b/panda-es-b-gerbers.zip">Gerber File</a>
    </td>
    
    <td>
      Allegro Design File (<a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-es-b/panda-es-b-allegro.brd">BRD File</a>) (<a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-es-b/panda-es-b-allegro.pdf">PDF</a>)
    </td>
  </tr>
  
  <tr>
    <td>
      <a href="http://pandaboard.org/node/223/#PBESBlockDiagram">Block Diagram</a>
    </td>
    
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-es-b/panda-es-b-bom.xls">Bill of Materials (BOM)</a>
    </td>
  </tr>
  
  <tr>
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-es-b/panda-es-b-autocad.dxf">AutoCAD DXF</a>
    </td>
    
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-es-b/panda-es-b-stackup.pdf">Stackup File</a>
    </td>
  </tr>
</table>

#### PandaBoard REV A1 & A2\*, A3\**

<table style="width: 75%;" border="5" frame="box" rules="all" cellspacing="0" align="CENTER">
  <tr>
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-manual.pdf">User Manuals</a>
    </td>
    
    <td>
      SchematicsA <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-orcad.dsn">(DSN)</a>A <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-schematic.pdf">(PDF)</a>
    </td>
  </tr>
  
  <tr>
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-gerbers.zip">Gerber File</a>
    </td>
    
    <td>
      Allegro Design File (<a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-allegro.brd">BRD File</a>) (<a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-allegro.pdf">PDF</a>)
    </td>
  </tr>
  
  <tr>
    <td>
      <a href="http://pandaboard.org/node/223/#">Block Diagram</a>
    </td>
    
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-bom.xls">Bill of Materials (BOM)</a>
    </td>
  </tr>
  
  <tr>
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-autocad.dxf">AutoCAD DXF</a>
    </td>
    
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-a-stackup.pdf">Stackup File</a>
    </td>
  </tr>
</table>

<span style="color: #808080;"><em>*A Rev A2 is the same as A1 except it has:<b>A </b>the new LSR TiWi-R2 connectivity module populatedA (Rev A1 of PandaBoard contained the LSR TiWi-R1 module and the footprint of the module has changed in TiWi-R2 to improve manufacturability. See theA <a title="http://www.lsr.com/downloads/tiwi_r2/TiWi_R2_Footprint_Migration.pdf" href="http://www.lsr.com/downloads/tiwi_r2/TiWi_R2_Footprint_Migration.pdf" rel="nofollow"><span style="color: #808080;">footprint migration</span></a>A document for more details.)</em></span>

<span style="color: #808080;"><em>**A Rev A3 is the same as A2 except it has:<b>A </b>OMAP4430 ES2.2 silicon version</em></span>

#### REV EA1 (PEAP platforms)

<table style="width: 75%;" border="5" frame="box" rules="all" cellspacing="0" align="CENTER">
  <tr>
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-ea1/panda-ea1-manual.pdf">User Manuals</a>
    </td>
    
    <td>
      SchematicsA <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-ea1/panda-ea1-schematic.pdf">(PDF)</a>
    </td>
  </tr>
  
  <tr>
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-ea1/panda-ea1-gerbers.zip">Gerber File</a>
    </td>
    
    <td>
      Allegro Design File (<a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-ea1/panda-ea1-allegro.brd">BRD File</a>) (<a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-ea1/panda-ea1-allegro.pdf">PDF</a>)
    </td>
  </tr>
  
  <tr>
    <td>
      <a href="http://pandaboard.org/node/223/#">Block Diagram</a>
    </td>
    
    <td>
      <a href="http://pandaboard.org/sites/default/files/board_reference/pandaboard-a/panda-ea1-bom.xls">Bill of Materials (BOM)</a>
    </td>
  </tr>
</table>

### PandaBoard Accessories & Peripherals: {#firstHeading}

The PandaBoard comes as is. That is it cannot be used fully out of the box. There are a list of accessories that you might have to purchase in order to use all the above features to its fullest extent. You can find a list of all the officially approved accessories here.

<http://pandaboard.org/content/resources/Accessories>

### Conclusion:

PandaBoard is a good choice if you a seasoned Linux user looking forward to some real beast in terms of processing and computation powers. For beginners and intermediate level users you might have to wait a little longer to use this board. There are other boards that will suit your need properly.

Read our posts on the review of <a title="BeagleBone aEUR" Detailed Technical Review" href="http://embedjournal.com/2013/06/beaglebone-a-quick-review/" target="_blank">BeagleBone</a> and <a title="Raspberry Pi: LetaEURtms take a bite from it!" href="http://embedjournal.com/2013/06/raspberry-pi-lets-take-a-bite/" target="_blank">RaspberryPi</a>. You can <a href="http://embedjournal.com/subscribe/" target="_blank">subscribe to our posts and newsletters</a> using the subscribe button below to get out latest posts straight to you inbox!!

<span style="line-height: 13px;">A </span>