---
title: I2C Protocol (2-Wire Interface) in a nut shell
date: 2013-05-13T18:19:29+00:00
author: Siddharth
layout: post
permalink: /two-wire-interface-i2c-protocol-in-a-nut-shell/
dsq_thread_id: "2728571673"
categories: [ "Embedded Theory" ]
tags: [ "Basics", "I2C", "Protocol", "Theory" ]
---

The I2C protocol also known as the two wire interface is a simple serial communication protocol that uses just two pins of aA microcontroller namely SCL (serial clock) and SDA (serial data). This is a very popular protocol cat can be used to address a large number of slave devices that areA connectedA to the same bus. This protocol comes in handy when there is scarcity onA availableA pins in the microcontroller. Each slave device has a slave address or names for which they respond this is usually 7-bit binary number. Once a master sends a valid slave address only that slave will respond to the master's queries and all other slaves ignore any conversation between the master and that particular slave.

There are a number of conditions that can be made over the I2C bus such a start and stop sequence.A The data line does not change when the clock line is HIGH. If the data line changes when the clock line is High, the slave device interprets it as aA commandA and not as a data. This is the only feature in the interface that puts a distinct line between the command and data.

**I2C ProtocolA Timing Diagram:**

<p style="text-align: center;">
  <a href="/images/posts/2013/05/untitled1-1.png"><img class="aligncenter size-full wp-image-80" alt="I2C Protocol Timing Diagram" src="/images/posts/2013/05/untitled1-1.png" width="900" height="360" srcset="/images/posts/2013/05/untitled1-1.png 900w, /images/posts/2013/05/untitled1-1-300x120.png 300w" sizes="(max-width: 900px) 100vw, 900px" /></a>
</p>

**Understanding the Start and Stop sequence of I2C Protocol:**

The timing diagram above has theA start sequenceA shown in the dotted box to the left. Here if you notice the data line SDA is having a High to Low transition when the clock line SCL is HIGH. Under normal circumstances this does not happen as you can see in the subsequent clock pulses the data line is stable in one state, either HIGH or LOW when the clock line is HIGH. Similarly to the right most side of the diagram you will find another dotted box with theA stop sequenceA (see the one with the solid line inside the box). The data line experiences a LOW to HIGH transitionA when the clock line is HIGH.

Besides this there is also a Repeated Start condition to continue the interface. The name Repeated Start sequenceA may sound fancy but that is nothing but a Start sequence that is given once again after a previous Start sequence.

**Application:**

The I2C protocol is quiet easy toA understand. The working of theA protocol is illustrated in the following content,

The rule of the thumb is that every time the slave devicesA experiencesA Start sequenceA it expects a 7-bit slave address along with a read/writeA specifier in the MSB (0 - for write and 1 A - read). A If theA specifierA is set to write then the next data written will be the address to the register to which the consecutive data is to be written the device automatically increments the register pointer after a success full write. On the other hand if theA specifierA is set to read then the incomingA data from the bus will return the value of the register to which the stack pointer was last pointing to and the consecutive registers following it.

**Sequentially write data to a slave device with I2C Protocol:**

Here, the slave address with the write specifierA is sent after the Start sequence. The slave sends anA Acknowledge to the master (MCU). Then the next byte of data written to the slave device is the address of the register to write to. Following this there can be any number of A sequential write operationsA with slave sendingA Acknowledge after every byte of data written to the register starting from the register specified by the address and sequentially moving up after each write operation. This can be terminated by sending a Stop sequence.

<p style="text-align: center;">
  <a href="/images/posts/2013/05/untitled3.png"><img class="aligncenter size-full wp-image-82" alt="Sequentially write data to a slave device with I2C Protocol" src="/images/posts/2013/05/untitled3.png" width="761" height="186" srcset="/images/posts/2013/05/untitled3.png 761w, /images/posts/2013/05/untitled3-300x73.png 300w" sizes="(max-width: 761px) 100vw, 761px" /></a>
</p>

 

**Sequentially read data from a slave device with I2C Protocol:**

Initially the slave address with the read specifierA is sent after the Start sequence. The Slave sends an Acknowledge to the MCU.A Following this there can be any number of A sequential read operationsA with master(MCU) sendingA Acknowledge after every byte of data readA  from the register last written in the write operation (since, address of the register to read from is not specified here). This sequential read can be stopped by sending a NotA AcknowledgeA signal followed by a Stop sequence

<p style="text-align: center;">
  <a href="/images/posts/2013/05/untitled41.png"><img class="aligncenter size-full wp-image-84" alt="Sequentially read data from a slave device with I2C Protocol" src="/images/posts/2013/05/untitled41.png" width="761" height="186" srcset="/images/posts/2013/05/untitled41.png 761w, /images/posts/2013/05/untitled41-300x73.png 300w" sizes="(max-width: 761px) 100vw, 761px" /></a>
</p>

 

**Sequentially read and write data as a combination of the above two methods:**

This process is just a mixture of both the sequential read and sequential write methods.A Initially the slave address with the writeA specifierA is sent after the Start sequence. Then the next data to be written will be the address of the register in the slave deviceA over which the operation is going to beA performed.A  Once this is done a repeated start sequence is made and and the 7-bit slave address with the read specifier is transmitted. Following this there can be any number of sequentialA read from the register addressA specified inA the previous step along with all the registers that follow it. The register address is automatically incremented by the device. The sequential read willA involveA the master (MCU) sending aA Acknowledge to the slave after every byte of data read. TheA repeated read process can be stopped by sending a Not AcknowledgeA signal followed by a stop sequence.

<p style="text-align: center;">
  <a href="/images/posts/2013/05/untitled2.png"><img class="aligncenter size-full wp-image-81" alt="Sequentially read and write data as a combination of the above two methods" src="/images/posts/2013/05/untitled2.png" width="760" height="244" srcset="/images/posts/2013/05/untitled2.png 760w, /images/posts/2013/05/untitled2-300x96.png 300w" sizes="(max-width: 760px) 100vw, 760px" /></a>
</p>

 

This is the bare minimum that any programmer should know to get started with using devices that a interfaces using the I2C protocol. There is lot more to this protocol than this. So I suggest you download the Philips user's manual for the same if you are going to do anything serious.

Don't miss the exciting new posts that are yet to come.A <a href="http://embedjournal.com/subscribe/" target="_blank">Subscribe to embedjournal.com</a>A and get our latest post delivered to your inbox.
