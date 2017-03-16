---
title: "Shaastra 2013 Nights on the streets (Jan'13)"
date: 2013-05-01T16:49:54+00:00
author: Siddharth
layout: post
permalink: /shaastra-nights-jan-2013/
dsq_thread_id: "2701837037"
categories: [ "General Posts" ]
tags: [ "Tech Fest", "Experience" ]

gallery1:
  - src:  track-3d-view.png
    name: "Track 3D View"
  - src:  track-spec.png
    name: "Track Specification"
  - src:  object-spec.png
    name: "Object Specification"

gallery2:
  - src:  chassis-making.jpg
    name: "Chassis in the making"
  - src:  robotic-arm-prototype.jpg
    name: "Robotic arm prototype"
  - src:  nexgen-shortlist.jpg
    name: "Our team Nexgen got selected for final round"
  - src:  ranger-robot.jpg
    name: "Land Rover (second robot)"
  - src:  servo-inventory.jpg
    name: "My modest servo collection"
  - src:  robot-pair.jpg
    name: "Robot pair"
  - src:  me-at-work.jpg
    name: "Me at work :)"
---

Shaastra is an annual tech fest conducted by Indian Institute of Technology, Chennai. There are events and workshops for almost all streams of Engineering and I love their Robotics events the most. The robotics event conducted by them is "The mother of all the robotics event in the county"-or that is what they say.. don't know how they guessed the gender of robotics dY~> (mother). I had always had an eye on this event ever since I was in my first year and I was a keen observer all this while until last October when they released their problem statement.

{% include image.html src="picker-robot.jpg" width=300 alt="6 DoF pick and place robot" %}

This time I made up my mind to give it a try. It has always been just me and me alone lost in my own thoughts thinking about the problem statement and how I -if money and means were there- would meet the requirement. I knew that this wouldn't do any good but I cant help my self but ponder on the idea. I forgot to mention their Prize money is always huge... Well big enough to tempt a hobby electronic-ist. But I really don't know why but money hardlyA fascinatesA me. Its not that I am not interested, Its just that I didn't need the money (unlessA of course there is some hardware that I badly needed.. In that case I always knew I has a lovely dad to turn to..)

Now for sure I knew I had the means (for I have been spending too much time on the internet) the next and most obvious problem I had to meet was the issue with the money. For that I needed a team, not just for financial support but for an intellectual support too. This was the mostA difficultA part of the entire event I had to look around for people. I planned to have five team-mates one to handle Embedded (that would be me) one to handle the Image Processing for we had chosen OpenCV as our platform. It was in fact my decision. I had a feeling that using some software tools would not be a good take given that my primary objective was learning. So just pure C and someA softwareA libraries was the best way to get started in this line. There came my next team mate Vijay.

Now we need some one to do our CAD ,some one to manage the finances and take care of the paper work while we had our hands dirty.. and some one to help in hardware... There goes theA remaining three (Naveen, Sivakumar, Natesan) of the Team NEXGEN. Yes, that was our team name for the event. All thisA finalizingA and pulling our selves together had already taken up fifteen days of A our time. I had already formed a fair picture of all the do-s and don't-s but I really had not started the work as such. Then came the time to give the problem statement a more closer look.

{% include gallery.html list=page.gallery1 %}

I am new toA WordPressA and can't figure out how the make this image bigger... so go ahead and click the image toA enrageA it -that is the most primitive solution to the problem.

And back to the issue at hand, we were supposed to make two bots one to follow the tunnel (the solid black line) and the other to follow the black-n-white track. The bots are supposed to start at the square check at the starting of the track and simultaneously traverse the path to reach the center (zone 3). Well that sound simple right? now here comes the tricky part... we have sense and identify the bombs (redA colorA objects) and stone (green color objects). If the object is a bomb we have to place it on one side of the track and if the object is a stone we have to place it on the other side of the track. The bot that had to cross the tunnel was fairly simple. It had to move below the tunnel (in this case a black sheet of card board) and then pull down a see-saw kind of bridge to move into zone 3. So most of the work has to be done by the other bot (called as the saviour). Once the two of them are inside the zone 3, they have to start picking up the bombs (all of them are bombs and randomly placed) -all of em :). This marks the end of the event and congrats you are the winner.

To do this we are given two cameras. We have to take the Image feed and process the data to find our wayA throughA the arena. IA prioritized on hardware and thought that if theA hardwareA wasA ready most of our work was done. Only later on that I realized that both hardware and software were of equalA importanceA and should have started them at the same time. But for now the hardware is what we were concentrating and Vijay could sleep as and when he pleased.

{% include gallery.html list=page.gallery2 %}

This the collection of Images I could find. From the top going left to right,

The saviour, this bot features a 6-DOF robotic arm, fully custom built fromA Acrylic sheets. It has a PIC 18F series (mid range 8-bit CPUs) controller to do theA controlA applications. The direction signal were given by serial port of the computer to the UART of the controller.

The Tunnel bot, this bot has a Ultrasonic range finder used to detect the see-saw typeA bridgeA that it has to pull down. Asides that it also has a PIC 18F seriesA controllerA to perform the control work. Again this also uses the UART toA receiveA the signals from the computer.

This image needs not naming... Team NEXGEN!!

The next one is the gripper sitting at the top of the robotic arm. This took aA surprisingA amount of time to build from design to implementation it took an entire day. So I thought it should go up in the list. It is controlled by a single servo motor. Next to it is the prototype of that gripper in paper.

The next two Images are from the building of chassis for both the bots.

This is the modest amount of servos that I ordered form China. In India a servo motor costs 1200 bucks while there its only 300!!! and they ship it for free.. If there was oneA heaven for engineers that would be China.

Thats me at work dYtm, in my room. I don't know who clicked that picture (I am yet to find out)

Lastly that is the Poster that the eventA organizersA released. ItA containedA theA listA of teams that got selected in the first round. Well we were there on the list. Our team name is on the 5th line for those who missed it.. Those teams that areA selected were called for the second round (pre-finals) to IIT from 3rd to 5th Jan.

The best part was that the events would take place in the night. Form 11 pm till dawn. IIT in the night is a great spot to be in especially during the fest seasons.. Its rather romantic. Now since we has the hardware ready I had to hop down to Vijay's house to wake him up for theA battle ahead which he should fight along side me.A Neither of us knew that was when the plot wasA thickening and the real show was yet to begin.

And that a small outline of my days spent over Shaastra 2013. Well I have not told all.. trust me there is one hell lot more and that would mostly bore you. If you are still interested send me an email and I will tell you the reaming story... Some of it may include how we almostA stoppedA the project and how we did not sleep for 4 days in a row.
