---
title: Shortest Path Line Follower Robot Logic Revealed!
date: 2013-06-08T18:24:42+00:00
author: Siddharth
layout: post
permalink: /shortest-path-line-follower-robot-logic-revealed/
dsq_thread_id: "3290567661"
categories: [ "Robotics" ]
tags: [ "Algorithm", "Basics", "Theory" ]
---

Bored of the conventional line follower? People nearby are losing interest? Here is a post that could change it all and turn the winds to your side.

Imagine if you robot was to start from node A (source) and move to node B (destination) and and come back to node A! Hmm... not so great.. what if your robot could figure out the shortest path from source node the destination node and the returns to the source node choosing the shortest path?? Now won't that be one hell of a robot? That is where the post will will get you to.

For this tutorial, I assume you have already read my previous posts on the <a title="Line Follower Robot aEUR" Build it from scratch" href="http://embedjournal.com/2013/06/line-follower-robot/" target="_blank">line follower robot</a> and <a title="Programming a Line Follower Robot" href="http://embedjournal.com/2013/06/programming-line-follower-robot/" target="_blank">how to program it</a>. If you haven't I suggest you give them both a short glance to get a grip of things.

Honestly I don't believe in spoiling all the fun for you. If you are a diehard thinker stop here and figure out your own logic Then you can come back here and see if this was the method you thought of. If it matches great! your victorious. If it didn't then post your method here in the comment section below. Who knows your logic might be better then mine.

For the sake of those who have tried and given up on the verge of success, I will post my method (or the method I could think off) here. Again, I must remind you this is probably not the best way to do it. If you know some method that is more optimized, be helpful by sharing it with others.

Now back to the task at hand, let us consider a track with one start and one end point. Also let us have a lot of intersections in the lines to produce decision making points for the robot. So this is how the track should look like,

<p style="text-align: center;">
  <a href="/images/posts/2013/06/Shortest-track.png"><img class="aligncenter  wp-image-458" src="/images/posts/2013/06/Shortest-track.png" alt="Shortest path track" width="484" height="317" srcset="/images/posts/2013/06/Shortest-track.png 807w, /images/posts/2013/06/Shortest-track-300x197.png 300w" sizes="(max-width: 484px) 100vw, 484px" /></a>
</p>

Assume the square box as the start point and the circular patch as the end pint of the track. I'm sure you would have figured out the shortest path from the source to the destination; thanks to all the games we have played in magazines dYtm, Besides, this is a fairly simple maze compared to the ones we get in Young World. I have posted the shortest path solution for your confirmation.

<p style="text-align: center;">
  <a href="/images/posts/2013/06/Shortest.png"><img class="aligncenter  wp-image-459" src="/images/posts/2013/06/Shortest.png" alt="shortest path" width="514" height="329" srcset="/images/posts/2013/06/Shortest.png 856w, /images/posts/2013/06/Shortest-300x192.png 300w" sizes="(max-width: 514px) 100vw, 514px" /></a>
</p>

The point is that you robot should be able to do that for not just this track but for every goddamn track a human mind can think of. One more thing I have mentioned earlier is that the track should have no loops in it. If your track has a loop then you have to add more logic and as usual to keep things simple I will just stick on the main stream of the concept.

Before we go any further in this discussion, there are two methods by which you robot can solve this track. They are the default left and default left algorithm. The name may sound fancy but it just mean that the robot has to make a left turn at every junction where the left turn is possible. Otherwise it does not make any turn at all. The default right also the same only that you robot will take all rights.

<div id='gallery-5' class='gallery galleryid-378 gallery-columns-2 gallery-size-thumbnail'>
  <figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/06/Default-Right.png'><img width="150" height="150" src="/images/posts/2013/06/Default-Right-150x150.png" class="attachment-thumbnail size-thumbnail" alt="Shortest path DR" /></a>
  </div></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='/images/posts/2013/06/Default-Left.png'><img width="150" height="150" src="/images/posts/2013/06/Default-Left-150x150.png" class="attachment-thumbnail size-thumbnail" alt="shortest path DL" /></a>
  </div></figure>
</div>

For any given track that is make with the assumption we have made so far, either of the algorithm will always lead the robot to the destination node. The time take may vary but it's a mathematical certainty that it will succeed in reaching the destination. The above image is the pictorial representation Default left algorithm.

The secret behind the shortest path algorithm, is to teach your robot which node to remember and which to neglect. Whenever the robot comes to a position where it has to make a decision on the direction, let us assume that the point is a node. Some of these nodes are worth remembering and some are not.A Next aspect to be clear of is the difference between a turn and a node. It plays a vital role in deciding the points to remember in a given track.

#### **Turn:**

A turn is when the robot has no other option other than making a turn. These turns may be considered as a straight line as that is the obvious path the robot has to take.

#### **Node:**

A node is when it has more than one options on direction change. A node is the point where more than one lines intersects.

### **Points to Remember:**

Every time the robot faces a node, it has to make an entry into the direction array. It also has to make an entry each time it comes to a dead end.A The image below shows the point to remember in default left (red dots) and default right (yellow) algorithms.
  
To understand this better, for default left algorithm, follow the dots on the left side of the track from the starting node to the destination node. And similarly for default right follow the right side dots. These dots indicates the positions when the robot will make an entry into the direction register.

<p style="text-align: center;">
  <a href="/images/posts/2013/06/Shortest-path-points.png"><img class="aligncenter  wp-image-473" src="/images/posts/2013/06/Shortest-path-points.png" alt="Shortest path points" width="483" height="314" srcset="/images/posts/2013/06/Shortest-path-points.png 805w, /images/posts/2013/06/Shortest-path-points-300x195.png 300w" sizes="(max-width: 483px) 100vw, 483px" /></a>
</p>

Let's make some more assumptions,

  1. North - up
  2. East - right
  3. South - down
  4. West - left

Your program is going to keep track of the serial numbers (direction index) of the above assumptions only; the directions are for your understanding. When ever your robot encounters a node, (point to remember) it has to make an entry of one of these direction index into the direction array.

In default left algorithm, you have to decrement the direction index of the previous node to get the direction index of the present node. And in default right algorithm you have to increment the direction index of the previous node to get the direction index of the present node.A It might not be very clear at this point keep reading...

Also the increment and decrement has to be done in a circular manner. That is, if you increment 4 it should wrap back to 1 and similarly if you decrement 1 it should become to 4.

**The Algorithm:**

The procedure for default left algorithmA is as follows,

  * Consider the robot is facing north at start always.
  * When the robot encounters the first node, mark its direction with respect to the assumed initial direction North. In this case it has to go straight in the first node. So it going North with respect to the assumed North (since no direction change).
  * After this, each time the robot meets a node, decrement the pointer once and store the result in the consecutive array indexes.
  * And each time the robot meets a dead end (180 degree turn), decrement the pointer twice and store the result in the consecutive array indexes.

The procedure for default right algorithmA is as follows,

  * Consider the robot is facing north at start always.
  * When the robot encounters the first node, mark its direction with respect to the assumed initial direction North. In this case it has to make a right turn. Then it is moving East with respect to the assumed North.
  * After this, each time the robot meets a node, increment the pointer once and store the result in the consecutive array indexes.
  * And each time the robot meets a dead end (180 degree turn), increment the pointer twice and store the result in the consecutive array indexes.

By following algorithm,A you should have a direction array like this,

<span style="color: #000000;"><code>For default left algorithm:<br />
dir_arr[20] = { 1 , 1 , 3 , 2 , 1 , 3 , 2 , 4 , 3 , 1 , 4 , 3 , 2 , 2 , 2 };</code></span>

which is -> [North , NorthA , South , East , North , South , East , West , South , North , West , South , East , East , East] 

<span style="color: #000000;"><code>For default right algorithm:<br />
dir_arr[20] = { 2 , 3 , 1 , 2 , 4 , 1 , 2 , 3 , 4 , 2 , 4 , 1 , 2 }</code></span>

which is -> [East , South , North , East , West , North , East , South , West , East , West , North , East] 

This is the values that I have calculated after following the above algorithm. Cross check this with your own answer to be sure. This is the heart of the algorithm so, this logic should not be flawed.

Once the robot reached the destination, the dir_arr should be processed to calculate the shortest path. This is the most trickiest part of the method. For understanding I will use direction labels instead of direction index.

If there is a South followed by North or vice-verse, then it is a redundant movement and has to be removed. Similarly if there is a East followed by a West or vice-verse, then it also redundant. In the first pass, clear all such pairs in the array. So your array should look like this after the first pass, In all cases the first element is persistent even if it has to be canceled.

**Default Left Algorithm Reduction:**

Initial -> [North , North , South , East , North , South , East , West , South , North , West , South , East] 

1st Pass -> [North ,A <span style="background-color: #60ee10;">North , South</span> , East , <span style="background-color: #60ee10;">North , South</span> , <span style="background-color: #60ee10;">East , West</span> , <span style="background-color: #60ee10;">South , North</span> , West , South , East , East , East] 

After 1st Pass -> [ North , East , West , South , East , East , EastA ] 

2nd Pass - >A [ North , <span style="background-color: #7fdd22;">East , West</span> , South , East , East , EastA ] 

After 2nd Pass ->A [ North , South , East , East , EastA ] 

3rd Pass ->A A [ <span style="background-color: #7fdd22;">North , South</span> , East , East , EastA ] 

After 3rd Pass ->A [ East , East , EastA ] 

After the third pass there is no more possible reduction, Hence the passes stops here. The final output array contains the shortest path that the robot has to take to reach the destination. So at every node the robot has to read value of the array and make direction decisions according to the direction index. Same logic can be followed for the default right algorithm.

#### This is not what we planed to do right?

Our robot has to go to the destination node and come BACK to the source node in the shortest path. To do this we have to make a few changes in the direction array.

In order to change the direction of the robot, we have the reverse the elements of the array. so 0<sup>th</sup> element becomes nth element and and n<sup>th</sup> element has to become 0th element and so on.

We are not there yet! The directions are reversed but the directions they point to are not reversed. So we have to replace each direction symbol by its opposite direction symbol. That is, North will become South and East will become West and so on.

Once all these processing has been done the reversed direction array will look like this,

<span style="color: #000000;"><code>dir_arr[20] = { 4 , 4 , 4 };</code></span>

which is -> [ West , West , West ] 

There you go! The shortest path algorithm is revealed. Now all you have to do is to think of how we can implement this logic in C and how to structure the code in such a way that while going from the source to the destination node the robot has to fill the array and while coming back it has to use the same array (or different its your wish but embedded Engineers aren't always given that option... most of the time the controller has a dearth in available memory)

I hope this post was, to-an-extent helpful. Let me know if there is any confusions in the concept explained above. I will follow up this post with the [programming section the shortest path Line Follower](http://embedjournal.com/2013/07/programming-shortest-path-line-follower-robot/ "Update: This post is now Available") Robot.