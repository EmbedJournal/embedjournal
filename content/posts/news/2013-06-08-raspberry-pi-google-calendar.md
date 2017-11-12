---
title: "Raspberry Pi Google Calendar - A Combined venture for Mobile Phones"
date: 2013-06-08T12:22:54+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Naveen
thumbnail: post-thumb.jpg
permalink: /raspberry-pi-google-calendar/
dsq_thread_id: "2728571503"
category: "News"
tags: [ "RaspberryPi" ]
---

{% include image.html src="google-calander.jpg" %}

Raspberry Pi Google calender? That is an irresistible pair!! Hello all, I am sure these days most of you would be having a smart phone. We manage almost any thing that has to do with our digital self from these devices. The wide variety of apps available to make our life easy is simply astounding. These devices are like our right hand (if not both hands) and the majority of us use Google Calendar to make reminders, alarms and events. Even as we make reminders in these phones, we forget to remind our selves to carry the phone with us all the time.

The result is that we  don't notice the alarming sound. Raspberry Pi provides a cool solution to this. All you need to do is integrate your smart phone with Raspberry Pi with some simple write ups. Raspberry Pi is set as an alarm clock that is set using Google Calendar. Or your Raspberry pi becomes your alarm set and rest from virtually anywhere through Internet. The Raspberry Pi is connected to powered speakers which are used as the audio out device. The Speakers play a music or sound set by the user while wiring the code. Whenever Google calendar encounters an event or appointment in the Google calendar it will produce the sound to remind us of the event. This task is accomplished by using the Google Data APIs Python Client Library.

The Raspberry Pi Polls the data from the Google Calendar of your smart phone and as soon as it is able to get the data it is synchronized with the calender and then the code comes into action. As a result all the events in the Google Calendar will be stored in Pi, and Pi functions accordingly to those events. Now a question arises what happens when we don't have an Internet connection an event?? This issue is also handled by the Raspberry Pi. It stores the events occurred earlier when it was synchronized. So all the events,even the future events will be stored in the Pi and it will function accordingly.

Hence a persistent Internet connection is not needed for this device. This idea should help me a lot in getting up in the morning! even though my smart phone is beside me I wont wake up easily as their sound is either too low or too good to wake me up :-). But here we use a large speaker (larger than what my mobile has for sure) and the other good point is we _'have to'_ get up from the bed to put it out..
