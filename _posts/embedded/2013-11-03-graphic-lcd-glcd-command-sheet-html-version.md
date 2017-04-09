---
title: "Graphic LCD Command Sheet HTML Version"
date: 2013-11-03T21:12:52+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /graphic-lcd-glcd-command-sheet-html-version/
dsq_thread_id: "2728572025"
category: "Embedded"
tags: [ "LCD" ]
---

<!--NoAds-->


  
Yet again I was looking for the GLCD command sheet in the internet and failed to find any good resolution images that I can use for post references. Even the data sheet looks really bad. So here I am with a **HTML Version of the GLCD command sheet** just like the one for the <a title="Character LCD Command Sheet HTML Version" href="/character-lcd-command-sheet/" target="_blank">character LCD</a> I posted a while back.

 

<table class="aligncenter" style="width: 100%;" border="1" cellspacing="0" cellpadding="5" align="center">
  <tr align="center" valign="middle">
    <td colspan="12">
      <h2>
        <span style="font-family: tahoma, arial, helvetica, sans-serif;">GLCD Command Sheet</span>
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
      Display On/OFF
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
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      1
    </td>
    
    <td>
      *
    </td>
    
    <td>
      Controls the Display ON or OFF. Internal status and display RAM data is not affected.
    </td>
  </tr>
  
  <tr>
    <td>
      Set Address A  A  A  A A (Y Address)
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
    
    <td colspan="6">
      A  A  X Address ( 0 to 63 )
    </td>
    
    <td>
      Sets the Y address in the Y address counter.
    </td>
  </tr>
  
  <tr>
    <td>
      Set Page Address A (X Address)
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      1
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
      1
    </td>
    
    <td colspan="3">
      Page (0-7)
    </td>
    
    <td>
      Sets the X address in the X address counter.
    </td>
  </tr>
  
  <tr>
    <td>
      Display Start Line A (Z Address)
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
    
    <td colspan="6">
      Display Start Line (0-63)
    </td>
    
    <td>
      Indicates the display data RAM displayed at the top of the screen.
    </td>
  </tr>
  
  <tr>
    <td>
      Status Read
    </td>
    
    <td>
    </td>
    
    <td>
      1
    </td>
    
    <td>
      BF
    </td>
    
    <td>
    </td>
    
    <td>
      On/Off
    </td>
    
    <td>
      Rst
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
      Status Read
    </td>
  </tr>
  
  <tr>
    <td>
      Write Display Data
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
      Write data DB0 to DB7 into display data RAM. After writing instruction Y address is incremented by 1
    </td>
  </tr>
  
  <tr>
    <td>
      Read Display Data
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
      Reads data DB0 to DB7 from the display data RAM to the data bus.
    </td>
  </tr>
  
  <tr>
    <td colspan="12">
      <b>Instruction bit names:</b></p> 
      
      <ul>
        <li>
          <b style="line-height: 19px;">BF</b><span style="line-height: 19px;">A - 0 = can accept instruction, 1 = internal operation in progress.</span>
        </li>
        <li>
          <strong>RstA </strong>- 0 = Normal operation, 1 = Reset.
        </li>
        <li>
          <strong>ON/OFF -A </strong>0 = Display ON, 1 = Display OFF.
        </li>
      </ul>
    </td>
  </tr>
</table>
