---
title: "Line Follower Robot - Build it from scratch"
date: 2013-06-01T11:20:55+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /line-follower-robot/
dsq_thread_id: "2728574119"
category: "Robotics"
tags: [ "HowTo", "Basics", "DIY", "LFR", "Theory" ]
---

Line Follower Robots are the most common type of robots that are built by hobbyist and students interested in robotics and embedded systems. The reason for the popularity of the Line Follower robot is the fact that it is simple to build and it is easy to understand the logic behind it. This post will give you a working level knowledge on building and programming line follower robots from scratch.

A robot is a combination of hardware and software. One has to give equal importance to both these aspects. The hardware is just the skeleton of the system; it's the program that has to give the flesh and blood. The reason for my interest in robots is the amazing integration it provided between the various fields of Engineering. Knowledge of one stream of engineering alone is not sufficient to build robots.

### Introduction to the concept of line follower:

For those of you who don't already know, Line Follower type robots are those that are capable of following a line (black or white) as long as there is no discontinuity in the track. These robots have sensors on them to sense the line. They make proper direction changes according to the data acquired from the line sensors.

The nature of the line could be linear with abrupt, acute, right or obtuse angled turns. Or it could be a non-linear track which has 'T' and '+' junctions. A non linear track may be difficult to tackle as the junctions are all decision points. This post will only deal with the prospect of building a line follower robot. I will follow up this post with another one to handle the programming and logic analysis.


{% include image.html src="fisrt-line-follower-robot.jpg" %}

That was my first line follower robot. I made this back in 2012 for a tech fest and is permanent member of my loft robot collection.

{% include image.html src="upgraded-line-follower-robot.jpg" %}

This one to the is an upgraded version of the previous robot. You can see that both of them have just 3 line sensors (will come to that). The third and final line follower I built was the _Blackboy_ you already had a look at him. Unlike its ancestors the black boy had 5 sensors.

### BlackBoy (line follower):

{% include image.html src="blackboy.jpg" %}

This is a line follower I designed to trace  Grid type tracks, It has 5 line sensors to track the line. This five sensor arrangement is quite good; I have used it a couple of times with good results. I call this the BlackBoy. It has a Beagle Bone sitting on top of it adjacent to the 20x4 LCD display. I added the Bone to control BlackBoy through WiFi (you can see a WiFi adapter connected to it even though the WiFi control is still a future plan.

This I can call the best hardware design I have ever achieved. It was built with such foresight that it is no longer just a line follower. That was probably the reason behind the fact that it has a name while the others don't. It can be modified to work as an edge detector or a wall follower or a maze solver. I will publish a separate post on blackboy some time later.

### Construction:

Now, unlike my previous post, [Make a RC Robot Car](/make-a-rc-robot-car/) this line follower is real robotics. Here the decision is made by the robot (I should say the software) and not fed from an external source.  The total constriction can be divided into three sections.

  1. The Chassis,
  2. The Electronics, and
  3. The Software.

### Building the Chassis:

Some people prefer to buy a fully designed chassis from robotic kit vendors and use them instead of building them. They also believe, it is pointless spending time making chassis when it can be bought dirt cheap. That is probably the attitude of someone who is in a hurry to get the _'job'_ done rather than enjoying the process.

It is my opinion that one should spend adequate, if not lots of time designing and producing the chassis. The chassis build is a craft and it develops over time. So don't worry if you make a crappy looking robot in the first go.

Above all, the chassis is what is going to house the motors, sensors and the electronics, so its worth spending sometime thinking where to place the stuffs or you are going have trouble when you come to the later part of the design. The most important of them is the location of the line sensors. Read the part for sensor alignment (yet to come) carefully before deciding on the position of motors and circuitry.

> Don't be surprised if you go to a robotic event close by and find some robots that look like they were built, rammed by a truck and put back to shape with a hammer.

I remember these words from a book that I read a long time ago. This is something that I have personally seen and verified; that's probably the reason why this statement kind of stuck on to my head.  Unfortunately, I don't remember the name of the author, or the book. I will update this post if I am able to recollect it later. It had some pretty detailed accounts on various design strategy, especially the part which dealt with choosing the right material for the chassis.

So build a poor but self built chassis. I suggest you start off with wood as they are the most commonly available material. Then you could move on to Acrylic, for making some designer finish and vibrant colored chassis. You should check out my writeup on [chassis building and the various materials that you can choose from](/how-to-make-chassis/) if you are so inclined.

Use Google to find some creative design for the chassis and show your passion for the design of the robot and make it look great. If you did a good job, it will inspire you to do more and learn more. There is no substitute for an inspiration from within you.

### The Line Follower sensor alignment and position:

The alignment of the line sensor is another thing that has to be given enough importance if you wanted it to follow the line. (After all it's a line follower it 'has' to follow the line)

The minimum number of line sensors needed for a line follower is just ONE.

Surprised! Yes, only one sensor is enough to follow the line, I have never tried it though :-).

So why do we need more sensors when only one sensor can so the job?? The answer is, as you should have guessed, the robot will not follow the track with accuracy. It goes to either side of the track each time detecting the line crossing below it and taking the opposite turn to correct it. The other problem with such a sensor arrangement is that it is not capable detecting a junction point and it's frustratingly slow.

Then there is the 2 sensor and 3 senor alignment. Honestly I haven't tried anything below 3 sensors. For a normal linear track, a 3 senor arrangement will do more than enough. All the sensors can be arranged one besides the other in a straight line. You don't need to do any artistic arrangements.

Basically the idea is if you have more sensors you have a better idea of the track and hence a better precision in following the line. So in any case we have to agree upon a minimum of 3 sensors. Here is how it goes,

{% include image.html src="line-sensor-alignment.png" %}

The Left, Center and Right sensors are mandatory. The other two sensors labeled L1 and R1 are optional and is up to you to decide if you want to use them or not. The distance between each sensor should be less than the width of the line that you are about to follow. Each of the sensor unit marked in the image is a combination of the emitter and the detector.

There are two possible types of sensors that can be used with Line Follower robots; they are Infrared emitter-detector pair and the LED - LDR (Light Dependent Resistor) pair. It doesn't matter which sensor you are using. In the end both of them will return a HIGH or LOW level based of the state. Keep reading to find out.

### Firing up your Soldering Iron:

Now with the hardware fully over, our next job is to get the circuit ready. This section has five pars. The Sensor and its circuitry, the comparators, the Microcontroller unit, the motor driver and the power supply unit. Here is the inside view of BlackBoy showing all the the sections.

{% include image.html src="blackboy-inside.jpg" %}

I have numbered the circuits for your understanding and here is the explanation for each, in the numbering order. If you know what they are and have used them before, skip this section.

#### Line Follower Sensor circuitry:

This section houses the sensors. If you can see, I have the sensors soldered to the back side of the perf board and cut out a rectangular block from the base plate of the chassis so that the sensors are directly above the line through this window.

{% include image.html src="line-sensor-alignment.png" %}

The <a title="LED" href="http://en.wikipedia.org/wiki/Light-emitting_diode" target="_blank">IR LED</a> and the normal LED are both similar and can easily be mixed up so be careful when you store them. The fully black one is the receiver and it has to be connected in reverse bias (see the circuit). This is a fairly simple circuit and I don't think it needs much explanation. Go ahead and complete the circuit as it is.

#### Comparators:

I forgot to tell you before, the range of conduction of the IR Receiver varies with the variation the intensity of Infrared light falling on it in other words, the line sent the comparator in the previous circuit returns an analog value (0-5v) depending on the IR incidence. It's going to be obnoxious to use ADC's to convert them into digital. This is when a comparator comes in handy.

A comparator is a device that compares a reference voltage with the input voltage and returns logic HIGH or LOW based on the comparison. In short, it converts the analog values into digital values based on a reference input given to it. Read more [here](http://en.wikipedia.org/wiki/Comparator).

{% include image.html src="comparator-schematic.png" %}

You can use any comparator IC you have around, but if you are going to buy I would suggest LM234 it is the most common OP-amp and is really cheap. In the circuit I have also included an output LED. This is an optional feature, but it comes in really handy when things are going wrong.

#### Microcontroller Unit:

This section as you guessed will have the microcontroller and its associated components. Here is a schematic for the PIC18f series microcontrollers. You can build your own schematics for microcontrollers or other series and families.

{% include image.html src="pic-basic-schematic.png" %}

You might have to use the PGD, PGC and MCLR pins for programming the Microcontroller through a programmer like PicKit3.

#### The Motor Driver:

The motor driver IC used is the all famous L293d. It is the most common IC of it's kind and easily available in the market. There are plenty of guide on wiring this IC to your microcontroller. You can also refer to [this post](/make-a-rc-robot-car/) for a schematic for the motor driver. It uses four GPIO pins to control the direction of rotation of the motor

#### Power supply unit:

The last and final section of the electronics is the power supply for all the above mentioned units. This is an integral part of the post and care must be given while designing this section. Here is a schematic for the power supply,

{% include image.html src="power-supply-schematic.png" %}

This schematic features a rectifier. If you are using a DC supply (most people will) then you can just remove the rectifier and connect the positive to the upper line and negative to the lower line. For powering the motor you will have to use a 12V supply (if you are using one of those motors that I have used) for powering the motor (pin 8 of the L293d will take the secondary power supply (+12V) for the motor, read the datasheet carefully or you might fry the chip.

### Wrapping Up:

We have discussed the hardware build and the electronics involved in making a line follower. With this information you should be able to do all but program the robot to follow the line. I will follow up this post soon with another post dealing with the [programming and logic section](/programming-line-follower-robot/) stay tuned  .
