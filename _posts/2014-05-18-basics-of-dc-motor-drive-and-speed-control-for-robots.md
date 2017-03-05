---
id: 2134
title: Basics of DC Motor Drive and Speed Control for Robots
date: 2014-05-18T09:00:27+00:00
author: Siddharth
layout: post
permalink: /basics-of-dc-motor-drive-and-speed-control-for-robots/
dsq_thread_id: "3290522357"

image: /wp-content/uploads/2014/05/dcmotor.jpg
categories: [ "Basics" ]
tags: [ "basics", "interface", "theory" ]
---

[<img class="aligncenter size-full wp-image-2255" src="/images/posts/2014/05/dcmotor.jpg" alt="dc motor" width="499" height="366" srcset="/images/posts/2014/05/dcmotor.jpg 499w, /images/posts/2014/05/dcmotor-300x220.jpg 300w" sizes="(max-width: 499px) 100vw, 499px" />](/images/posts/2014/05/dcmotor.jpg)DC motors are really cheap and can be found very easily. In this post we will discuss the basic theory behind the DC motor drive system and its speed control. Having some basic understanding of how your motor driver works will play a key role in building your own circuits debugging them.

The main advantage is that, they are really easy to interface. Hook the wiresA on to the battery terminals and they will work just fine. The direction of rotation is based on the direction of current flow in the armature (polarity of the battery). The below image illustrates the direction on the motor with respect to the direction of the current flow.

[<img class="aligncenter wp-image-2155" src="/images/posts/2013/05/direction.png" alt="DC Motor Drive principle" width="705" height="199" srcset="/images/posts/2013/05/direction.png 865w, /images/posts/2013/05/direction-300x85.png 300w" sizes="(max-width: 705px) 100vw, 705px" />](/images/posts/2013/05/direction.png)

Okay, if you flip the wires connected to the battery terminals, the direction of rotation will change! But that is not gonna help much if you want the car to be remote controlled. So there has to be a way to flip the wires without having to touch it... That's when an H-Bridge network comes into action.

## H-Bridge

An H-bridge is nothing but a connection of the motor that resembles the letter 'H' in the English language.

[<img class="aligncenter wp-image-2157" src="/images/posts/2013/05/hbridge.png" alt="DC Motor Drive Mechanical arrangement" width="576" height="384" srcset="/images/posts/2013/05/hbridge.png 687w, /images/posts/2013/05/hbridge-300x200.png 300w" sizes="(max-width: 576px) 100vw, 576px" />](/images/posts/2013/05/hbridge.png)

### S1, S4 - ON and S2, S3 - OFF

Now if we were to turn on the switch S1 and S4 we will observe that the current flows from Battery positive toA S1 and then to the motor and reached the negative terminal of the battery through S4.

[<img class="aligncenter wp-image-2158" src="/images/posts/2013/05/hbridge1.png" alt="Switches S1 and S4 are ON" width="585" height="390" srcset="/images/posts/2013/05/hbridge1.png 687w, /images/posts/2013/05/hbridge1-300x200.png 300w" sizes="(max-width: 585px) 100vw, 585px" />](/images/posts/2013/05/hbridge1.png)

### S2, S3 - ON and S1, S4A - OFF

Similarly,A if we were to turn on the switch S2 and S3 we will observe that the current flows from Battery positive toA S2 and then to the motor and reached the negative terminal of the battery through S3.

[<img class="aligncenter wp-image-2156" src="/images/posts/2013/05/hbridge2.png" alt="Switches S2 and S3 are ON" width="603" height="398" srcset="/images/posts/2013/05/hbridge2.png 687w, /images/posts/2013/05/hbridge2-300x198.png 300w, /images/posts/2013/05/hbridge2-310x205.png 310w" sizes="(max-width: 603px) 100vw, 603px" />](/images/posts/2013/05/hbridge2.png)

From the above cases you can see that the direction of current flow is reversed. Hence the direction of rotation of the motor is also reversed. This way we are able to drive the motor in both the directions without having to manually flipping the wires.

### Electronically speaking,

Yes, we do have to speak electronics! Switches S1 through S4 are replaced with transistors Q1 through Q4. Here is what it will look like once we are done replacing the mechanical stuff with electronics,

[<img class="aligncenter wp-image-2167 size-full" src="/images/posts/2014/04/H-Bridge.png" alt="DC Motor Drive H Bridge 1" width="600" height="325" srcset="/images/posts/2014/04/H-Bridge.png 600w, /images/posts/2014/04/H-Bridge-300x163.png 300w" sizes="(max-width: 600px) 100vw, 600px" />](/images/posts/2014/04/H-Bridge.png)

The 1k ohmA resistors connected to the base of all the transistors are meant for current limiting. The diodes connected parallel to the transistors are called free-wheeling diodes and are used to prevent the transistors from getting damaged due the back currents (inductive) during switching.

In the above circuit, all the transistors are NPN so they turn on if logic 1 is given to them and are OFF when no logic or logic 0 is given. The drawbacks of this network is that there are 4 IO pins required to drive one motor. A slight variant of this connection is shown below,

[<img class="aligncenter wp-image-2168 size-full" src="/images/posts/2014/04/H-Bridge-2.png" alt="DC Motor Drive H Bridge 2" width="612" height="300" srcset="/images/posts/2014/04/H-Bridge-2.png 612w, /images/posts/2014/04/H-Bridge-2-300x147.png 300w" sizes="(max-width: 612px) 100vw, 612px" />](/images/posts/2014/04/H-Bridge-2.png)

Here two transistor are paired and then used with a single IO pin. Here one of two transistors is PNP so, it need logic 0 to turn ON. So if we were to give Logic one to one pair, then only the lower transistors (NPN) are turned. Similarly a logic 0 will turn on only the upper transistors (PNP). This way we are able to reduce the number of microcontroller pins required to the control the motor. This is the sort of circuit our L293d drivers use.

There is yet another configuration that uses only one pin to control the motor.

[<img class="aligncenter wp-image-2169" src="/images/posts/2014/04/H-Bridge-3.png" alt="DC Motor Drive H Bridge 3" width="605" height="308" srcset="/images/posts/2014/04/H-Bridge-3.png 634w, /images/posts/2014/04/H-Bridge-3-300x153.png 300w" sizes="(max-width: 605px) 100vw, 605px" />](/images/posts/2014/04/H-Bridge-3.png)

This is nothing but the previous connection with a NOT gate connected in betweenA both the inputs. So if logic 0 is given then one pair will get logic 0 and the other will get logic 1. Hence the motor will rotate in one direction for logic 0 and another direction for logic 1.

The obvious disadvantage is that there is no way to stop the motors. All you can do is change the direction of rotation.

**L293 Motor Driver**

Fortunately for you don't have to worry about all the circuits discusses above. There is a discrete IC (L293) that will handle all the electronics internally. The L293 is the most commonly used motor driver in robotics.[<img class="aligncenter wp-image-2213" src="/images/posts/2014/05/l2933.png" alt="DC Motor Drive l293" width="679" height="338" srcset="/images/posts/2014/05/l2933.png 703w, /images/posts/2014/05/l2933-300x149.png 300w, /images/posts/2014/05/l2933-660x330.png 660w" sizes="(max-width: 679px) 100vw, 679px" />](/images/posts/2014/05/l2933.png)

The IC is divided into two channels, one channel contains one motor and its control signals. So one side of the IC (pin 1 to 8) is channel 1 and the other side (pin 9 to 16) is channel 2.A You can see that each side have an enable pin (pins 1 and 9) they are used to turn ON/OFF the control forA that channel.

The pins labelled as Motor +ve and Motor -ve (pins 3,6,11, and 14) is where the motor has to be connected and the Logic A and Logic B (pins 2,7,10, and 15) are where the controlA signal to that particular motor has to be given.

Vcc1 (pin16) is the supply for the IC and should not exceed 5V. Vcc2 (pin 8) is the supply for the motors (high voltage high current supply). The two Vcc are internally isolated. The ground (-ve terminal) of both the supplies (Eg., 5v for IC and 12v for motors) should be connected to the ground pins (pins 4,5,12, and 13).

**Choosing the right motor driver**

As your robot size increases, you will find that you need bulkier motors which draw more current from the supply to carry the payload. L293 can supply up to 1A per channel if your motors draws more current then there is the L298 which can supply upto 2A per channel.

If your motor still needs more current (thats got to be one hell of a motor) then you have to build your own motor driver like the one shown in the circuits above. You might need to replace the transistors in the circuits with suitable (current ratting) MOSFETs.

**Speed Control Techniques**

The speed control of a DC motor is always done by controlling the input supply voltage. There are various methods used to vary the speed of the input voltage such as the potential divider method and the variable resistance method. But those methods a lossy as they linearly cut the current. An effective way to achieve voltage control (thereby speed control) is to use Pulse Width Modulation (PWM).

**Pulse Width Modulation (PWM) Techniques**

In this method, the width of the pulse is varied while the frequency of the pulse train is kept constant. In other words, the ON time of a pulse is varied while a total time period T is maintained constant.[<img class="aligncenter wp-image-2236 size-full" src="/images/posts/2014/05/pwm-tech.png" alt="pulse width modulation technique" width="514" height="268" srcset="/images/posts/2014/05/pwm-tech.png 514w, /images/posts/2014/05/pwm-tech-300x156.png 300w" sizes="(max-width: 514px) 100vw, 514px" />](/images/posts/2014/05/pwm-tech.png)

As the figure illustrates, the width of the pulse has been changed from the first pulse train to the next pulse train. The ration of the ON time to the total time T is called as the duty cycle. Duty cycle is always expressed in percentage or as fraction.

Now that you know what PWM is, lets discuss why we need it and how it can be used to vary the voltage and hence vary the speed of the motor.

**Speed Control with PWM**

When such PWM signals are given to the motors, they are turned ON for some time and turned OFF for some time.A By varying the ON time, we are varying the time of exposure of the supply to the motors. Hence the average voltage supplied is varied.[<img class="aligncenter wp-image-2235 size-full" src="/images/posts/2014/05/pwm.png" alt="pulse width modulation duty cycle" width="510" height="353" srcset="/images/posts/2014/05/pwm.png 510w, /images/posts/2014/05/pwm-300x208.png 300w, /images/posts/2014/05/pwm-110x75.png 110w" sizes="(max-width: 510px) 100vw, 510px" />](/images/posts/2014/05/pwm.png)

So if we give 75% duty cycle, we are givingA 75% of the supply to the load (motor). Similarly, when we give 20% duty, we will be giving only 20% of the total supply to load.

This signal is given to the enable pin of the L293 to control its speed. In case of a MOSFET based drive, this signal is given to the gate terminal of the MOSFET.

In a future post I will explain the generation of PWM with PIC microcontroller and the calculation for producing the desired duty cycle.