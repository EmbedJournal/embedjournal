---
title: "Character LCD Command Sheet HTML Version"
date: 2013-06-20T10:43:18+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /character-lcd-command-sheet/
dsq_thread_id: "3295036483"
category: "Embedded"
tags: [ "LCD" ]
---

I was looking for an image of the Character LCD command sheet throughout the internet and failed to find any good resolution images that I can use for post references. Here is an HTML Version that could be used at whichever resolution you choose!

<table style="width: 100%;" border="1" cellspacing="0" cellpadding="5" align="center">
  <tr align="center" valign="middle">
    <td colspan="13">
      <h2>
        <span style="font-family: tahoma, arial, helvetica, sans-serif;">Character LCD Command Sheet</span>
      </h2>
    </td>
  </tr>

  <tr align="center" valign="middle">
    <td rowspan="2">
      <h5>
        Instruction
      </h5>
    </td>

    <td colspan="10">
      <h5>
        Code
      </h5>
    </td>

    <td rowspan="2">
      <h5>
        Description
      </h5>
    </td>

    <td rowspan="2">
      <h5>
        Execution
      </h5>

      <h5>
        time
      </h5>
    </td>
  </tr>

  <tr align="center" valign="middle">
    <td>
      <h5>
        RS
      </h5>
    </td>

    <td>
      <h5>
        RW
      </h5>
    </td>

    <td>
      <h5>
        D7
      </h5>
    </td>

    <td>
      <h5>
        D6
      </h5>
    </td>

    <td>
      <h5>
        D5
      </h5>
    </td>

    <td>
      <h5>
        D4
      </h5>
    </td>

    <td>
      <h5>
        D3
      </h5>
    </td>

    <td>
      <h5>
        D2
      </h5>
    </td>

    <td>
      <h5>
        D1
      </h5>
    </td>

    <td>
      <h5>
        D0
      </h5>
    </td>
  </tr>

  <tr>
    <td>
      Clear display
    </td>

    <td>
       0
    </td>

    <td>
    </td>

    <td>
       0
    </td>

    <td>
       0
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
      1
    </td>

    <td>
       Clears display and returns cursor to the home position (address 0).
    </td>

    <td>
       1.52 ms
    </td>
  </tr>

  <tr>
    <td>
      Cursor home
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
       0
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
       0
    </td>

    <td>
       0
    </td>

    <td>
       1
    </td>

    <td>
       *
    </td>

    <td>
       Returns cursor to home position. Also returns display being shifted to the original position. DDRAM content remains unchanged.
    </td>

    <td>
       1.52 ms
    </td>
  </tr>

  <tr>
    <td>
      Entry mode set
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
      I/D
    </td>

    <td>
       S
    </td>

    <td>
       Sets cursor move direction (I/D); specifies to shift the display (S). These operations are performed during data read/write.
    </td>

    <td>
       37 I1/4s
    </td>
  </tr>

  <tr>
    <td>
      Display on/off control
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
      1
    </td>

    <td>
       C
    </td>

    <td>
       B
    </td>

    <td>
       Sets on/off of all display (D), cursor on/off (C), and blink of cursor position character (B).
    </td>

    <td>
       37 I1/4s
    </td>
  </tr>

  <tr>
    <td>
      Cursor/display shift
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
      1
    </td>

    <td>
      1
    </td>

    <td>
      R/L
    </td>

    <td>
      *
    </td>

    <td>
       *
    </td>

    <td>
       Sets cursor-move or display-shift (S/C), shift direction (R/L). DDRAM content remains unchanged.
    </td>

    <td>
       37 I1/4s
    </td>
  </tr>

  <tr>
    <td>
      Function set
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
      A 0
    </td>

    <td>
      1
    </td>

    <td>
      DL
    </td>

    <td>
      s/c
    </td>

    <td>
      A F
    </td>

    <td>
      A *
    </td>

    <td>
      A *
    </td>

    <td>
      A Sets interface data length (DL), number of display line (N), and character font (F)
    </td>

    <td>
      A 37 I1/4s
    </td>
  </tr>

  <tr>
    <td>
      Set CGRAMA address
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
      A 0
    </td>

    <td>
      A 1
    </td>

    <td colspan="6">
      A A A A A A CGRAM address
    </td>

    <td>
      A Sets the CGRAM address. CGRAM data are sent and received after this setting.
    </td>

    <td>
      A 37 I1/4s
    </td>
  </tr>

  <tr>
    <td>
      Set DDRAMA address
    </td>

    <td>
    </td>

    <td>
    </td>

    <td>
      A 1
    </td>

    <td colspan="7">
      A A A A A A A DDRAM address
    </td>

    <td>
      A Sets the DDRAM address. DDRAM data are sent and received after this setting.
    </td>

    <td>
      A 37 I1/4s
    </td>
  </tr>

  <tr>
    <td>
      Read busy flagA & add resscounter
    </td>

    <td>
    </td>

    <td>
      1
    </td>

    <td>
      BF
    </td>

    <td colspan="7">
      A A A A A A A CGRAM/DDRAM address
    </td>

    <td>
      A Reads busy flag (BF) indicating internal operation being performed and reads CGRAM or DDRAM address counter contents (depending on previous instruction).
    </td>

    <td>
      A 0 I1/4s
    </td>
  </tr>

  <tr>
    <td>
      Write CGRAM orA DDRAM
    </td>

    <td>
      1
    </td>

    <td>
    </td>

    <td colspan="8">
      A A A A A A A A Write Data
    </td>

    <td>
      A Write data to CGRAM or DDRAM.
    </td>

    <td>
      37 I1/4s
    </td>
  </tr>

  <tr>
    <td>
      Read from CGRAM orDDRAM
    </td>

    <td>
      1
    </td>

    <td>
      A 1
    </td>

    <td colspan="8">
      A A A A A A A A Read Data
    </td>

    <td>
      A Read data from CGRAM or DDRAM.
    </td>

    <td>
      A 37 I1/4s
    </td>
  </tr>

  <tr>
    <td colspan="13">
      <b>Instruction bit names:</b></p>

      <ul>
        <li>
          <b style="line-height: 19px;">I/D</b><span style="line-height: 19px;">A - 0 = decrement cursor position, 1 = increment cursor position;</span>
        </li>
        <li>
          <b style="line-height: 19px;">S</b><span style="line-height: 19px;">A - 0 = no display shift, 1 = display shift;</span>
        </li>
        <li>
          <b style="line-height: 19px;">D</b><span style="line-height: 19px;">A - 0 = display off, 1 = display on;</span>
        </li>
        <li>
          <b style="line-height: 19px;">C</b><span style="line-height: 19px;">A - 0 = cursor off, 1 = cursor on;</span>
        </li>
        <li>
          <b style="line-height: 19px;">B</b><span style="line-height: 19px;">A - 0 = cursor blink off, 1 = cursor blink onA ;</span>
        </li>
        <li>
          <b style="line-height: 19px;">S/C</b><span style="line-height: 19px;">A - 0 = move cursor, 1 = shift display;</span>
        </li>
        <li>
          <b style="line-height: 19px;">R/L</b><span style="line-height: 19px;">A - 0 = shift left, 1 = shift right;</span>
        </li>
        <li>
          <b style="line-height: 19px;">DL</b><span style="line-height: 19px;">A - 0 = 4-bit interface, 1 = 8-bit interface;</span>
        </li>
        <li>
          <b style="line-height: 19px;">N</b><span style="line-height: 19px;">A - 0 = 1/8 or 1/11 duty (1 line), 1 = 1/16 duty (2 lines);</span>
        </li>
        <li>
          <b style="line-height: 19px;">F</b><span style="line-height: 19px;">A - 0 = 5A--8 dots, 1 = 5A--10 dots;</span>
        </li>
        <li>
          <b style="line-height: 19px;">BF</b><span style="line-height: 19px;">A - 0 = can accept instruction, 1 = internal operation in progress.</span>
        </li>
      </ul>
    </td>
  </tr>
</table>
