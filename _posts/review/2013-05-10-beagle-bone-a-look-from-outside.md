---
title: Beagle Bone a look from outside
date: 2013-05-10T18:22:37+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /beagle-bone-a-look-from-outside/
dsq_thread_id: "3297479930"
category: "News"
tags: [ "Beagle Bone" ]
---

{% include image.html src="beaglebone.jpg" %}

The Beagle Bone is a pocket sized computer with Arm cortex A8 processor running a striped down version of angstrom Linux. Beagle Bone is much costlier than the popular counterpart [Raspberry Pi](http://www.raspberrypi.org), but has many advantages when compared to it.
  
The reason I got the Beagle Bone was because the Pis were in too much of a demand out there and it would have taken me several weeks to lay my hands on it. Now that I have taken a stance let me try to back it up :).

  1. It has a variety of capes ( the Arduino equivalent of shields) which could be plugged into the board to increase the performance.
  2. It connects through [SSH](http://en.wikipedia.org/wiki/Secure_Shell). so need for an external display device is not a mandatory issue though you are able to add an HDMI cape to extend the capability.
  3. It has a lot of IO pins, lot more than what you will ever need for your robotics application (out numbers the RPI by 4 to 1).
  4. The technical reference manual for the Broadcom BCM2835 chip in case of Raspberry Pi is not freely available, which spoils the entire idea of an open source/hardware. Whereas Beagle bone's TI chip is up all over the Internet (though going through the manual may seem daunting)

I have had the board in my hands for quiet some time, as usual there are some cons about the board. some of it even makes it a big pain.

  1. It does not have an on-board voltage regulator. All the regulation has to be done externally. Hence the size constraint is increased.
  2. The board has an input voltage tolerance of 0.1V. ie  it can tolerate a maximum deviation of just +/- 0.1V. If it goes beyond this limit the Power Management IC (PMIC) prevents it from booting up. Now this could mean real trouble as most household power adapters have a much higher supply voltage as they assume the device to be tolerant. So you might wanna buy some standard adapters.
  3. The board is highly static sensitive, so there is an absolute need for an enclosure. Now if your pockets aren't deep enough and you don't have the skills to make your own then you are doomed.

Well that's it for now. I will be using the Beagle Bone along with Open CV to do some image processing. And forgot to mention, angstrom's latest versions seems to come pre-loaded with the CV libraries, which means you don't have to install anything to get started.
