---
title: Make a Digital Clock with DS1307 and PIC 18F4520
date: 2013-07-19T11:34:58+00:00
author: Siddharth
layout: post
thumbnail: post-thumb.jpg
permalink: /make-a-digital-clock/
dsq_thread_id: "2728571391"
popular_post: true
categories: [ "How To", "Microchip PIC" ]
tags: [ "DIY", "Interface", "Programming", "RTC", "I2C" ]
---

Digital clocks are are very commonly (cheaply)A availableA these days. Some of them have a built in RTC to keep the time running even if the main battery fails and some of them don't. In either case, for anA offline embedded application to get a time stamp, an RTC in almost the only cheap solution solution available. Most of these clocks use a 7-Segment display to display the time and date while some use LCD displays.A In this post we will see how to make a digital clock with DS1307 and PIC 18F4520.

Besides this is a project to show off your geekish skills to the world. Make a digital clock all by yourself and hang is in you room and let the presence on an Embedded Engineer be known!

### What does it take to make a digital clock?

[<img class="aligncenter size-large wp-image-1358" src="/images/posts/2013/07/Untitled-1024x199.png" alt="Untitled" width="618" height="120" srcset="/images/posts/2013/07/Untitled-1024x199.png 1024w, /images/posts/2013/07/Untitled-300x58.png 300w, /images/posts/2013/07/Untitled.png 1070w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/07/Untitled.png)

Other than time and effort you will need the following components to make a digital clock.

  * <span style="line-height: 13px;">PIC Microcontroller (<a title="Datasheet" href="http://ww1.microchip.com/downloads/en/DeviceDoc/39631b.pdf">PIC18F4520</a>)</span>
  * LCD Display
  * RTC <a title="Datasheet" href="http://datasheets.maximintegrated.com/en/ds/DS1307.pdf" target="_blank">DS1307</a>
  * CMOS Battery and its slot.

### Prerequisite

For this tutorial I assume you have a working knowledge about the I2C Protocol (<a title="I2C Protocol (2-Wire Interface) in a nut shell" href="http://embedjournal.com/2013/05/two-wire-interface-i2c-protocol-in-a-nut-shell/" target="_blank">Read about I2C protocol</a>), interfacing DS1307 (<a title="Interfacing RTC with Microcontroller" href="http://embedjournal.com/2013/05/interfacing-rtc-with-microcontroller/" target="_blank">Read about DS1307</a>), and programming an LCD module (<a title="Interfacing LCD Module with Microcontroller: Part -1" href="http://embedjournal.com/2013/06/interfacing-lcd-module-part-1/" target="_blank">Read LCD Basics</a>) inA <a title="Programming LCD in 8 bit mode aEUR" Part -2" href="http://embedjournal.com/2013/06/programming-lcd-in-8-bit-mode/" target="_blank">8 bit</a> or <a title="Interface aEUR" LCD in 4 bit Mode: Part 3" href="http://embedjournal.com/2013/07/interface-lcd-in-4-bit-mode/" target="_blank">4 bit</a> mode.

The image above uses the LCD in 8 bit mode but any thing should work. If you do not know any of the above please read through them first and then get back to this post you can follow the links to read all the relevant posts (if it's not very obvious).

So now you should have the following C source files and header files added to your project. If you do not have any one of these files either written by yourself orA downloaded form my previous posts (links specified in theA prerequisite section) the following code will not work.

You can find a link to download the entire project at the end of the post.

<div class="one_half">
  <ul>
    <li>
      rtc.c
    </li>
    <li>
      i2c.c
    </li>
    <li>
      lcd.c
    </li>
  </ul>
</div>

  * rtc.h
  * i2c.h
  * lcd.h

Now that know how to read and write data to the RTC, all that is remaining is to get the values form an RTC's timekeeping registers and display them in the LCD display. This is how we are going to arrange the received data on the screen,

[<img class="aligncenter size-large wp-image-1334" src="/images/posts/2013/07/DSC08035-1024x576.jpg" alt="digital clock lcd" width="618" height="347" srcset="/images/posts/2013/07/DSC08035-1024x576.jpg 1024w, /images/posts/2013/07/DSC08035-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/07/DSC08035.jpg)

I use a 20x4 line LCD display. Here is the Display Data RAM addresses to which the data will be written to. The source code below will use this table as the reference for the display. If you are using an LCD with a different configuration, you might have to modify the DD RAM address accordingly for this code to work.

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

For making this digital clock, you will have to acquire information on the time, date and day form the RTC. After getting them you will have to display them on the LCD display. The time and date information that is read form the RTC is not it a format that can be displayed on the LCD. So we have to do some processing before the data can be printed to the LCD. For this we will write some subroutines that will take care of the job.

Here is a function that basically calls the other subroutines that actually does all the processing of the data. So this is just a wrapper function so that we don't have to call the individual functions separately.

<pre>void display(void)
{
    time(get_time(2),get_time(1),get_time(0));
    date(get_time(4),get_time(5),get_time(6));
    day(get_time(3));
}</pre>

We will also need two global variables 'units' and 'tens' A for splitting the data into higher nibble and lower nibble (in case of the RTC its the tens digit and units digit of the data)

### Function to display the Time

This function is used to display the time in the LCD display. It takes the time value as a parameter and converts them into printable data and puts them in their corresponding positions in the display. Again this is a code for the 20x4 LCD. If you have some other module modify the DD RAM address.
  
Note: the variable units and tens are global variableA and are updated every time the decode() is called.

<pre>void time(unsigned int hours,unsigned int minutes,unsigned int seconds)
{
    decode(hours); // sepatates the variable into highr and lower nibble
    if(tens>3)     // To set AM or PM
    {
        if((tens == 6)|(tens == 7))
        {
            LCD_cmd(0xCF);
            LCD_data('P');
            LCD_data('M');
            tens=tens&1;
        }
        else if((tens == 4)|(tens == 5))
        {
            LCD_cmd(0xCF);
            LCD_data('A');
            LCD_data('M');
            tens=tens&1;
        }
    }
    else
    {
        LCD_cmd(0xCF);
        LCD_data(' ');
        LCD_data(' ');
    }
    LCD_cmd(0xC6);
    LCD_data(tens+48);   // Add 48 to display ASCII value of number
    LCD_data(units+48);

    LCD_cmd(0xC9);
    decode(minutes);        
    LCD_data(tens+48);
    LCD_data(units+48);

    LCD_cmd(0xCC);
    decode(seconds);        
    LCD_data(tens+48);
    LCD_data(units+48);

}</pre>

### Function to display the Date, Month and Year

The date, month and year values read from the RTC are provided as parameters for this function. Here the numerical (decimal) data is translated to ASCII values and are written to the LCD module at appropriate character positions.
  
Note: the variable units and tens are global variableA and are updated every time the decode() is called.

<pre lang="c">void date(unsigned int date, unsigned int month,unsigned int year)
{
    LCD_cmd(0x9A);
    decode(date);       
    LCD_data(tens+48);
    LCD_data(units+48);

    LCD_cmd(0x9D);
    decode(month);      
    LCD_data(tens+48);
    LCD_data(units+48);

    LCD_cmd(0xA2);
    decode(year);       
    LCD_data(tens+48);
    LCD_data(units+48);
}</pre>

### Function to display the Day

The day is represented as a number (with 0 representing Sunday) in the RTC time keeping registers. A switch case was the most common way to decode it into the actual day and print it on the LCD display

<pre>void day(unsigned int disp){
    LCD_cmd(0xD9);
    LCD_data('                ');   // to clear past memory
    LCD_cmd(0xDA);
    switch(disp){
	case 1:LCD_string("Sunday");
               break;
	case 2:LCD_string("Monday");
               break;
	case 3:LCD_string("Tuesday");
               break;
	case 4:LCD_string("Wednesday");
               break;
	case 5:LCD_string("Thursday");
               break;
	case 6:LCD_string("Friday");
               break;
	case 7:LCD_string("Saturday");
               break;
    }
}</pre>

Asides these function we will need a function to decode the data into the units and tens place. This function also updates the values of the global variables units and tens.

<pre>// Function separates the variable into higher and lower nibble
void decode(unsigned int val)
{
    tens=val>>4;
    units=val&0x0F;
    return;
}</pre>

Now all that you have to do is to collect all these functions and put them in a file called clock.c and create a clock.h to be included in your main program.

### Download Related Files

Here are the C Files, the HEX file and the Mplab X project folder for the above tutorial.

  * <a href="https://www.dropbox.com/s/3i03pqg76iqi683/digitalclock_V2.0.X.production.hex" target="_blank">Pre Built HEX file</a>
  * <a title="Dropbox" href="https://www.dropbox.com/s/8x01zq0jvfgyw3j/digitalclock_V2.0.X.rar" target="_blank"><span style="line-height: 13px;">Mplab X project file</span></a>
  * <a title="Dropbox" href="https://www.dropbox.com/s/xtkw11ygmdh6u1p/digital_clock_lib.rar" target="_blank">C library</a>

I hope this post was to an extent helpful in the process of making a digital clock. If you are facing any problems leave a comment below and we will sort it out.
