---
title: "Interface - LCD in 4 bit Mode: Part 3"
date: 2013-07-04T11:02:08+00:00
author: Siddharth
layout: post
thumbnail: post-thumb.jpg
permalink: /interface-lcd-in-4-bit-mode/
dsq_thread_id: "2728571307"
categories: [ "Embedded Theory", "Microchip PIC" ]
tags: [ "Interface", "LCD" ]
---

Embedded applications are always developed on controllers whose resources are almost fully used in order to cut the cost of the product. This is done especially in applications that do not need any future expansions or a firmware updates. They are _Make-it_ and _Forget-it_ kind of applications. Most of the time, either the memory or the available pins are in demand. In some cases both memory and pin count are less.

[<img class="aligncenter size-large wp-image-1060" alt="DSC09440" src="/images/posts/2013/07/DSC09440-1024x576.jpg" width="618" height="347" srcset="/images/posts/2013/07/DSC09440-1024x576.jpg 1024w, /images/posts/2013/07/DSC09440-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/07/DSC09440.jpg)

The Character <a title="Programming LCD in 8 bit mode aEUR" Part -2" href="http://embedjournal.com/2013/06/programming-lcd-in-8-bit-mode/" target="_blank">LCD in 8 bit mode</a> uses 8 data lines and 3 control lines to display characters. A This kink of interface is costly in terms of pin usage. Most of the industrial applications use the LCD in 4 bit mode. The total data lines needed is reduced by half in this mode. I have already discussed this in on of my previous posts on the <a title="Interfacing LCD Module with Microcontroller: Part -1" href="http://embedjournal.com/2013/06/interfacing-lcd-module-part-1/" target="_blank">Theory behind the LCD modules</a>. It is further possible to reduce the Port Pins required by asserting the R/W pin permanently LOW throughout the interface. By doing this we mean that the LCD will always be operated in Write mode and Read mode will not be use.A This way another pin can be saved.

The interface of LCD in 4 bit mode without checking for busy flag can be little tricky and we have to give enough delays calls between data latch and next data write to insure that the LCD is never busy while a new data is written to it. This post will deal the programming of LCD in 4 bit mode with the R/W line of the LCD pulled low. Hence this interface will just use 6 pins of the interface.

#### Basic understanding:

The 8 bit data is split up into two chucks of 4 bits each. The higher nibble is sent first and then the lower nibble is sent to make one complete data transfer. Since each byte is transferred in two steps the speed of this method will theoretically be doubled. Also, we are not using the busy flag to monitor the state of the LCD so this introduced a further reduction the speed of the execution. We have use the <a title="Character LCD Command Sheet HTML Version" href="http://embedjournal.com/2013/06/character-lcd-command-sheet/" target="_blank">command sheet</a> to get commands that will make the LCD understand that we will be sending data in nibble format.

#### Connection:

The connection is really simple and it is quit self explanatory. Here are some images to help understand the wiring better. There are a total of six pins (4 for data and 2 for command) that are connected to the PIC 18F4520 Microcontroller sitting over the ZIF (Zero Insertion Force) socket.

[<img class="aligncenter size-large wp-image-1062" alt="DSC09449" src="/images/posts/2013/07/DSC09449-1024x576.jpg" width="618" height="347" srcset="/images/posts/2013/07/DSC09449-1024x576.jpg 1024w, /images/posts/2013/07/DSC09449-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/07/DSC09449.jpg)

I'm using a development board that provides a breakout board for LCD displays. The Gnd, Vcc, Contrast, BL+, and BL- pins are internally connected to the power supply and potentiometer. So you will notice that I am not connecting anything to those pins.

[<img class="aligncenter size-large wp-image-1063" alt="DSC09450" src="/images/posts/2013/07/DSC09450-1024x576.jpg" width="618" height="347" srcset="/images/posts/2013/07/DSC09450-1024x576.jpg 1024w, /images/posts/2013/07/DSC09450-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/07/DSC09450.jpg)

In the above image you can see 7 wires that are connected to the Male Header pins. The R/W pin has to be grounded externally as it is not internally grounded. The white connector behind it is the 16 wire RMC connector that I am using as an extension cable form the LCD module.

[<img class="aligncenter size-large wp-image-1061" alt="LCD in 4 bit mode -  setup" src="/images/posts/2013/07/DSC09447-1024x576.jpg" width="618" height="347" srcset="/images/posts/2013/07/DSC09447-1024x576.jpg 1024w, /images/posts/2013/07/DSC09447-300x169.jpg 300w" sizes="(max-width: 618px) 100vw, 618px" />](/images/posts/2013/07/DSC09447.jpg)

Here is the entire setup. It shows how the R/W pin is held low throughout the interface. While designing PCB's we can connect this permanently to ground or provide a jumper just in case we need to check the busy flag.

#### Programming:

Here also we will be using the same functions. Only the lcd.c and lcd.h file have to be modified, the main.c has also been changed but the logic is the same. Also most of the function and how they behave has been discussed in my previous post, <a title="Programming LCD in 8 bit mode aEUR" Part -2" href="http://embedjournal.com/2013/06/programming-lcd-in-8-bit-mode/" target="_blank">programming LCD in 8 bit mode</a>.A So I will not rehash them here and make this post lengthy.

<pre>/* 
 * File Name: basic_4bit_interface
 * Author: Siddharth Chandrasekaran
 * Created On: 3rd July 2013
 * LCD Library For C18 compiler and PIC advanced 8 bit CPUs
 * Visit http://embedjournal.com for more codes.
*/
#include"p18f4520.h"
#include"delays.h"
#include"lcd.h"

void LCD_init(void){
    EN=LOW;
    RS=LOW;
    LCD_port=0x00;
    LCD_reset();
    LCD_cmd(CLRSCR);
    Delay10KTCYx(50);
    LCD_cmd(MODE_4BIT);         
    Delay10KTCYx(50);
    LCD_cmd(DISPLAY_ON | CURSOR_OFF);         
    Delay10KTCYx(50);
    LCD_cmd(CURSOR_INC);        
    Delay10KTCYx(50);
    LCD_cmd(LCD_LINE1);
    Delay10KTCYx(50);

}

void LCD_reset(void)
{
    Delay10KTCYx(2);
    LCD_port=0x03;
    EN=HIGH;
    Delay10KTCYx(50);
    EN=LOW;

    Delay10KTCYx(1);  
    LCD_port=0x03;
    EN=HIGH;
    Delay10KTCYx(50);
    EN=LOW;

    Delay1KTCYx(1); 
    LCD_port=0x03;
    EN=HIGH;
    Delay10KTCYx(50);
    EN=LOW;

    Delay1KTCYx(1); 
    LCD_port=0x02;
    EN=HIGH;
    Delay10KTCYx(50);
    EN=LOW;
    Delay1KTCYx(1);
}

void LCD_data(unsigned char data)
{
    unsigned char temp;
    temp=data;
    RS=HIGH;
    //sends the upper four bits
    temp=temp>>4;
    LCD_port=temp;
    EN=HIGH;
    Delay10KTCYx(50);
    EN=LOW;

    //sends the lower 4 bits
    temp=data;
    LCD_port=temp;
    EN=HIGH;
    Delay10KTCYx(50);
    EN=LOW;
}

void LCD_cmd(unsigned char cmd)
{
    unsigned char temp;
    TRISD = 0x00;
    RS = LOW;
    LCD_port_dir = 0x00;
    temp=cmd;

    //sends the upper four bits
    temp=temp>>4;
    LCD_port=temp;
    EN=HIGH;
    Delay10KTCYx(50);
    EN=LOW;

    //sends the lower 4 bits
    temp=cmd;
    LCD_port=temp;
    EN=HIGH;
    Delay10KTCYx(50);
    EN=LOW;
}

void LCD_string(const rom char *buffer)
{
    while(*buffer)              // Write data to LCD up to null
    {
        Delay10KTCYx(50);
        LCD_data(*buffer);      // Write character to LCD
        buffer++;               // Increment buffer
    }
}

void LCD_blink(void)
{
    LCD_cmd(DISPLAY_OFF);
    Delay10KTCYx(255);
    Delay10KTCYx(255);
    LCD_cmd(DISPLAY_ON);
    Delay10KTCYx(255);
    Delay10KTCYx(255);
    LCD_cmd(DISPLAY_OFF);
    Delay10KTCYx(255);
    Delay10KTCYx(255);
    LCD_cmd(DISPLAY_ON);
    Delay10KTCYx(255);
    Delay10KTCYx(255);
}</pre>

#### Header File:

<pre>/* 
 * File Name: basic_4bit_interface
 * Author: Siddharth Chandrasekaran
 * Created On: 3rd July 2013
 * LCD Library For C18 compiler and PIC advanced 8 bit CPUs
 * Visit http://embedjournal.com for more codes.
*/
#ifndef LCD_H
#define	LCD_H

#define HIGH 1
#define LOW 0

#define EN LATDbits.LATD1
#define RS LATDbits.LATD0
#define LCD_port_dir TRISB
#define LCD_port LATB

#define CLRSCR 0x01
#define DISPLAY_ON 0x0C
#define DISPLAY_OFF 0x08
#define CURSOR_ON 0x0A
#define CURSOR_OFF 0x08
#define CURSOR_INC 0x06
#define MODE_8BIT 0x38
#define MODE_4BIT 0x28

/************** Line Addr Mapping ******************/
#define LCD_LINE1 0x80
#define LCD_LINE2 0xC0
#define LCD_LINE3 0x94
#define LCD_LINE4 0xD4

void LCD_init(void);
void LCD_reset(void);
void LCD_cmd(unsigned char);
void LCD_data(unsigned char);
void LCD_blink(void);
void LCD_string(const rom char *buffer);

#endif	/* LCD_H */</pre>

<div class="box warning  ">
  <div class="box-inner-block">
    <i class="fa tie-shortcode-boxicon"></i> The delay function call will vary from one oscillator frequency to another. This code was tested for 20MHz oscillator. Make necessary changes so as to suit your system clock frequency or else this code may not work.
  </div>
</div>

In the next post we will see how to display custom characters using the CG RAN (Character Generator RAM). <a href="http://embedjournal.com/subscribe/" target="_blank">Subscribe to our newsletters</a> with your email and get updates on latest posts in your inbox.