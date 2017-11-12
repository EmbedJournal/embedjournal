---
title: "Interface LCD in 8 bit mode"
date: 2013-06-26T19:58:25+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /programming-lcd-in-8-bit-mode/
dsq_thread_id: "2728571557"
category: "Microchip PIC"
tags: [ "Interface", "LCD" ]
---

This post documents the steps involved in interfacing the LCD in 8 bit mode with a microcontroller. It belongs to a series of 4 posts. If you landed here straight from a search engine, here is an index to help you navigate.

  1. [LCD Module Basic Theory](/interfacing-lcd-module-basics/) (LCD Controllers, CG&DD RAM, PIN description,Timing Diagram, Commands)
  2. [Programming LCDs in 8 bit mode](/programming-lcd-in-8-bit-mode/) (programming pic18f4520 in C with C18 compiler under 8 bit mode)
  3. [Programming LCDs in 4 bit mode](/interface-lcd-in-4-bit-mode/) (programming pic18f4520 in C with C18 compiler under 4 bit mode)
  4. Creating Custom Characters (bit map symbols and arrows that are not usually present in the ASCII table)

### Why Reinvent the wheel?

There are a lot of libraries that are freely available in the Internet and in some cases, the MCU vendors provide libraries for these LCD modules. This may led you to believe that I am re-inventing the wheel. But as always I have my reasons.

Using existing libraries for fonts, FAT and other complex and time consuming applications is understandable but for an application as simple as the character LCD, I would rather write my own library than spending time reading and understanding some one else's code.

Taking and using someone else's code means I have to put up with the names that they choose to call their functions with or stick to their naming convention (that can be solved by writing wrapper functions or refactoring but that's clumsy).

We will first list a set of functions that we will be using to interface the LCD module and then wrap it up into a nice header file that can be included in your program's main file. It is good practice to use separate C files for each module that you interface so that combining two such module would be easy in the long run.

### What do we need?

Most of the time we do not appreciate what is around us like the `printf` in C. It makes life so simple by taking care of printing data to the screen. Hence, for working comfortably with LCD we will have to have functions to take care of the following tasks,

  * Write one character at a time.
  * Give commands to the module.
  * Read busy the busy flag.
  * Write a string sequentially.

The 8 bit mode of operation of the LCD is relatively faster and simpler than the 4 bit mode. Here as the name suggests, 8 parallel data lines are needed to write data and commands to the LCD module. The source code is written in embedded C and compiled using the C18 compiler from microchip. The code below is successfully compiled without any warnings or errors using the Mplab X IDE and Mplab 8.85

### Code Macros:

Before writing the code we have to decide on the pins that we are going to use for use for the interface. Once this is done, we have to put them to use by setting code macros with `#define`. In C the macros are just shortcuts. If you write `#define HIGH 1` Where ever the compiler encounters an instance of HIGH it will consider it as 1. This can be really helpful in providing more readability and portability for you code which you will see by the end of this post.

``` c
/****************** PIN Mapping *******************/
#define RS PORTDbits.RD0
#define RW PORTDbits.RD1
#define EN PORTDbits.RD2
#define BF PORTBbits.RB7
#define DATAPORT LATB
/************** Line Addr Mapping ******************/
#define LCD_LINE1 0x80
#define LCD_LINE2 0xC0
#define LCD_LINE3 0x94
#define LCD_LINE4 0xD4
/************ LCD Command Mapping *****************/
#define CLRSCR 0x01
#define DISPLAY_ON 0x0C
#define DISPLAY_OFF 0x08
#define CURSOR_ON 0x0A
#define CURSOR_OFF 0x08
#define CURSOR_INC 0x06
#define MODE_8BIT 0x38
#define MODE_4BIT 0x28
```

Use as many macros as you want for all the constants and IO pins. Once all the constant mapped on to a label using the macros, you can start using them in you code.

### Write data to LCD

**Function Name:** LCD_data

**Parameters:** 8 bit data

**Return:** None

**Description:** This function is used to write a 8 bit parallel data into the DD RAM of the LCD at the memory location last pointed to my the AC. Before writing any data the line address or the position address has to be given using the LCD_cmd() function.

``` c
void LCD_data(unsigned char data){
    LCD_isbusy();
    RS = HIGH;
    RW = LOW;
    EN = HIGH;
    DATAPORT = data;
    Delay1KTCYx(50);
    EN = LOW;
}
```

### Send a command

**Function Name:** LCD_cmd

**Parameters:** 8 bit command

**Return:** None

**Description:** This function is used to send data to the command register. It can be an internal LCD command or a DD RAM address but commands should be framed properly form the command sheet.

``` c
void LCD_cmd(unsigned char cmd){
    LCD_isbusy();
    RS = LOW;
    RW = LOW;
    EN = HIGH;
    DATAPORT = cmd;
    Delay1KTCYx(50);
    EN = LOW;
}
```

### Read busy flag

**Function Name:** LCD_isbusy

**Parameters:** None

**Return:** None

**Description:** This function is used to check for the busy flag (DB7). The LCD cannot do any operations as long as it is busy. So this function never terminates as long as the LCD is busy (it gets stuck in an infinite loop).

``` c
void LCD_isbusy(void)
{
    TRISBbits.TRISB7=1;         // Make D7 as input
    RS = LOW;
    RW = HIGH;
    EN = HIGH;
    Delay1KTCYx(50);
    while(BF);
    TRISBbits.TRISB7=0;         // Back to Output
    EN = LOW;
}
```

### Write a string to LCD

**Function Name:** LCD_string

**Parameters:** Character pointer.

**Return:** None

**Description:** This function take the address of the first character of the string that you wish to write to the LCD as a parameter and then sequentially calls the LCD\_data() function each time with the next successive character of the string. So this is nothing but an automated version of the sequential call to the LCD\_data() function. It takes away a lot of headache when trying to print length messages.

``` c
void LCD_string(const rom char *buffer)
{
    while(*buffer)              // Write data to LCD up to null
    {
        LCD_isbusy();           // Wait while LCD is busy
        LCD_data(*buffer);      // Write character to LCD
        buffer++;               // Increment buffer
    }
}
```

### Source File lcd.c

Now all that is remaining is to collect all the functions above and put then in a single C source file and include necessary header files and we are good to go. This is how your final C source file should look like. Use the small icon below the source code to copy the code with proper formatting.

``` c
/*
 * File Name: lcd.c
 * Author: Siddharth Chandrasekaran
 * Created On: 25th June 2013
 * LCD Library For C18 compiler and PIC advanced 8 bit CPUs
 * Visit http://embedjournal.com for more codes.
*/
#include"p18f4520.h"
#include"Delays.h"
#include"lcd.h"              // we haven't yet discussed this.

void LCD_init(void){
    TRISD=0x00;
    TRISB=0x00;
    LCD_cmd(MODE_8BIT);                   // 2 Line, 5x7 display, 8 bit
    LCD_cmd(CLRSCR);                      // clear the screen
    LCD_cmd(CURSOR_INC);                  // Cursor Incremetns on each write
    LCD_cmd(DISPLAY_ON | CURSOR_OFF);     // Display on and Cursor Off
    return;
}

void LCD_data(unsigned char data){
    LCD_isbusy();
    RS = HIGH;
    RW = LOW;
    EN = HIGH;
    DATAPORT = data;
    Delay1KTCYx(50);
    EN = LOW;
}

void LCD_cmd(unsigned char cmd){
    LCD_isbusy();
    RS = LOW;
    RW = LOW;
    EN = HIGH;
    DATAPORT = cmd;
    Delay1KTCYx(50);
    EN = LOW;
}

void LCD_string(const rom char *buffer)
{
    while(*buffer)              // Write data to LCD up to null
    {
        LCD_isbusy();           // Wait while LCD is busy
        LCD_data(*buffer);      // Write character to LCD
        buffer++;               // Increment buffer
    }
}
void LCD_isbusy(void)
{
    TRISBbits.TRISB7=1;         // Make D7 as input
    RS = LOW;
    RW = HIGH;
    EN = HIGH;
    Delay1KTCYx(50);
    while(BF);
    TRISBbits.TRISB7=0;         // Back to Output
    EN = LOW;
}
```

### Header File lcd.h

With the source file lcd.c ready you will need a means to allow you main C file (one which has the main() function) to access the function in the source file. For doing this you can either extern all the junction in the source file or have a .h file to bridge them together. The first method is a little messy so lets do the latter one. Create a file called lcd.h and add the following code,

``` c
/*
 * File Name: lcd.h
 * Author: Siddharth Chandrasekaran
 * Created On: 25th June 2013
 * LCD Library For C18 compiler and PIC advanced 8 bit CPUs
 * Visit http://embedjournal.com for more codes.
*/
#ifndef LCD_H
#define LCD_H

#define HIGH 1
#define LOW 0

/****************** PIN Mapping *******************/
#define RS PORTDbits.RD0
#define RW PORTDbits.RD1
#define EN PORTDbits.RD2
#define BF PORTBbits.RB7
#define DATAPORT LATB
/************** Line Addr Mapping ******************/
#define LCD_LINE1 0x80
#define LCD_LINE2 0xC0
#define LCD_LINE3 0x94
#define LCD_LINE4 0xD4

#define CLRSCR 0x01
#define DISPLAY_ON 0x0C
#define DISPLAY_OFF 0x08
#define CURSOR_ON 0x0A
#define CURSOR_OFF 0x08
#define CURSOR_INC 0x06
#define MODE_8BIT 0x38
#define MODE_4BIT 0x28

void LCD_init(void);
void LCD_data(unsigned char data);
void LCD_cmd(unsigned char cmd);
void LCD_string(const rom char *ptr);
void LCD_isbusy(void);
#endif
```


### Using these functions in you code:

Now that you have the source and header files ready, you can incorporate the functions in you code as shown in this code. This is the program that I wrote for making the video above. It does not demonstrate the use if all the functions but I think with this code you can start the experimenting for yourself.

``` c
/*
 * File Name: basic_lcd_interface.c
 * Author: Siddharth Chandrasekaran
 * Created On: 25th June 2013
 * LCD Library For C18 compiler and PIC advanced 8 bit CPUs
 * Visit http://embedjournal.com for more codes.
*/
#include"p18f4520.h"
#include"delays.h"
#include"lcd.h"

#pragma config WDT=OFF,OSC=HS, LVP=OFF, IESO=OFF, FCMEN=ON, XINST=OFF

void message1(void);
void message2(void);
void message3(void);
void LCD_blink(void);

void main()
{
    ADCON1 = 0x0f;
    LCD_init();
    while(1)
    {
        message1();
        Delay10KTCYx(255);
        Delay10KTCYx(255);    // give a delay close to 1 sec.
        LCD_blink();
        LCD_cmd(CLRSCR);
        message2();
        Delay10KTCYx(255);
        Delay10KTCYx(255);    // give a delay close to 1 sec.
        LCD_blink();
        LCD_cmd(CLRSCR);
        message3();
        Delay10KTCYx(255);
        Delay10KTCYx(255);     // give a delay close to 1 sec.
        LCD_blink();
        LCD_cmd(CLRSCR);
    }
}

void message1(void)
{
    LCD_cmd(LCD_LINE1);
    LCD_string("     Welcome to     ");
    LCD_cmd(LCD_LINE2);
    LCD_string("www.embedjournal.com");
    LCD_cmd(LCD_LINE3);
    LCD_string("Basic LCD Interface!");
    LCD_cmd(LCD_LINE4);
    LCD_string("   21st June, 2013  ");
    Delay10KTCYx(255);
    Delay10KTCYx(255);
    Delay10KTCYx(255);       // give a delay close to 2 sec.
    Delay10KTCYx(255);
}

void message2(void)
{
    LCD_cmd(LCD_LINE1);
    LCD_string("Like EmbedJournal on");
    LCD_cmd(LCD_LINE2);
    LCD_string("      Facebook      ");
    LCD_cmd(LCD_LINE3);
    LCD_string("And Subscribe to Our");
    LCD_cmd(LCD_LINE4);
    LCD_string("     Newsletters    ");
    Delay10KTCYx(255);
    Delay10KTCYx(255);
    Delay10KTCYx(255);      // give a delay close to 2 sec.
    Delay10KTCYx(255);
}

void message3(void)
{
    LCD_cmd(LCD_LINE1);
    LCD_string("    More to Come    ");
    LCD_cmd(LCD_LINE2);
    LCD_string("     Stay Tuned     ");
    LCD_cmd(LCD_LINE3);
    LCD_string("         by         ");
    LCD_cmd(LCD_LINE4);
    LCD_string("      Siddharth     ");
    Delay10KTCYx(255);
    Delay10KTCYx(255);
    Delay10KTCYx(255);       // give a delay close to 2 sec.
    Delay10KTCYx(255);
}

void LCD_blink(void)
{
    LCD_cmd(DISPLAY_OFF);
    Delay10KTCYx(255);
    Delay10KTCYx(255);       // give a delay close to 1 sec.
    LCD_cmd(DISPLAY_ON);
    Delay10KTCYx(255);
    Delay10KTCYx(255);       // give a delay close to 1 sec.
    LCD_cmd(DISPLAY_OFF);
    Delay10KTCYx(255);
    Delay10KTCYx(255);       // give a delay close to 1 sec.
    LCD_cmd(DISPLAY_ON);
    Delay10KTCYx(255);
    Delay10KTCYx(255);       // give a delay close to 1 sec.
}
```

**Related Downloads:**

Here is the Mplab X project folder in which the above program has been successfully compiled to get the HEX file for the above description [sociallocker]

  * <a href="http://ww1.microchip.com/downloads/en/devicedoc/39631a.pdf" target="_blank">PIC 18F4520 Datasheet</a>
  * <a href="https://www.dropbox.com/s/lm58tyf7iqa7kll/lcd_basic_io.X.production.hex" target="_blank"><span style="line-height: 13px;">Pre-built HEX file</span></a>
  * <a title="Dropbox link" href="https://www.dropbox.com/s/qgkb6d1x1xtv0pc/lcd_basic_io.X.rar" target="_blank">MPLAB X project files</a> [/sociallocker]

My next post will discuss the [programming LCD in 4 bit mode](/interface-lcd-in-4-bit-mode/).
