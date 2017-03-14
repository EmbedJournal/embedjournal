---
title: Programming Shortest Path Line Follower Robot
date: 2013-07-06T13:05:15+00:00
author: Siddharth
layout: post
permalink: /programming-shortest-path-line-follower-robot/
dsq_thread_id: "2701844078"
categories: [ "Robotics" ]
tags: [ "Algorithm", "Programming" ]
---

This post is the programming section of my previous post <a title="Shortest Path Line Follower Robot Logic Revealed!" href="http://embedjournal.com/2013/06/shortest-path-line-follower-robot-logic-revealed/" target="_blank">Shortest Path Line Follower Robot Logic Revealed!</a> A that dealt with the logic behind the following routines. To understand the complete nature of this post you should read that post first and then continue with this one.

No, this is not the entire code! even if the title reads <span style="color: #993300;">Programming Shortest Path Line Follower Robot</span> :-).

This by no means is the entire code for the shortest path detection robot. But listed below are some functions that constitute major parts of the code. I was developing the code to kill time and I have not yet tested it. But the logic by-far is correct and may contain a few bugs.

If you are making this robot and following the algorithm explained in my previousA <a title="Shortest Path Line Follower Robot Logic Revealed!" href="http://embedjournal.com/2013/06/shortest-path-line-follower-robot-logic-revealed/" target="_blank">post</a>, you will find these functions handy.

#### Sensor Arrangement:

The <a title="Line Follower Robot aEUR" Build it from scratch" href="http://embedjournal.com/2013/06/line-follower-robot/" target="_blank">balckboy</a>, has 8 sensors mounted on the base plate to provide it with the ability to follow any type of line with just some minor modifications in the programming section without having to touch the hardware. There are two other sensors for encoding the wheels of the robot, but for now our concern is only the line follower.

In the code I use C macros to address these sensors without any confusion. Here is what I have defined,

<pre lang="c">#define RR  PORTDbits.RD5
#define R   PORTDbits.RD0
#define SR  PORTDbits.RD1
#define SM  PORTDbits.RD2
#define SL  PORTDbits.RD3
#define L   PORTDbits.RD4
#define LL  PORTDbits.RD6
#define CC  PORTDbits.RD7</pre>

Here is an Image to show the physical location of these senors on the base plate of the robot. For understanding the code snippets to come, you will need this as a reference to see which sensor we are talking about.

<div id='gallery-9' class='gallery galleryid-1095 gallery-columns-2 gallery-size-thumbnail'>
  <figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/programming-shortest-path-line-follower-robot/dsc09196/'><img width="150" height="150" src="/images/posts/2013/07/DSC09196-150x150.jpg" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-9-1122" /></a>
  </div><figcaption class='wp-caption-text gallery-caption' id='gallery-9-1122'> Back side of the bot </figcaption></figure><figure class='gallery-item'> 
  
  <div class='gallery-icon landscape'>
    <a href='http://embedjournal.com/programming-shortest-path-line-follower-robot/sensor/'><img width="150" height="150" src="/images/posts/2013/07/sensor-150x150.png" class="attachment-thumbnail size-thumbnail" alt="sensor arrangement" aria-describedby="gallery-9-1113" /></a>
  </div><figcaption class='wp-caption-text gallery-caption' id='gallery-9-1113'> Sensor Code Macro Arrangement </figcaption></figure>
</div>

 

#### Check for a bend or node:

In the theory section, I had give a clear definition of a bend and turn (node) do I will not rehash it here. This function is used to determine if a junction met my the robot is a node or a normal bend. If it is a node, it returns 1 and if it is a turn it returns 0. There is also another purpose this function solves. It also detects the end of track maker denoted by the return of 2 to the calling function.

<pre lang="c">unsigned char check(void)
{
    LATC = FRONT;
    while(RR == 0 || LL == 0);
    LATC = STOP;
    if (L == 1 && SL == 1 && SM == 1 && SR == 1 && R == 1)
        return 0;
    if (L == 0 && SL == 0 && SM == 0 && SR == 0 && R == 0)
        return 2;
    if (L ==0 || SL == 0 || SM == 0 || SR == 0 || R == 0)
        return 1;
}</pre>

#### Update Direction Array:

This function is used update the direction array with the new direction after the robot has made a turn in some direction. This function expects the calling function to send a mode selection value based on the last turn it made. Initially it is assumed that the robot is facing North and with respect to this North the other relative directions are derived.

<pre>/*
 * Table of Action for dir_arr[50];
 * 1 - North
 * 2 - West
 * 3 - South
 * 4 - East
 */</pre>

If the robot made a normal single step turn to left or right then 1 is passed. If the robot makes a U turn (which is a 2 step turn) at a particular point then it has to send 2 to this function so that it is able to update the direction accordingly. The logic is such that, if it is a normal single step turn, then the next value of the dir\_arr is one more than the previous value. On the other hand if it is a U-turn, then the next value of the dir\_arr is two more than the previous value. In both the cases, the total sum should not exceed 4 so the answer is modulo 4-ed to get a circular buffer.

<pre>void update_direction(unsigned char i)
{
    //static unsigned char idx = 1;
    if (i == 1)                                    // If it is a L-Turn
        dir_arr[idx++] = ((dir_arr[(idx-1)])+1)%4; // %4 is used to wrap back to 1
    else if (i==2)                                 // If it is a U-Turn
        dir_arr[idx++] = ((dir_arr[(idx-1)])+2)%4; // %4 is used to wrap back to 1
}</pre>

#### Identify the redundant tracks:

This function is used used to identify two consecutive the opposite directions in the dir_arr array and replace them with an arbitrary value (say 50) so that it can be removed as an useless path traversed by the robot. A I traverse the entire array searching for such opposite directions and increments a counter variable for monitoring if there has been atleast one replace of data. This counter is then used to terminate the call to the remove() function.

<pre>void sort(void)
{
    unsigned char * index = dir_arr;    //local copy of direction array
    unsigned char v1 = 0,i,ctr=0;
    unsigned char *tmp = index;     // another copy
    while (tmp++) v1++;     // measure the size of dir array
    for (i = 0; i<v1; i++)     
    {
        /* if current_element+2 = Next_element */
        if(((*(index+i))+2)%4 == *((index+i)+1))         
            {             
                *(index+i) == 50;   //some value             
                *((index+i)+1) == 50;   //some value             
                ctr++;  // termination variable.         
           }     
    }     
    if(ctr>0)   //as long as counter is > zero keep sorting.
        remove();
}</pre>

#### Remove the identified values:

The remove() function is used to remove the consecutive equal elements in the sorted array. The remove() function calls the sort function again. This process is recursive and has to be terminated by the the sort() function if there is no more sorting to be done. This is monitored by the loop counter ctr. If the counter is never incremented, then in the last pass there wasn't anything to sort which means that all the passes are over and the array has the shortest path stored in it.

<pre>void remove(void)
{
    unsigned char arr[50] = {0};
    unsigned char i,j=0;
    for (i=0;i<50;i++)
        /*if the array value is not 50 then it is valid*/
        if (!(dir_arr[i] == 50))
            arr[j++] == dir_arr[i]; //so copy it in new array.
    for (i=0;i<50;i++)
        dir_arr[i] == arr[i];
    /*recursivly call the sort() function till there is nothing to left sort*/
    sort();  
}</pre>

### Reverse the direction form destination to source:

Since our objective is to make the robot come back to the source node from the destination node choosing the shortest path, we have to rearrange the dir_arr array such that the each of the directions are reversed. That is North becomes South and South becomes North and vice-verse. A Also the total arrya has to be flipped; as in, n<sup>th</sup> element become the 1<sup>st</sup> element and so on.

<pre lang="c">void dir_rev(void)
{
    int idx = 0;
    unsigned char *tmp = dir_arr;
    unsigned char val,i;
    unsigned char temp[50] = {0};

    for (;idx<50;idx++)
        dir_arr[idx] = (dir_arr[idx]+2)%4;  // reverse the directions

    while(tmp++) val++;     // get the size of array.
    for(i=0;i<val;i++)
        temp[i] = dir_arr[val-i];    //temporrary array to hold the revesed array
    for(i=0;i<val;i++)
        dir_arr[i] = temp[i];    // write it back to the dir array
}</pre>

**Wrapping Up,A **these are the functions that I have developed so far. Beyond this there is just the structuring of the program and testing the logic once the entire code is ready. There also has to be a hardware test (toughest of the lot) and of course the documentation section of the robot in action.