---
title: "Simple DIY Electromagnetic Bell"
date: 2014-12-14T16:45:18+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /simple-diy-electromagnetic-bell/
dsq_thread_id: "3322373915"
category: "Hardware"
tags: [ "HowTo", "DIY", "Basics" ]
---

You might think its pass time while I was talking about simple electromagnetic bells at my blog. Truth be told I would agree with you and embedjournal is pitching for a higher game in the near future. We will soon get into some android programming and write mobile apps that will talk with our embedded systems. But for now we will have to stick with this little bell as it was asked to be made by my boss. But trust me it is not as simple as it looks! there are somethings about this project that had me stuck for a couple of hours.

So, my boss calls me one morning (actually three days ago) and declares that his daughter had a project day coming up at school and need a simple project for her to showcase. The kid is in her first standard and things had to be simple for her to understand and the topic for the event was "sound". It's actually good to have a theme to work on. It helps us to focus our thought and also posses a bigger challenge that we should come up with some idea within the limit of the theme. I still remember all the project themes that was allotted to me at school. I miss all the good old days. And just as you might have guessed, I jumped right at the opportunity.

### Mechanical Hitter Setup

Setting up the mechanical hitter was the most time consuming task of all. Especially if you haven't seen anybody's design or haven't experimented with a couple of designs yourselves. I thought this project was too simple to even Google for similar designs and decided that I should just get on with it. The end result was that I had to do this whole thing twice (two different designs, this is the third one) before I could get it to work as expected and still be simple enough for a kid to understand.

{% include image.html src="electic-bell-pivot-arm.png" %}

I wouldn't call it the best setup, but it is adequate. It has a movable Pivot to allow the hitter to move forward and backward. The stopper is to hold it at a position under normal conditions, a rubber band to provide for the recoil. Lastly it has a supporting pole to hold everything in place.

### Electromagnet

If you had any exposure to science at all, you would know that a current carrying conductor is associated with a magnetic field. That is exactly what the electromagnet is all about. All you have to do is take a long wire and wind it around a magnetic material and power it up, voila you have an electromagne!

For this particular project I did not need a very powerful magnet. I took a screw that was lying around and wound it with some insulated copper wire to get the electromagnet working.

{% include image.html src="electromagnet.png" %}

You should be careful that there is no short in two adjacent wires or with the metallic screw while winding it. It is also a good practice to place one layer of insulator between the screw and the first layer of copper wire. You should certainly have an insulation at the end to prevent any accidental short circuit.

### Flyback Diode

The flyback diode or feedback diode is use in almost all circuits that involves big inductors. If you haven't noticed it already, there is a reverse biased diode in all relay coils to suppress back EMF and protect the rest of the circuit. In the electromagnet also we have a similar setup.

But in this case, it is not used for protection purpose (there is nothing to protect). Here we use it to decay the energy that is stored in the coil after the supply is removed. This is especially important because we need the electromagnet to de-energize as soon as possible to produce a sharp sound. Without the diode, it take its own sweet time to decay. There is also the case of the residual magnetism in the core but we just wont go that far.

### Testing the Setup

Once you have the electromagnet and the hitter ready, you will have to mount it at the right place so that the magnet will be able to attract the hitter and still be able produce enough swing to make a reasonably audible sound in the bell. Now for the magnet to not be able to attract, it is due to one of three reasons,

  1. Magnet is not strong enough
  2. Magnet is too far away
  3. The rubber band is in too tight a leash.

{% include image.html src="electric-bell.jpg" %}

If your magnet is not strong, you can increase the Voltage/Current and check if there is an improvement in the force of attraction. Sometimes it could be because you did not do enough winding around the screw or you just didn't choose the proper material for the core. Just keep experimenting and you should be able to get it working without much of an effort.

The magnetic lines of forces are the strongest at the vicinity of the core. If you place the hitter very far away from the magnet (screw), then your setup will not work. So you will have to figure out a suitable location so that the hitter is attracted all the time when you close the circuit.

Sometimes, everything is perfectly fine and you just have your rubber band too tight. Remember, it is used only to provide it with a small recoil force. It just has to take the hitter back to where it was initially if the electromagnet is de-energized. Anything above that is an added work load for your electromagnet.

Now all you have to do is setup the bell and hear it working!!

### Working Demonstration

I took the time to make a video of its working and have explained most of the details in the video as well.

If you have any suggestion/questions, leave them in the comments section below and I will get back to you as soon as possible.
