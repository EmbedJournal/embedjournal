---
id: 880
title: "Interfacing LCD Module with Microcontroller: Part -1"
date: 2013-06-25T11:15:02+00:00
author: Siddharth
layout: post
permalink: /interfacing-lcd-module-part-1/
dsq_thread_id: "2728571244"

image: /wp-content/uploads/2013/06/DSC09429.jpg
categories: [ "Basics", "Embedded Systems", "PIC Microcontroller" ]
tags: [ "embedded system", "interface", "LCD", "PIC" ]
---

The LCD module interface with a microcontroller is simple and it is a primitive means of adding a visual appeal to your embedded application. There are two basic types of LCD modules in the market they are, <a title="Wiki" href="http://en.wikipedia.org/wiki/Hitachi_HD44780_LCD_controller" target="_blank">Character LCD</a> and <a title="wiki" href="http://en.wikipedia.org/wiki/Graphics_display_resolution" target="_blank">Graphics LCD</a>. Character LCDaEURtms are the some of the cheapest means LCD displays available today.

[<img class="aligncenter size-large wp-image-900" alt="lcd interface" src="/images/posts/2013/06/DSC09429-1024x576.jpg" width="618" height="347" srcset="/images/posts/2013/06/DSC09429-1024x576.jpg 1024w, /images/posts/2013/06/DSC09429-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/06/DSC09429.jpg)

This post is first of a series of four posts that walks through entire process of interfacing an LCD module with a (any) microcontroller with all the basicA conceptsA dealt in detail. Subscribe to our post with your email using the subscribe button in the right sidebar and get free updates on these follow-up posts.

  1. <span style="line-height: 13px; color: #808080;">LCD Module Basic Theory. (LCD Controllers, CG&DD RAM, PINA description,Timing Diagram,A Commands)</span>
  2. <a title="Programming LCD in 8 bit mode aEUR" Part -2" href="http://embedjournal.com/2013/06/programming-lcd-in-8-bit-mode/" target="_blank">Programming LCDs in 8 bit mode. (programming pic18f4520 in C with C18 compiler under 8 bit mode)</a>
  3. <a title="Interface aEUR" LCD in 4 bit Mode: Part 3" href="http://embedjournal.com/2013/07/interface-lcd-in-4-bit-mode/" target="_blank">Programming LCDs in 4 bit mode.A (programming pic18f4520 in C with C18 compiler under 4 bit mode)</a>
  4. Creating Custom Characters (bit map symbols and arrows that are not usually present in the ASCII table)

This Post will cover the basic theory that you should have a clearA understandingA before getting started with the programming. Some of the sections below are not really essential for the interface but it is a good practice to have a thorough knowledge about what you areA indulgingA in. Whereas some listed below are absolutely mandatory to understand how the LCD module works and to predict how it will behave for a given situation.

You are free to choose which to read and which to skim (that is if you know what you are doing).

### **LCD Controllers:**

The LCD module has display controller that are used toA receiveA the data from theA controller use it to display the data in a legible format. These controller have and embedded font set that can be addressed by sending the corresponding ASCII value of the the character to be printed.

Most LCD module have a <a title="read more" href="http://en.wikipedia.org/wiki/Hitachi_HD44780_LCD_controller" target="_blank">HD44780</a> or compatible controller which is specially designed to build LCDs with one or two lines with a maximum of 40 character positions each. They are ASIC (<a title="wiki" href="https://en.wikipedia.org/wiki/Application-specific_integrated_circuit" target="_blank">Application Specific Integrated Circuit</a>). A single HD44780 is able to display two lines of 8 characters each.

If we want more, the HD44780 has to be expanded with one or more expansion chips, like the HD44100 (2 x 8 characters expansion) or the HD66100 (2 x 16 characters expansion). Seen from the HD44780, the first line starts with 00h; the second line with 40h.

### **16 x 2 LCD Modules:**

[<img class="size-thumbnail wp-image-940 alignright" alt="16x2 LCD module" src="/images/posts/2013/06/16x2-LCD-module-150x150.jpg" width="150" height="150" srcset="/images/posts/2013/06/16x2-LCD-module-150x150.jpg 150w, /images/posts/2013/06/16x2-LCD-module-300x300.jpg 300w, /images/posts/2013/06/16x2-LCD-module.jpg 600w" sizes="(max-width: 150px) 100vw, 150px" />](/images/posts/2013/06/16x2-LCD-module.jpg)

This the most common configuration of LCD that most peopleA prefer mostly due to reduced cost and small footprint.A In a 16 x 2 line display LCD module, each the two lines have 40 character positions of which only 16 can be displayed at a time. The remaining positions are invisible and cannot be seen. To display the remaining 24 characters, the LCD has an option to move the window of characters displayed to the right or left so that; it appears as though the characters are scrolling. Here is a table of the DD RAM addresses that are within the visible data region. Note that in this module, DD RAM locations 10 to 27 on the first line and 51 to 67 are not covered by the displayable window of 16A character per line.

<table class="aligncenter" style="width: 100%;" border="1" cellspacing="0" cellpadding="5" align="center">
  <tr>
    <td>
      First Line
    </td>
    
    <td>
      00
    </td>
    
    <td>
      01
    </td>
    
    <td>
      02
    </td>
    
    <td>
      -3
    </td>
    
    <td>
      04
    </td>
    
    <td>
      05
    </td>
    
    <td>
      06
    </td>
    
    <td>
      07
    </td>
    
    <td>
      08
    </td>
    
    <td>
      09
    </td>
    
    <td>
      0A
    </td>
    
    <td>
      0B
    </td>
    
    <td>
      0C
    </td>
    
    <td>
      0D
    </td>
    
    <td>
      0E
    </td>
    
    <td>
      0F
    </td>
  </tr>
  
  <tr>
    <td>
      Second Line
    </td>
    
    <td>
      40
    </td>
    
    <td>
      41
    </td>
    
    <td>
      42
    </td>
    
    <td>
      43
    </td>
    
    <td>
      44
    </td>
    
    <td>
      45
    </td>
    
    <td>
      46
    </td>
    
    <td>
      47
    </td>
    
    <td>
      48
    </td>
    
    <td>
      49
    </td>
    
    <td>
      4A
    </td>
    
    <td>
      4B
    </td>
    
    <td>
      4C
    </td>
    
    <td>
      4D
    </td>
    
    <td>
      4E
    </td>
    
    <td>
      4F
    </td>
  </tr>
</table>

### 

### **20 x 4 LCD Module:**

[<img class="size-thumbnail wp-image-857 alignright" alt="Character LCD Command Sheet" src="/images/posts/2013/06/20x4-Character-LCD-Module-150x150.jpg" width="150" height="150" />](/images/posts/2013/06/20x4-Character-LCD-Module.jpg)

The 20 x 4 display module is a slight variant of the 16 x 2 Module such that, aA single 40 character (of which 16 are displayable) line is split up into 2 halves of 20 displayable characters each to make 4 lines.A Here the first line displays the first 20 DD RAM locations (00 - 13) and the third line displays theA remaining 20 DD RAM locations (14 - 53) of the first line in the case of 16 x 2 LCD Module.A And the second line displays the first 20 DD RAM locations (40 - 53) and the fourth line displays theA remaining 20 DD RAM locations (54 - 67) of the second line in the case of 16 x 2 LCD Module.A This is the module that I am using for this post. It has the disadvantage of not being able to scroll but looks better with 4 displayable lines.A Here is a table of the DD RAM addresses that are within the visible region.

<table class="aligncenter" style="width: 100%;" border="1" cellspacing="0" cellpadding="5" align="center">
  <tr>
    <td>
      Line1
    </td>
    
    <td>
      00
    </td>
    
    <td>
      01
    </td>
    
    <td>
      02
    </td>
    
    <td>
      03
    </td>
    
    <td>
      04
    </td>
    
    <td>
      05
    </td>
    
    <td>
      06
    </td>
    
    <td>
      07
    </td>
    
    <td>
      08
    </td>
    
    <td>
      09
    </td>
    
    <td>
      0A
    </td>
    
    <td>
      0B
    </td>
    
    <td>
      0C
    </td>
    
    <td>
      0D
    </td>
    
    <td>
      0E
    </td>
    
    <td>
      0F
    </td>
    
    <td>
      10
    </td>
    
    <td>
      11
    </td>
    
    <td>
      12
    </td>
    
    <td>
      13
    </td>
  </tr>
  
  <tr>
    <td>
      Line2
    </td>
    
    <td>
      40
    </td>
    
    <td>
      41
    </td>
    
    <td>
      42
    </td>
    
    <td>
      43
    </td>
    
    <td>
      44
    </td>
    
    <td>
      45
    </td>
    
    <td>
      46
    </td>
    
    <td>
      47
    </td>
    
    <td>
      48
    </td>
    
    <td>
      49
    </td>
    
    <td>
      4A
    </td>
    
    <td>
      4B
    </td>
    
    <td>
      4C
    </td>
    
    <td>
      4D
    </td>
    
    <td>
      4E
    </td>
    
    <td>
      4F
    </td>
    
    <td>
      50
    </td>
    
    <td>
      51
    </td>
    
    <td>
      52
    </td>
    
    <td>
      53
    </td>
  </tr>
  
  <tr>
    <td>
      Line3
    </td>
    
    <td>
      14
    </td>
    
    <td>
      15
    </td>
    
    <td>
      16
    </td>
    
    <td>
      17
    </td>
    
    <td>
      18
    </td>
    
    <td>
      19
    </td>
    
    <td>
      1A
    </td>
    
    <td>
      1B
    </td>
    
    <td>
      1C
    </td>
    
    <td>
      1D
    </td>
    
    <td>
      1E
    </td>
    
    <td>
      1F
    </td>
    
    <td>
      20
    </td>
    
    <td>
      21
    </td>
    
    <td>
      22
    </td>
    
    <td>
      23
    </td>
    
    <td>
      24
    </td>
    
    <td>
      25
    </td>
    
    <td>
      26
    </td>
    
    <td>
      27
    </td>
  </tr>
  
  <tr>
    <td>
      Line4
    </td>
    
    <td>
      54
    </td>
    
    <td>
      55
    </td>
    
    <td>
      56
    </td>
    
    <td>
      57
    </td>
    
    <td>
      58
    </td>
    
    <td>
      59
    </td>
    
    <td>
      5A
    </td>
    
    <td>
      5B
    </td>
    
    <td>
      5C
    </td>
    
    <td>
      5D
    </td>
    
    <td>
      5E
    </td>
    
    <td>
      5F
    </td>
    
    <td>
      60
    </td>
    
    <td>
      61
    </td>
    
    <td>
      62
    </td>
    
    <td>
      63
    </td>
    
    <td>
      64
    </td>
    
    <td>
      65
    </td>
    
    <td>
      66
    </td>
    
    <td>
      67
    </td>
  </tr>
</table>

### **PIN Description:**

<table class="aligncenter" style="width: 75%;" border="1" cellspacing="0" align="center">
  <tr align="center" valign="middle">
    <td>
      <strong>Pin Number</strong>
    </td>
    
    <td>
      <strong>Name</strong>
    </td>
    
    <td>
      <strong>Description</strong>
    </td>
  </tr>
  
  <tr align="left">
    <td>
      1
    </td>
    
    <td>
      GND (0v)
    </td>
    
    <td>
      Ground Potential
    </td>
  </tr>
  
  <tr align="left">
    <td>
      2
    </td>
    
    <td>
      VCC (5v)
    </td>
    
    <td>
      Positive Voltage
    </td>
  </tr>
  
  <tr align="left">
    <td>
      3
    </td>
    
    <td>
      Contrast
    </td>
    
    <td>
      Contrast adjustment; 0v: Max contrast; 5v: Min contrast
    </td>
  </tr>
  
  <tr align="left">
    <td>
      4
    </td>
    
    <td>
      RS
    </td>
    
    <td>
      Register Select; 0: InstructionA RegisterA 1: Data Register
    </td>
  </tr>
  
  <tr align="left">
    <td>
      5
    </td>
    
    <td>
      RW
    </td>
    
    <td>
      Read Write Select pin 0: Write mode; 1: Read mode;
    </td>
  </tr>
  
  <tr align="left">
    <td>
      6
    </td>
    
    <td>
      EN
    </td>
    
    <td>
      A Enable Pin To enable the LCD Module
    </td>
  </tr>
  
  <tr align="left">
    <td>
      7
    </td>
    
    <td>
      DB0
    </td>
    
    <td class="aligncenter" rowspan="8" align="center" valign="middle">
      LCD Data Bus line. They are responsible for theA parallel dataA transfer. DB7 is used to check the busy Flag.In 4 bitA mode, DB0 to DB3 are not used and are left open.
    </td>
  </tr>
  
  <tr align="left">
    <td>
      8
    </td>
    
    <td>
      DB1
    </td>
  </tr>
  
  <tr align="left">
    <td>
      9
    </td>
    
    <td>
      DB2
    </td>
  </tr>
  
  <tr align="left">
    <td>
      10
    </td>
    
    <td>
      DB3
    </td>
  </tr>
  
  <tr align="left">
    <td>
      11
    </td>
    
    <td>
      DB4
    </td>
  </tr>
  
  <tr align="left">
    <td>
      13
    </td>
    
    <td>
      DB5
    </td>
  </tr>
  
  <tr align="left">
    <td>
      14
    </td>
    
    <td>
      DB6
    </td>
  </tr>
  
  <tr align="left">
    <td>
      15
    </td>
    
    <td>
      DB7
    </td>
  </tr>
  
  <tr align="left">
    <td>
      16
    </td>
    
    <td>
      A LED+ (A)
    </td>
    
    <td>
      A Back Light Source LED Anode
    </td>
  </tr>
  
  <tr align="left">
    <td>
      17
    </td>
    
    <td>
      LCD- (K)
    </td>
    
    <td>
      Back Light Source LED Cathode
    </td>
  </tr>
</table>

### <b style="font-size: 1.17em;">Registers:</b>

There are two registers in an LCD, they are Instruction register and the Data register. The register select (RS) pin is used to select either of the two the registers. When held low, the Instruction register is selected and similarly, when it is high, the data register is selected. A write to the data register will write to the Display Data RAM (DD RAM) in the address last pointed by the address pointer. The address pointer is automatically incremented after each write operation.

In the 20 x 4 LCD Module, all the locations of the DD Ram are mapped on to a character position in the display. Hence a write to the data register with proper ASCII code will produce proper displayable character in the screen. You can find a good <a title="ASCII table" href="http://www.asciitable.com/" target="_blank">ASCII table here</a>. Some of the values in the ASCII table are not printable and hence are not mapped on to any character. A write to the DD Ram with one such data will display some glyph that you cannot recognize.

The <a title="datasheet" href="http://www.xilinx.com/products/boards/ml501/datasheets/TM162VCA6_SPEC.pdf" target="_blank">LCD datasheet</a> comes with a lot of electrical and Mechanical specifications. Though they are not redundant, for now we will consider only the command sheet and the timing diagram without which it is impossible to interface the module.

### **Command Sheet:**

The command sheet is a table which contains the various commands that can be issued to the LCD module so that it behaves as intended. I have not attached an image of the command sheet as I could not find any of a good readable resolution. So I created a HTML version of the command sheet that you could use at any resolution dYtm, You can find the <a title="Character LCD Command Sheet HTML Version" href="http://embedjournal.com/2013/06/character-lcd-command-sheet/" target="_blank">Command Sheet here</a>A (or I should call it command page). The cells that are filled with absolute values have to be used as such and the ones that are having letters are variables and take either 0 or 1 based on the task it has to perform.

For example, the Display ON/OFF Control command has the following fields,

<table border="1" cellspacing="0" cellpadding="5" align="center">
  <tr valign="TOP">
    <td width="50">
      RS
    </td>
    
    <td width="50">
      R/W
    </td>
    
    <td width="50">
      D7
    </td>
    
    <td width="50">
      D6
    </td>
    
    <td width="50">
      D5
    </td>
    
    <td width="50">
      D4
    </td>
    
    <td width="50">
      D3
    </td>
    
    <td width="50">
      D2
    </td>
    
    <td width="50">
      D1
    </td>
    
    <td width="50">
      D0
    </td>
  </tr>
  
  <tr valign="TOP">
    <td width="50">
    </td>
    
    <td width="50">
    </td>
    
    <td width="50">
    </td>
    
    <td width="50">
    </td>
    
    <td width="50">
    </td>
    
    <td width="50">
    </td>
    
    <td width="50">
      1
    </td>
    
    <td width="50">
      D
    </td>
    
    <td width="50">
      C
    </td>
    
    <td width="50">
      B
    </td>
  </tr>
</table>

Here, D4:D7 are 0aEURtms, D3 is 1 and RS and R/W are held low. These are all constant values. They have to be used as such. But the, bits D0:D2 are all variables.

D = 0 aEUR" Turns the display OFF D = 1 aEUR" Turns ON the display

C = 0 aEUR" Turns the Cursor OFF C = 1 aEUR" Turns the Cursor ON

B = 0 aEUR" Character at the cursor is static B = 1 aEUR" Character at the cursor is blinking.

According to this description, the value has to be written to the command register. That is if you want, display ON, cursor ON and the character at the cursor to be static, you have to write, 0x0E while holding the RS and RW lines Low.

### **Timing Diagrams:**

There are two basic timing diagrams, one for the read operation and another for the write operation. Both of them are very important and has to be adhered to. Reading and understand timing diagrams is an important skill that has to be mastered.

**Read Operation:**

<p style="text-align: center;">
  <strong><a href="/images/posts/2013/06/write-operation.png"><img class="aligncenter  wp-image-908" alt="write operation" src="/images/posts/2013/06/write-operation.png" width="811" height="507" srcset="/images/posts/2013/06/write-operation.png 901w, /images/posts/2013/06/write-operation-300x187.png 300w" sizes="(max-width: 811px) 100vw, 811px" /></a> <a href="/images/posts/2013/06/write.png"><img class="aligncenter size-full wp-image-909" alt="write timing" src="/images/posts/2013/06/write.png" width="742" height="206" srcset="/images/posts/2013/06/write.png 742w, /images/posts/2013/06/write-300x83.png 300w" sizes="(max-width: 742px) 100vw, 742px" /></a></strong>
</p>

**Write Operation:**

<p style="text-align: center;">
  <a href="/images/posts/2013/06/Read-operation.png"><img class="aligncenter  wp-image-912" alt="Read operation" src="/images/posts/2013/06/Read-operation.png" width="795" height="506" srcset="/images/posts/2013/06/Read-operation.png 883w, /images/posts/2013/06/Read-operation-300x191.png 300w" sizes="(max-width: 795px) 100vw, 795px" /></a>
</p>

<p style="text-align: center;">
  <a href="/images/posts/2013/06/read.png"><img class="aligncenter size-full wp-image-911" alt="read timing" src="/images/posts/2013/06/read.png" width="742" height="185" srcset="/images/posts/2013/06/read.png 742w, /images/posts/2013/06/read-300x75.png 300w" sizes="(max-width: 742px) 100vw, 742px" /></a>
</p>

<p style="text-align: left;">
  <strong>Yet another timing diagram!A </strong>
</p>

<p style="text-align: left;">
  Lastly, here is another timing diagram that you will be hard pushed find else where. Apparently, it A is not only the software that can initialize the LCD module but the hardware too. You could use hardware timing to initialize the module. Here is its description.
</p>

<p style="text-align: left;">
  <a href="/images/posts/2013/06/init.png"><img class="aligncenter size-full wp-image-914" alt="initialize LCD module" src="/images/posts/2013/06/init.png" width="807" height="214" srcset="/images/posts/2013/06/init.png 807w, /images/posts/2013/06/init-300x80.png 300w" sizes="(max-width: 807px) 100vw, 807px" /></a>
</p>

### **Microcontroller Pin Requirements:**

As you know these LCDs have a built in font set and can be used by indexing the ASCII value of the corresponding character. It capable of operating on 8 data lines (D0 to D7) or on 4 data lines (D4 to D7). The upcoming A posts will discuss the 8 bit and 4 bit mode of LCD interface. Other than the data lines the LCD needs 3 command lines - RS, R/W and EN. Therefore in total, an LCD interface will need 11 (8+3) or 7 (4+3) pins of the microcontroller.

It is possible to further reduce the total number of port pins required from 7 (4+3) to 6 (4+2) by shorting the R/W pin to ground. If the R/W pin is connected to the ground, the LCD can be used to write data only. Reading from it is not possible. So we are not able to read the busy flag from the module. To live with this disability, we are forced to provide ample amount of delay loops (and hence compromise on the speed of execution) so that the LCD is seldom busy doing thing when new data is given.

<a href="http://embedjournal.com/subscribe/" target="_blank">Subscribe to our posts and newsletters</a>A to stay updated with the upcoming series of this tutorial and get our posts delivered to your inbox.

Update: <a title="Programming LCD in 8 bit mode aEUR" Part -2" href="http://embedjournal.com/2013/06/programming-lcd-in-8-bit-mode/" target="_blank">Part 2 of this post in now available</a>.