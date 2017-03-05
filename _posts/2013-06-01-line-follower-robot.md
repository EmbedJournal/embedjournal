---
id: 313
title: "Line Follower Robot - Build it from scratch"
date: 2013-06-01T11:20:55+00:00
author: Siddharth
layout: post
permalink: /line-follower-robot/
dsq_thread_id: "2728574119"

image: /wp-content/uploads/2013/05/DSC089861.jpg
categories: [ "How To", "Robotics", "Robots" ]
tags: [ "basics", "DIY", "line follower robot", "theory" ]
---

Line Follower Robots are the most common type of robots that are built by hobbyist and student interested in robotics and embedded systems. The reason for the popularity of the Line Follower robot is the fact that is simple to build and easy to understand the logic behind it. This post will give you working level knowledge on building and programming line follower robots from scratch.

A robot is a combination of hardware and software. One has to give equal importance to both these aspects. The hardware is just the skeleton of the system; it's the program that has to give the flesh and blood. The reason for my interest robots was the amazing integration it provided between the various fields of Engineering. Knowledge of one stream of engineering alone is not sufficient to build robots.

# Introduction to the concept of line follower:

For those of you don't already know, Line Follower type robots are those that are capable of following a line (black or white) as long as there is no discontinuity in the track. These robots have sensors on them to sense the line. They make proper direction changes according to the data acquired from the line sensors.

The nature of the line could be linear with abrupt, acute, right or obtuse angled turns. Or it could be a non-linear track which has 'T' and '+' junctions. A non linear track may be difficult to tackle as the junctions are all decision points. This post will only deal with the prospect of building a line follower robot. I will follow up this post with another one to handle the programming and logic analysis.

<div id='gallery-4' class='gallery galleryid-313 gallery-columns-2 gallery-size-thumbnail'>
  <figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/line-follower-robot/428096_337348329645195_1521283852_n/'><img width="150" height="150" src="/images/posts/2013/05/428096_337348329645195_1521283852_n-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-4-317" /></a>
  </div><figcaption class='wp-caption-text gallery-caption' id='gallery-4-317'> My very First Line Follower Robot </figcaption></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/line-follower-robot/220823_431759536870740_191378210_o/'><img width="150" height="150" src="/images/posts/2013/05/220823_431759536870740_191378210_o-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-4-318" /></a>
  </div><figcaption class='wp-caption-text gallery-caption' id='gallery-4-318'> The next one I made </figcaption></figure>
</div>

The one the left was my first line follower and is still at my loft and the one to the right is an upgraded version. You can see both of them have just 3 line sensors (will come to that). The third and final line follower I built was the '_blackboy_'A you already had a look at him dYtm, Unlike its ancestors the black boy had 5 sensors.

# BlackBoy (line follower):

[<img class="aligncenter size-large wp-image-314" src="/images/posts/2013/05/DSC089861-1024x576.jpg" alt="Line Follower" width="620" height="348" srcset="/images/posts/2013/05/DSC089861-1024x576.jpg 1024w, /images/posts/2013/05/DSC089861-300x169.jpg 300w" sizes="(max-width: 620px) 100vw, 620px" />](/images/posts/2013/05/DSC089861.jpg)

This is a line follower I designed to trace a Grid typeA tracks, It has 5 line sensors to track the line. This five sensor arrangement is quite good; I have used it a couple of times with good results. This I call it the balckboy. It has a Beagle Bone sitting on top of it adjacent to the 20x4 LCD display. I added the Bone to control black boy through WiFi (you can see a WiFi adapter connected to it even then though the WiFi control is still a future plan dYtm, )

This I can call the best hardware design I have ever achieved. It was built with such foresight that it is no longer just a line follower. That was probably the reason behind the fact that it has a name the others don't dYtm, It can be modified to work as a edge detector or a wall follower or a maze solver. I will publish a separate post on blackboy some time later.

# Construction:

Now, unlike my previous post, "<span style="text-decoration: underline;"><a title="Make a RC Robot Car" href="http://embedjournal.com/2013/05/make-a-rc-robot-car/" target="_blank">Make a RC Robot Car</a></span>" this line follower is real robotics. Here the decision is made by the robot (I should say the software) and not fed from an external source. A The total constriction can be divided into three sections.

1. The Chassis,
  
2. The Electronics, and
  
3. The Software.

# Building the Chassis:

Some people prefer to buy a fully designed chassis from robotic kit vendors and use them instead of building them. They also believe, it is pointless spending time making chassis when it can be bought dirt cheap. That is probably the attitude of someone who is in a hurry to get theA _'job'_A done rather than enjoying the process.

It is my opinion that one should spend adequate, if not lots of time designing and producing the chassis. The chassis build is a craft and it develops over time. So don't worry if you make a crappy looking robot in the first go.

I remember these words from a book that I read a long time ago and I don't happen to remember the name of the author, or the book. I will update this post if I found the the name of the book. It had pretty detailed accounts on various design strategy, especially the part which dealt with choosing the right material for the chassis.

That is something I leave it as experimentation section. Try your luck with all the materials and find out which one is the best dYtm, he says,

<address>
  <em>"Don't be surprised if you do to a robotic event close by and find that some of the bots there are seem to be built, and rammed by a truck and put back to shape with a hammer"</em>
</address>

That is something that I have personally seen and verified and that is probably the reason behind the persistence of the idea in my head. So build a poor but self built chassis. I suggest you start off with wood as they are the most commonly available material. Then you could move on to Acrylic, for making some cook designer finish and vibrant colors chassis.

Above all, the chassis is what is going to house the motors, sensors and the electronics, so spend some time thinking where to place the stuffs or you are going have trouble when you come to the later part of the design. The most important of them is the location of the line sensors. Read the part for sensor alignment (yet to come) carefully before deciding on the position of motors and circuitry.

Uses Google find some creative design for the chassis and show your passion for design of the robot make it look great. If you did a good job, it will inspire you to do more and learn more. There is no substitute for an inspiration from within you.

# The Line Follower sensor alignment and position:

The alignment of the line sensor is another thing that has to be given enough importance if you wanted it to follow the line. (After all itaEURtms a line follower it 'has' to follow the line)

The minimum number of line sensors needed for a line follower is just ONE.

Surprised! Yes, only one sensor is enough to follow the line, I have never tried it though :-).

So why do we need more sensors when only one sensor can so the job?? The answer, as you should have guessed, the robot will not follow the track with accuracy. It goes to either side of the track each time detecting the line crossing below it and taking the opposite turn to correct it. The other problem with such a sensor arrangement is that it is not capable detecting a junction point and it's frustratingly slow.

Then there is the 2 sensor and 3 senor alignment. Honestly I havenaEURtmt tried anything below 3 sensors. For a normal linear track, a 3 senor arrangement will do more than enough. All the sensors can be arranges one besides the other in a straight line. You don't need to do any artistic arrangements dY~>

Basically the Idea is if you have more sensors you have a better idea of the track and hence a better precision in following the line. So in any case we have to agree upon a minimum of 3 sensors. Here is how it goes,[<img class="aligncenter size-full wp-image-321" src="/images/posts/2013/05/line-sensor-allignment.png" alt="Line Follower " width="482" height="237" srcset="/images/posts/2013/05/line-sensor-allignment.png 482w, /images/posts/2013/05/line-sensor-allignment-300x148.png 300w" sizes="(max-width: 482px) 100vw, 482px" />](/images/posts/2013/05/line-sensor-allignment.png)

The Left, Center and Right sensors are mandatory. The other two sensors labeled L1 and R1 are optional is up to you to decide if you want to use them or not. The distance between each sensor should be less than the width of the line that you are about to follow. Each of the sensor unit marked in the image is a combination of the emitter and the detector.

There are two possible types of sensors that can be used with Line Follower robots; they are Infrared emitter-detector pair and the LED - LDR (Light Dependent Resistor) pair. It doesn't matter which sensor you are using. In the end both of them will return a HIGH or LOW level based of the state. Keep reading to find out.

# Firing up your Soldering Iron:

Now with the hardware fully over, our next job is to get the circuit ready. This section has five pars. The Sensor and its circuitry, the comparators, the Microcontroller unit, the motor driver and the power supply unit. Here is the inside view of balckboy showing all the the sections.

[<img class="aligncenter size-large wp-image-325" src="/images/posts/2013/05/DSC08975-1024x576.jpg" alt="Line Follower Circuitry" width="620" height="348" srcset="/images/posts/2013/05/DSC08975-1024x576.jpg 1024w, /images/posts/2013/05/DSC08975-300x169.jpg 300w" sizes="(max-width: 620px) 100vw, 620px" />](/images/posts/2013/05/DSC08975.jpg)

 

I have numbered the circuits for your understanding and hare is the explanation for each, in the numbering order. If you know what they are and have used them before, skip this section.

**1. The Line Follower Sensor and its circuitry**

This section houses the sensors. If you can see, I have the sensors soldered to the back side of the perf board and cut out a rectangular block from the base plate of the chassis so that the sensors are directly above the line through this window.

[<img class="aligncenter size-full wp-image-328" src="/images/posts/2013/05/circuit1.png" alt="Line Follower sensor circuit." width="788" height="483" srcset="/images/posts/2013/05/circuit1.png 788w, /images/posts/2013/05/circuit1-300x184.png 300w" sizes="(max-width: 788px) 100vw, 788px" />](/images/posts/2013/05/circuit1.png)

 

The <a title="LED" href="http://en.wikipedia.org/wiki/Light-emitting_diode" target="_blank">IR LED</a> and the normal LED are both similar and can easily be mixed up so be careful when you store them. The fully black one is the receiver and it has to be connected in reverse bias (see the circuit). This is a fairly simple circuit and I don't think It need much explanation. Go ahead and complete the circuit as it is.

**2. The Comparators:**

I forgot to tell you before, the range of conduction of the IR Receiver varies with the variation the intensityA of Infrared light falling on it in other words, the line sent the comparator in the previous circuit returns an analog value (0-5v) depending on the IR incidence. It's going to be obnoxious to use ADC's to convert them into digital. This is when a comparator comes in handy.

A comparator is a device that compares a reference voltage with the input voltage and return logic HIGH or LOW based on the comparison. In short, it converts the analog values into digital values based on a reference input given to it. <a title="comparator" href="http://en.wikipedia.org/wiki/Comparator" target="_blank">Read more here.</a>

[<img class="aligncenter size-full wp-image-329" src="/images/posts/2013/05/somparator-logic.png" alt="Line Follower comparator circuit." width="762" height="417" srcset="/images/posts/2013/05/somparator-logic.png 762w, /images/posts/2013/05/somparator-logic-300x164.png 300w" sizes="(max-width: 762px) 100vw, 762px" />](/images/posts/2013/05/somparator-logic.png)

 

You can use any comparator IC you have around, but if you are going to buy I would suggest <a title="LM324" href="https://www.google.co.in/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&ved=0CDMQFjAB&url=http%3A%2F%2Fwww.ti.com%2Flit%2Fds%2Fsymlink%2Flm124-n.pdf&ei=YrWoUYOVEYKJrQelnIBI&usg=AFQjCNEOyKTccifkq6d6zR_PLC30n98XpA&sig2=plUDRzFn35duWAYBYYiPNA&bvm=bv.47244034,d.bmk" target="_blank">LM234</a>A it is the most common OP-amp and is really cheap. In the circuit I have also included a output LED this is an optional feature, but it comes in really handy when things are going wrong.

**3.A Microcontroller Unit:**

This section as you guessed will have the microcontroller and its associated components. Here is a schematic for the PIC18f series microcontrollers. You can build your own schematics for microcontrollers or other series and families.

[<img class="aligncenter size-full wp-image-1602" src="/images/posts/2013/06/pic-basic.png" alt="pic basic" width="861" height="568" srcset="/images/posts/2013/06/pic-basic.png 861w, /images/posts/2013/06/pic-basic-300x198.png 300w, /images/posts/2013/06/pic-basic-310x205.png 310w" sizes="(max-width: 861px) 100vw, 861px" />](/images/posts/2013/06/pic-basic.png)

You might have to use the PGD, PGC and MCLR pins for programming the Microcontroller. so don't just leave it open. Forgot to tell you you need a <a title="PIC Kit 3" href="https://www.google.co.in/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&ved=0CCwQFjAA&url=http%3A%2F%2Fwww.microchip.com%2Fpickit3&ei=_r6oUb6PDcHtrAfj_oHABg&usg=AFQjCNF9yEyoVYPgZquvd7Co7qDwW8Ry_w&sig2=GA6N0zvaPPwUS4p5ZBJP2Q&bvm=bv.47244034,d.bmk" target="_blank">programmer</a> to program the MCU dYtm,

**4. The Motor Driver:**

The motor driver IC used is the <a title="Motor Driver" href="https://www.google.co.in/url?sa=t&rct=j&q=&esrc=s&source=web&cd=6&cad=rja&ved=0CEgQFjAF&url=http%3A%2F%2Fwww.datasheetcatalog.org%2Fdatasheet%2Ftexasinstruments%2Fl293d.pdf&ei=ibqoUbfYEcyzrgerhIGQAQ&usg=AFQjCNFKX5eO7YGYF26s5_cXKBxv_xMIxQ&sig2=clgQvApHr3CWsQUENrJSUw&bvm=bv.47244034,d.bmk" target="_blank">L293d</a>. It is the most common IC of it's kind and easily available in the market. There are plenty of guide on wiring this IC to your microcontroller. You can also refer to <a title="Make a RC Robot Car" href="http://embedjournal.com/2013/05/make-a-rc-robot-car/" target="_blank">this post</a> for a schematic for the L293d motor driver. It uses four GPIO pins to control the direction of rotation of the motor

**5. Power supply unit:**

The last and final section of the electronics is the power supply for all the above mentioned units. This is an integral part of the post and care must be given while designing this section. Here is a schematic for the power supply,

[<img class="aligncenter size-full wp-image-1603" src="/images/posts/2013/06/power-supply.png" alt="power supply" width="851" height="519" srcset="/images/posts/2013/06/power-supply.png 851w, /images/posts/2013/06/power-supply-300x183.png 300w" sizes="(max-width: 851px) 100vw, 851px" />](/images/posts/2013/06/power-supply.png)

This schematic features a rectifier. If you are using a DC supply (most people will) then you can just remove the rectifier and connect the positive to the upper line and negative to the lower line. For powering the motor you will have to use a 12v supply (if you are using one of those motors that I have used) for powering the motor (pin 8 of the L293d will take the secondary power supply (+12v) for the motor, read the datasheet carefully or you might fry the chip dYtm, )

# Wrapping Up:

We have discussed the hardware build and the electronics involved in making a line follower. With this information you should be able to do all but program the robot to follow the line. I will follow up this post soon with another post dealing with the <span style="text-decoration: underline;"><a title="The next post is here!!" href="http://embedjournal.com/2013/06/programming-line-follower-robot/" target="_blank">programming and logic section</a></span>.
