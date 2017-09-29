---
title: "Beware of learning embedded systems with Arduino"
date: 2013-05-28T18:04:44+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /learning-embedded-system-with-arduino/
dsq_thread_id: "2728571169"
category: "Arduino"
tags: [ "Arduino", "Intro" ]
---

The term '_Arduino_' is no longer new to anyone having the least bit of exposure to Embedded System. Some years ago when I first heard Arduino, it hadn't come into India yet and the only shops selling them were charging a little more than twice the actual cost. So I was inclined to believe that it was yet another fancy toy for those with some good monthly allowances or for those with the financial support from some university (in today's terms, telosB motes serves as a perfect example for what I was thinking of Arduino).

Definitely, I was mistaken. By the time I was looking back at it, the Arduino platform had grown so much that even the kids around the place were speaking of it!

{% include image.html src="arduino.jpg" %}

The Arduino is a really good platform. You could opt to work with it for more than one of the following (hard to ignore) reasons,

  1. The amount of effort that the developers have to put into it to simplify the programming.
  2. The robustness in terms of hardware, observing all precaution in electrical design.
  3. The level of optimization they have given to the PCB design in terms of footprint compatibility.
  4. The ease of programming the board through the Arduino IDE without the need for any programmer.
  5. The built in USB serial interface and an integrated serial monitor (_which is a boon when debugging_).
  6. The well built library functions.

I personally admire their servo and serial library. Managing all the servo refreshing rate should have taken one hell of an effort, not to mention the ability to program the 0-degree millisecond and 180-degree millisecond for each servo individually. One of the assignments I have to take up in the upcoming months will be to write an Arduino-like library for PIC control servo motors.

Besides all these features and crutches, I prefer to leave Arduino as a rapid prototyping platform alone that is suitable for proof-of-concept and not use it as a full time embedded system design platform for more than one good reasons. It covers up all the low level activities of the controller and prevents a beginner from understanding the underlying concepts. The library functions are so good that most of the work is already taken care by the background code. It's all so very well done that all you have to do is, 'type' the magic words.

I don't know why, but whenever I work with Arduino, I have a strange feeling that I am just meddling with someone else's code rather than writing my own. Now these are tricky stuffs, if something was to go wrong you are totally lost.. Yes, there is a huge community out there, that can help you but what's the point? This time they helped you out, next time you've got to be there for some other problem. And who knows, you might not be just as lucky. These are the times when good old skills will come in handy; - begin writing the code from scratch.

Lastly, by using Arduino you get to learn the platform and not the controller lying beneath it, Real embedded system is not in mastering the use of a platform but understanding the basic concepts of any one controller (_be it any_) by sitting with just its datasheet and a development board. That way you get to know what exactly you are doing. It might turn out to be daunting and exasperating but trust me when you are done it will feel a lot better.

Arduino is definitely something you should learn to work with but, starting with the Arduino is a big NO-NO. Once you get a feel of the '_real_' embedded system you could always revert back to Arduino and see how life has been made easy for you. But the converse may not always be true.
