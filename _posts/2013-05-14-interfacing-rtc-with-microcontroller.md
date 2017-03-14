---
title: Interfacing RTC with Microcontroller
date: 2013-05-14T18:26:31+00:00
author: Siddharth
layout: post
permalink: /interfacing-rtc-with-microcontroller/
dsq_thread_id: "2728571110"
categories: [ "Embedded Theory" ]
tags: [ "I2C", "Interface", "RTC" ]
---

Have you ever wondered how your PC and phones keep track of time even when the device is turned OFF? Well there is aA <a title="Real-time clock" href="http://en.wikipedia.org/wiki/Real-time_clock" target="_blank" rel="wikipedia">Real Time Clock</a>A (RTC) that is kept powered even is the device is turned OFF. Once the device is turned ON and connected to the internet the device connects to aA <a title="Network Time Protocol" href="http://ntp.org/" target="_blank" rel="homepage">NTP server</a>A (Network Time Protocol) and updates the time and date. This post is intended to give a little insight over these RTCs and their interface with mid-range 8-bit microcontollers withA <a title="IA2C" href="http://en.wikipedia.org/wiki/I%C2%B2C" target="_blank" rel="wikipedia">I2C</a>A interface. It is possible to define a software I2C library if your favorite controller does not have a I2C bus, but that is beyond the scope of this post. This post will walk you through the steps involved in interfacing RTC with microcontroller.

**What are we looking at?**

<p style="text-align: center;">
  <a href="/images/posts/2013/05/dsc08038.jpg"><img class="aligncenter  wp-image-95" title="Interfacing RTC with Microcontroller" alt="Interfacing RTC with Microcontroller" src="/images/posts/2013/05/dsc08038.jpg" width="691" height="389" srcset="/images/posts/2013/05/dsc08038.jpg 1920w, /images/posts/2013/05/dsc08038-300x169.jpg 300w, /images/posts/2013/05/dsc08038-1024x576.jpg 1024w" sizes="(max-width: 691px) 100vw, 691px" /></a>
</p>

This how the competed project will look like (at lest mine did)A once you have gone through the entire postA ![:)](http://s0.wp.com/wp-includes/images/smilies/icon_smile.gif?m=1129645325g)A The LCD display is a standard 20A character 4 line module. Asides that I have a MCU section on the right and the RTC andA <a title="EEPROM" href="http://en.wikipedia.org/wiki/EEPROM" target="_blank" rel="wikipedia">EEPROM</a>A breakout board with a CMOS battery on the left. You donaEURtmt have to have a module to get started with you can make the circuit connection on a GP board or on a breadboard. Here is a schematic of the DS1307, as for the PIC schematic I leave it to you to make your own schematic.

<p style="text-align: center;">
  <a href="/images/posts/2013/05/untitled51.png"><img class="aligncenter size-full wp-image-58" alt="Interfacing RTC with Microcontroller - Schematic" src="/images/posts/2013/05/untitled51.png" width="712" height="383" srcset="/images/posts/2013/05/untitled51.png 712w, /images/posts/2013/05/untitled51-300x161.png 300w" sizes="(max-width: 712px) 100vw, 712px" /></a>
</p>

I have chosen PIC18f4520 as my controller because of it availability and features. But that doesn't mean this document is restricted only to the interfacing RTCA with this MCU only. If you are a PIC user then you are way off most of the code can be reused with minor modification. If you prefer using other families of controller (and good with it) you should be able to port the code to your own controller. If everything goes as intended by the end of this post you should be able to interface the RTC with any microcontroller of you choice.

The most common RTC that is available on the market is the DS1307 and its has been around for quiteA some time and hence there is an abundance ofA documentationA online for its interface. The device can be interface using the I2C protocol also called as the two wire interface. This simple protocol that allows data to be read and written serially using just two line (SCL - clock and SDA - data).

I assume that readers are aware of the I2C protocolA specificationsA if not please read my previous postA <a title="Two Wire Interface (I2C Protocol) in a nut shell" href="http://embedjournal.com/?p=79" target="_blank">here.</a>A The process ofA Interfacing RTC may turn out to be a little daunting if you don't fullyA understandingA the I2C busA specification.A The datasheet of the DS1307 real time clock is quiet self explanatory and little has to be explained if you have a basic idea about the interface. There are a few time keeping registers in the IC that can be read and written. Once the actual time is set the clock will keep a track of the time. For this a dedicated power supply (CMOS battery) which kicks in if the power to the system is turned OFF.

**The Time Keepers:**

This is the list of the registers that you will have to configure and set for the RTC to work. This is a snapshot from the datasheet for yourA convenience. There are six registers for time keeping purpose and one register at 07h which is for configuring a square wave output derived from the clock. ForA simplicity we will leave that register for now, but this feature can be very useful I can think of a handful of application for it. Maybe you should too. For now we will stick to just the time dYtm,

<p style="text-align: center;">
  <a href="/images/posts/2013/05/untitled52.png"><img class="aligncenter size-full wp-image-83" alt="RTC internal Time keeping registers " src="/images/posts/2013/05/untitled52.png" width="900" height="326" srcset="/images/posts/2013/05/untitled52.png 900w, /images/posts/2013/05/untitled52-300x109.png 300w" sizes="(max-width: 900px) 100vw, 900px" /></a>
</p>

TheA column function tells you what function each register is going. Most of the details such a second minutes hours months and years are given in 4-bitA <a title="Binary-coded decimal" href="http://en.wikipedia.org/wiki/Binary-coded_decimal" target="_blank" rel="wikipedia">BCD</a>A format. If the detail is less than 9 for example the tens place of the minutes and seconds can never go beyond 5. So instead of using a 4-bit format they have adopted a 3-bit format of BCD that can go up to 7. Similarly the tens place of the months is never going to go beyond 1 so it just a single bit saying 0 or 1. The registers bits that are marked 0 will always be read 0.

Next comes the representation of the time, either in 12-hour format or 10-hour format. This is done by the bit 6 of the hours register. If set the clock is in 12-hours mode and if cleared it is in 24-hour mode. In 24-hour mode the bit 5 will be used along with the bit 4 to read the tens digit hours (as it can go up to 2). In the 12-hours mode the bit 5 is used as a AM or PM indicator. If the bit is set then the time is in PM and if it is cleared it is in AM mode. And as shown in the table only bit 4 is used to display the tens digit of the hours.

Lastly there is a bit named CH (Clock Halt) in the seconds register. This bit when set will halt the time keeping process. Some applications may not require the time keeping operation to be going on forever. For example a system that is connected to a network operator (<a title="GSM" href="http://en.wikipedia.org/wiki/GSM" target="_blank" rel="wikipedia">GSM</a>) or a device connected to the internet can get itsA <a title="Timestamp" href="http://en.wikipedia.org/wiki/Timestamp" target="_blank" rel="wikipedia">time stamp</a>A from a NTP server. So the programmer has the ability to shut down the time keeping process when not needed thereby reducing the operational current.
  
**Programming:**

This function gets the time from the RTC, It takes the register address to read from as a parameter and return the content of that register one at a time. This follows the procedure to read and write data in I2C bus as explained in my post <a title="Two Wire Interface (I2C Protocol) in a nut shell" href="http://embedjournal.com/?p=79" target="_blank">Two Wire Interface (i2c-protocol) in a nut shell.</a>

<pre>unsigned int get_time(unsigned int address)
{
   unsigned int data;
   i2c_start();
   i2c_write(SLAVE_DS1307|WRITE);
   i2c_write(address);
   i2c_restart();
   i2c_write(SLAVE_DS1307|READ);
   SSPCON2bits.ACKDT=1;
   data=i2c_read();
   i2c_stop();
   return (data);
}</pre>

This function set the time in the RTC's time keeping register, It take the register address to read from and the data to be written as parameters. This follows the procedure to write data to I2C bus as explained in my postA <a title="Two Wire Interface (I2C Protocol) in a nut shell" href="http://embedjournal.com/?p=79" target="_blank">Two Wire Interface (i2c-protocol) in a nut shell.</a><a title="I2C interface" href="http://embedthink.wordpress.com/2013/05/13/two-wire-interface-i2c-protocol-in-a-nut-shell/" target="_blank"><br /> </a>

<pre>void set_time(unsigned int address, unsigned int value)
{
    i2c_start();
    i2c_write(SLAVE_DS1307|WRITE);
    i2c_write(address);
    i2c_write(value);
    i2c_stop();
    return;
}</pre>

To reset the time use this function. You will have to calibrate the value for each register manually before suing this function. This may not be the mostA optimized means to set the time again this is the most straight forward method. This is all BCD so there is not much calculation involved if you want the hours to be 12 then just pass 0x12 to that corresponding register.

<pre>void reset_time()
{    
    i2c_start();
    i2c_write(SLAVE_DS1307|WRITE);
    i2c_write(0x00);    // Address of the first register
    i2c_write(0x00);    // Seconds register
    i2c_write(0x00);    // Minutes register
    i2c_write(0x01);    // Hours register
    i2c_write(0x01);    // Days register
    i2c_write(0x01);    // Date register
    i2c_write(0x01);    // Month register
    i2c_write(0x00);    // Year register
    i2c_stop();
    return;
}</pre>

This is more like a code that can be used in any controller as I have not done any MCU specific stuffs up till now. All the MCU specific stuffs are done in the subroutine calls. I stronglyA recommendA you to write your own I2C library from scratch I will post mine just for aA reference. I have tested this code and its working properly with MPLAB X and C18 compiler.

<pre>#include "p18f4520.h"
void i2c_start(void)    // Initiate a Start sequence
{
  TRISCbits.TRISC3=1;
  TRISCbits.TRISC4=1;
  PIR1bits.SSPIF=0;
  SSPCON2bits.SEN=1;
  while(PIR1bits.SSPIF==0);
  return;
}
void i2c_restart(void)  // Initiate a Repeated start sequence
{
  PIR1bits.SSPIF=0;
  SSPCON2bits.RSEN=1;
  while(PIR1bits.SSPIF==0);
  return;
}
void i2c_write(unsigned int data)      // Write data to slave.
{
  PIR1bits.SSPIF=0;
  SSPBUF=data;
  while(PIR1bits.SSPIF==0);
  return;
}
void i2c_stop(void)     //Initiate a Stop sequence.
{
  PIR1bits.SSPIF=0;
  SSPCON2bits.PEN=1;
  while(PIR1bits.SSPIF==0);
  TRISCbits.TRISC3=0;
  TRISCbits.TRISC4=0;
  return;
}</pre>

I think this should be enough to get you started. Again this is not the entire code but just snippets. You will have toA initializeA the I2C module before calling any of these functions. You might have to write a LCD library to handle the characters and think of a logic to find out if it is AM or PM and display it in the LCD if you are using the 12-hour mode. A I have no intention on spoiling all the fun in learning by yourself by posting the entire project. All the best programming dYtm, and let me know of your success.

**Where to go from here?**

  * Well you can think of adding a few tactile switches and upgrade your code to set the time without having to change the code like all those commercial digital clocks available in the market.
  * You can change theA characterA LCD to aA GraphicA LCD and make a moreA artistic looking clock dYtm,
  * You can add feature to alarm set, you might have to add a buzzer circuit.
  * Feature a Snooze and stop button.
  * Support multiple alarms andA repeatedA alarms as your phone does.

Don't miss the exciting new posts that are yet to come.A <a href="http://embedjournal.com/subscribe/" target="_blank">Subscribe to embedjournal.com</a>A and get our latest post delivered to your inbox.