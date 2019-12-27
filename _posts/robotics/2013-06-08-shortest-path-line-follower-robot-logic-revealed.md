---
title: Shortest Path Line Follower Robot Logic Revealed!
date: 2013-06-08T18:24:42+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /shortest-path-line-follower-robot-logic-revealed/
dsq_thread_id: "3290567661"
category: "Robotics"
tags: [ "Algorithm", "Basics", "Theory" ]
---

Bored of the conventional line follower? People nearly are losing interest? Here is a post that could change it all and turn the winds to your side.

Imagine if your robot was to start from node A (source) and move to node B (destination) and come back to node A! Hmm... not so great.. what if your robot could figure out the shortest path from source node to the destination node and then returns to the source node choosing the shortest path?? Now won't that be one hell of a robot? That is where this post will get you to.

For this tutorial, I assume you have already read my previous posts on the [line follower robot](/line-follower-robot/) and [how to program it](/programming-line-follower-robot/). If you haven't, I suggest you give them both a short glance to get a grip of things.

Honestly I don't believe in spoiling all the fun for you. If you are a die-hard thinker stop here and figure out your own logic. Then you can come back here and see if this was the method you thought of. If it matches great! You are victorious. If it didn't then post your method here in the comment section below. Who knows your logic might be better then mine.

For the sake of those who have tried and given up on the verge of success, I will post my method (or the method I could think off) here. Again, I must remind you this is probably not the best way to do it. If you know some method that is more optimized, be helpful by sharing it with others.

Now back to the task at hand, let us consider a track with one start and one end point. Also let us have a lot of intersections in the lines to produce decision making points for the robot. So this is how the track should look like,

{% include image.html src="shortest-track.png" %}

Assume the square box as the START point and the circular patch as the END point of the track. I'm sure you would have figured out the shortest path from the source to the destination; thanks to all the games we have played in magazines. Besides, this is a fairly simple maze compared to the ones we get in the Young World. I have posted the shortest path solution for your confirmation.

{% include image.html src="Shortest-path-solution.png" %}

The point is that your robot should be able to do that for not just this track but for every track, a human mind can think of. One more thing I have mentioned earlier is that the track should have no loops in it. If your track has a loop then you have to add more logic and as usual to keep things simple I will just stick to the main stream concept.

Before we go any further in this discussion, there are two methods by which your robot can solve this track. They are the default left and default left algorithm. The name may sound fancy but it just mean that the robot has to make a left turn at every junction where the left turn is possible. Otherwise it does not make any turn at all. The default right is also the same, only that your robot will take all rights.

**Default Left:**

{% include image.html src="shortest-path-default-left.png" %}

**Default Right:**

{% include image.html src="shortest-path-default-right.png" %}

For any given track that is making the assumption we have made so far, either of the algorithm will always lead the robot to the destination node. The time take may vary but it's a mathematical certainty that it will succeed in reaching the destination. The above image is the pictorial representation of the Default left algorithm.

The secret behind the shortest path algorithm, is to teach your robot which node it has to remember and which to neglect. Whenever the robot comes to a position where it has to make a decision on the direction, let us assume that the point is a node. Some of these nodes are worth remembering and some are not. Next aspect to be clear of is the difference between a turn and a node. It plays a vital role in deciding the points to remember in a given track.

#### Turn:

A turn is when the robot has no other option other than making a turn. These turns may be considered as a straight line as that is the obvious path the robot has to take.

#### Node:

A node is when it has more than one options on direction change. A node is the point where more than one lines intersects.

### Points to Remember:

Every time the robot faces a node, it has to make an entry into the direction array. It also has to make an entry each time it comes to a dead end. The image below shows the point to remember in default left (red dots) and default right (yellow) algorithms.
  
To understand this better, for default left algorithm, follow the dots on the left side of the track from the starting node to the destination node. And similarly for default right follow the dots on the right side. These dots indicates the positions when the robot will make an entry into the direction register.

{% include image.html src="shortest-path-points.png" %}

Let's make some more assumptions,

  1. North - up
  2. East - right
  3. South - down
  4. West - left

Your program is going to keep track of the serial numbers (direction index) of the above assumptions only; the directions are for your understanding. When ever your robot encounters a node, (point to remember) it has to make an entry of one of these direction index into the direction array.

In default left algorithm, you have to decrement the direction index of the previous node to get the direction index of the present node. And in default right algorithm you have to increment the direction index of the previous node to get the direction index of the present node. It might not be very clear at this point keep reading...

Also the increment and decrement has to be done in a circular manner. That is, if you increment 4 it should wrap back to 1 and similarly if you decrement 1 it should become to 4.

**The Algorithm:**

The procedure for default left algorithm is as follows,

  * Consider the robot is facing north at start always.
  * When the robot encounters the first node, mark its direction with respect to the assumed initial direction North. In this case it has to go straight in the first node. So it is going North with respect to the assumed North (since no direction change).
  * After this, each time the robot meets a node, decrement the pointer once and store the result in the consecutive array indices.
  * And each time the robot meets a dead end (180 degree turn), decrement the pointer twice and store the result in the consecutive array indices.

The procedure for default right algorithm is as follows,

  * Consider the robot is facing north at start always.
  * When the robot encounters the first node, mark its direction with respect to the assumed initial direction North. In this case it has to make a right turn. Then it is moving East with respect to the assumed North.
  * After this, each time the robot meets a node, increment the pointer once and store the result in the consecutive array indices.
  * And each time the robot meets a dead end (180 degree turn), increment the pointer twice and store the result in the consecutive array indices.

By following algorithm, you should have a direction array like this,

```c
// For default left algorithm:
dir_arr[20] = { 1 , 1 , 3 , 2 , 1 , 3 , 2 , 4 , 3 , 1 , 4 , 3 , 2 , 2 , 2 };
```

which is -> [North , North , South , East , North , South , East , West , South , North , West , South , East , East , East] 

```c
// For default right algorithm:
dir_arr[20] = { 2 , 3 , 1 , 2 , 4 , 1 , 2 , 3 , 4 , 2 , 4 , 1 , 2 };
```

which is -> [East , South , North , East , West , North , East , South , West , East , West , North , East] 

This is the values that I have calculated after following the above algorithm. Cross check this with your own answer to be sure. This is the heart of the algorithm so, this logic should not be flawed.

Once the robot reached the destination, the dir_arr should be processed to calculate the shortest path. This is the most trickiest part of the method. For understanding I will use direction labels instead of direction index.

If there is a South followed by North or vice-verse, then it is a redundant movement and has to be removed. Similarly if there is a East followed by a West or vice-verse, then it also redundant. In the first pass, clear all such pairs in the array. So your array should look like this after the first pass, In all cases the first element is persistent even if it has to be canceled.

**Default Left Algorithm Reduction:**

Initially, lest assume the direction array to be,

```text
// Initial state.
[ North, North, South, East, North, South, East, West, South, North, West, South, East] 
```

In the 1st pass, we group and remove the following,

```text
// Pass one
Before = [ North, (North, South), East, (North, South), (East, West), (South, North), West, South, East, East, East ]
After  = [ North, East, West, South, East, East, East ]
```

Similarly, we group and remove another from the resultant of previous reduction.

```text
// Pass two
Before = [ North, (East, West), South, East, East, East ] 
After  = [ North, South, East, East, East ] 
```

Finally, there is just one more thing we can remove,

```text
// Pass three.
Before = [ (North, South), East, East, East ] 
After  = [ East , East , East ]
```

After the third pass there is no more possible reduction, Hence the passes stops here. The final output array contains the shortest path that the robot has to take to reach the destination. So at every node the robot has to read value of the array and make direction decisions according to the direction index. Same logic can be followed for the default right algorithm.

#### This is not what we planed to do right?

Our robot has to go to the destination node and come BACK to the source node in the shortest path. To do this we have to make a few changes in the direction array.

In order to change the direction of the robot, we have the reverse the elements of the array. so 0<sup>th</sup> element becomes nth element and and n<sup>th</sup> element has to become 0th element and so on.

We are not there yet! The directions are reversed but the directions they point to are not reversed. So we have to replace each direction symbol by its opposite direction symbol. That is, North will become South and East will become West and so on.

Once all these processing has been done the reversed direction array will have, `{ 4 , 4 , 4 }` which is `[ West , West , West ]` in our convention.

There you go! The shortest path algorithm is revealed. Now all you have to do is to think of how we can implement this logic in C and how to structure the code in such a way that while going from the source to the destination node the robot has to fill the array and while coming back it has to use the same array (or different its your wish but embedded Engineers aren't always given that option... most of the time the controller has a dearth in available memory)

I hope this post was helpful. Let me know if there are any confusions in the concept explained above. I will follow up this post with the [programming section the shortest path Line Follower](/programming-shortest-path-line-follower-robot/) Robot.
