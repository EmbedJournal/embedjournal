---
title: Beagle Bone a look from outside
date: 2013-05-10T18:22:37+00:00
author: Siddharth
layout: post
thumbnail: post-thumb.jpg
permalink: /beagle-bone-a-look-from-outside/
dsq_thread_id: "3297479930"
categories: [ "News" ]
tags: [ "Beagle Bone" ]
---

[<img class="aligncenter size-full wp-image-299" alt="beaglebone" src="/images/posts/2013/05/beaglebone.jpg" width="1024" height="996" srcset="/images/posts/2013/05/beaglebone.jpg 1024w, /images/posts/2013/05/beaglebone-300x292.jpg 300w" sizes="(max-width: 1024px) 100vw, 1024px" />](/images/posts/2013/05/beaglebone.jpg)The Beagle BoneA is a pocket sized computer with Arm cortex A8 processor running a striped down version of angstrom Linux. Beagle BoneA is much costlier than the popular counterpartA <a title="Raspberry Pi" href="http://www.raspberrypi.org" target="_blank" rel="homepage">Raspberry Pi</a>, but has many advantages when compared to it.
  
The reason I got the Beagle BoneA was because the PiaEURtms were in too much a demand out here and it would have taken me several weeks to lay my hands on it. Now that I have taken a stance let me try to back it up :).

  1. It has a variety of capes ( the Arduino equivalent of shields) which could be plugged into the board to increase the performance.
  2. It connects throughA <a title="Secure Shell" href="http://en.wikipedia.org/wiki/Secure_Shell" target="_blank" rel="wikipedia">SSH</a>A (secure shell). so need for a external display device is not a mandatory issue though you are able to add a HDMI cape to extend the capability.
  3. It has a lot of IO pins, lot more than what you will ever need for your robotics application (out numbers the RPI by 4 to 1).
  4. The technical reference manual for the Broadcom BCM2835A chip in case of Raspberry Pi is not freely available, which spoils the entire idea of an open source/hardware.A WhereasA <a title="BeagleBoard" href="http://beagleboard.org/" target="_blank" rel="homepage">Beagle bone</a>aEURtms TI chip is up all over the internet (though going through the manual may seem daunting)

I have had the board in my hands for quiet some time, as usual there are some cons about the board. some of it even makes it a big pain.

  1. It does not have a on-board voltage regulator. All the regulation has to be done externally. Hence the size constraint is increased.
  2. The board has an input voltage tolerance of 0.1V. ie.A  it can tolerate a maximum deviation of just +/- 0.1V. If it goes beyond this limit the PMIC (<a title="Power Management IC" href="http://en.wikipedia.org/wiki/Power_Management_IC" target="_blank" rel="wikipedia">power management IC</a>) prevents it from booting up. Now this could mean real trouble as most household power adapters have a much higher supply voltage as they assume the device to be tolerant. So you might wanna buy some standard adapters.
  3. The board is highly static sensitive, so there is a absolute need for an enclosure. Now if your pocketsA aren'tA deep enough and you donaEURtmt have the skills to make your own then you are doomed.

Well thataEURtms it for now I will be using the Beagle BoneA along with Open CV to do some image processing. And forgot to mention, angstromaEURtms latest versions seems to come pre-loaded with the CV libraries, which means you donaEURtmt have to install anything to get started.