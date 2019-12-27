---
title: "Shaastra 2013 Nights on the streets (Jan'13)"
date: 2013-05-01T16:49:54+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /shaastra-nights-jan-2013/
dsq_thread_id: "2701837037"
category: "General Posts"
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
  - src:  robot-pair.jpg
    name: "Both robots in one View"
  - src:  me-at-work.jpg
    name: "Me at work :)"
  - src:  picker-robot.jpg
    name: "6 DOF pick and place robot"
---

Shaastra is an annual tech fest conducted by Indian Institute of Technology, Chennai. There are events and workshops for almost all streams of Engineering and I love their Robotics events, the most. The robotics event conducted by them is "The mother of all the robotics event in the county" - or that is what they say.. don't know how they guessed the gender of robotics :P. I always had an eye on this event ever since I was in my first year and I was a keen observer of all this while until last October when they released their problem statement.

{% include image.html src="picker-robot.jpg" width=300 alt="6 DoF pick and place robot" %}

This time I made up my mind to give it a try. It has always been just me and me alone lost in my own thoughts thinking about the problem statement and how I -if money and means were there- would meet the requirement. I knew that this wouldn't do any good but I couldn't help my self but ponder on this idea. I forgot to mention that their Prize money is always huge... Well big enough to tempt a hobby electronic-ist. But money hardly fascinates me. Its not that I am not interested, its just that I didn't need the money (unless of course there is some hardware that I badly need.. In that case I always knew I have a lovely dad to turn to..)

Now for sure I knew I had the means (for I have been spending too much time on the internet), the next and most obvious problem I had to meet was the issue with the money. For that I needed a team, not just for financial support but for an intellectual support too. This was the most difficult part of the entire event - I had to look around for people. I planned to have five team-mates one to handle Embedded (that would be me) one to handle the Image Processing for we had chosen OpenCV as our platform. I had a feeling that using some software tools would not be a good take,  given that my primary objective was learning. So just pure C and some software libraries were the best way to get started with, in this line. There came my next team mate Vijay.

Now we need some one to do our CAD, some one to manage the finances and take care of the paper work while we had our hands dirty.. and some one to help with hardware... There goes the remaining three (Naveen, Sivakumar, Natesan) of the team NEXGEN. Yes, that was our team name for the event - NEXGEN. All this finalizing and pulling ourselves together had already taken up fifteen days of our time. I had already formed a fair picture of all the do-s and don't-s but I really had not started the work as such. Then came the time to give the problem statement a more closer look.

{% include gallery.html list=page.gallery1 %}

And back to the issue at hand, we were supposed to make two bots one to follow the tunnel (the solid black line) and the other to follow the black-n-white track. The bots were supposed to start at the square check at the starting of the track and simultaneously traverse the path to reach the center (zone 3). Well that sounds simple right? Now here comes the tricky part... we have to sense and identify the bombs (red color objects) and stone (green color objects). If the object is a bomb we have to place it on one side of the track and if the object is a stone we have to place it on the other side of the track. The bot that had to cross the tunnel was fairly simple. It had to move below the tunnel (in this case a black sheet of card board) and then pull down a see-saw kind of bridge to move into zone 3. So most of the work has to be done by the other bot (called as the saviour). Once the two of them are inside the zone 3, they have to start picking up the bombs (all of them are bombs and randomly placed) -all of em :). This marks the end of the event and congrats you are the winner.

To do this we are given two cameras. We have to take the Image feed and process the data to find our way through the arena. I prioritized on hardware and thought that if the hardware was ready most of our work was done. Only later on that I realized that both hardware and software were of equal importance and should have started them at the same time. But for now the hardware is what we were concentrating and Vijay could sleep as and when he pleased.

{% include gallery.html list=page.gallery2 %}

This is a collection of images I could find. From the top going left to right,

The saviour, this bot features a 6-DOF robotic arm, fully custom built from Acrylic sheets. It has a PIC 18F series (mid range 8-bit CPUs) controller to do the control applications. The direction signal were given by serial port of the computer to the UART of the controller.

The Tunnel bot, this bot has an Ultrasonic range finder used to detect the see-saw type bridge that it has to pull down. Besides that, it also has a PIC 18F series controller to perform the control work. Again this also uses the UART to receive the signals from the computer.

This image needs no naming... Team NEXGEN!!

The next one is the gripper sitting at the top of the robotic arm. This took a surprising amount of time to build from design to implementation. It took an entire day. So I thought it should go up in the list. It is controlled by a single servo motor. Next to it is the prototype of that gripper in paper.

The next two images are from the building of chassis for both the bots.

This is the modest amount of servos that I ordered form China. In India a servo motor costs 1200 bucks while there costs only 300!!! and they ship it for free.. If there was one heaven for engineers, that would be China.

Thats me at work, in my room. I don't know who clicked that picture (I am yet to find it out!!).

Lastly that is the Poster that the event organizers released. It contained the list of teams that got selected in the first round. Well, we were there on the list. Our team name is on the 5th line for those who missed it. Teams that were selected were called for the second round (pre-finals) to IIT from 3rd to 5th Jan.

The best part was that the events would take place in the night. Form 11 pm till dawn. IIT in the night is a great spot to be in especially during the fest seasons.. Its rather romantic. Now since we have the hardware ready I had to hop down to Vijay's house to wake him up for the battle ahead, which he should fight along side me. Neither of us knew that, that was when the plot was thickening and the real show was yet to begin.

And that's a small outline of my days spent over Shaastra 2013. Well I have not told all.. trust me there is so much more and that would mostly bore you. If you are still interested send me an email and I will tell you the remaining story... Some of it may include how we almost stopped the project and how we did not sleep for 4 days in a row.
