---
title: "Implementing Circular/Ring Buffer in Embedded C"
date: 2014-05-16T18:55:54+00:00
date_modified: 2017-04-03T09:37:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /implementing-circular-buffer-embedded-c/
dsq_thread_id: "3290596090"
category: "Programming"
tags: [ "Theory", "Algorithm" ]
---

Embedded software often involves state machines, circular buffers and queues. In this article will give you an overview of the data structure and walks you through the steps involved in implementing circular/ring buffers in low memory devices.

For those of you who don't know what a circular buffer is, it is data structure where in an array is treated as circular and the indices loop back to 0 after it reaches array length. This is done by having two pointers to the array. One points to the "head" and the other points to the "tail" of the buffer. As data is added to the buffer, the head pointer moves up and as the data is being removed (read) the tail pointer moves up. This is implementation dependent and varies with perspective. So, for the sake of argument we will agree, you _write_ at head and read from _tail_.

Here is a nice GIF that [Wikipedia](https://en.wikipedia.org/wiki/Circular_buffer) had,

{% include image.html src="circular-buffer-animation.gif" %}

The picture says it all. The animation is very fast and may take some time iterations of watching the animation before you notice all the cases involved but do spend the time it gives a visual representation of the memory and pointers.

### Full vs Empty

The next big thing about circular buffers is that there is no "clean way" to differentiate the buffer full empty cases. This is because at both cases, head is equal to tail. There are a lot of ways/workarounds to deal with this issue but most of them are not very readable. I am presenting a way that is fairly readable.

In this method, there are two critical cases (boundary conditions) that have to be considered while implementing a circular buffer,

  * Head is equal to tail -> the buffer is empty
  * (Head + 1) is equal to tail -> the buffer is full

The essence is that every time you try to push, you check for `is_buffer_full` condition and every time there is pop, you check for `is_buffer_empty`.

Armed with this knowledge, I will proceed to define the data types!

``` c
typedef struct {
    uint8_t * const buffer;
    int head;
    int tail;
    const int maxLen;
} circBuf_t;
```

There goes our primary structure to handle the buffer and its pointers. Notice that buffer is `uint8_t * const buffer` . `const uint8_t *` is a pointer to a byte array of constant elements, that is the value being pointed to can't be changed but the pointer itself can be. On the other hand `uint8_t * const` is a constant pointer to an array of bytes in which the value being pointed to can changed but the pointer cannot be changed.

This is done so that you will be able to make changes to the buffer but you will not be able to accidentally orphan the pointer. This is a very good safety measure and I strongly suggest you not to skip that part.

In push and pop routines, we will compute the 'next' offset points to the location that the current write-to/read-from will happen. As discussed earlier, if the next location points to the location pointed by the tail then we know that the buffer is full, and we don't write data into the buffer (return an error). Similarly, when the head is equal to tail we know that buffer is empty and nothing can be read from it.

### Push data into the circular buffer

In majority of the use case scenarios, you will be calling this from within an ISR. Hence, a push should be as small and the whole routine should be enclosed withing critical sections to make it synchronized in multi threaded environments.

Data has to be loaded before the head pointer is incremented to ensure that only valid data is read by the consumer thread (one which calls pop. See below).

Also, if you notice, we hold one byte as reserved space in the buffer. On first glance it may appear as an _off by one_ but if you thing about it, you will realize its an engineering trade off. If I were to use that one extra byte, detection of full and empty cases becomes slightly complex and writing code that will handle all corner cases is time consuming and hard to debug if it comes to it.

So, in conclusion, for small and fixed size data units, just reserve one byte while you can still keep your sanity.

``` c
int circBufPush(circBuf_t *c, uint8_t data)
{
    // next is where head will point to after this write.
    int next = c->head + 1;
    if (next >= c->maxLen)
        next = 0;

    if (next == c->tail) // check if circular buffer is full
        return -1;       // and return with an error.

    c->buffer[c->head] = data; // Load data and then move
    c->head = next;            // head to next data offset.
    return 0;  // return success to indicate successful push.
}
```

### Pop data from the circular buffer

Pop routine is called by the application process to pull data off the buffer. This also has to be enclosed in critical sections if more than one threads are reading off this buffer (although thats not how it is usually done)

Here, the tail _can_ be moved to the next offset before the data has been read since each data unit is one byte and we reserve one byte in the buffer when we are fully loaded. But in more advanced circular buffer implementations, data units does not _need_ to be of the same size. In such cases, we don't know how much tail has to be moved before reading the data.

To maintain consistency with such implementations, I will read data and then move the tail pointer.

``` c
int circBufPop(circBuf_t *c, uint8_t *data)
{
    // if the head isn't ahead of the tail, we don't have any characters
    if (c->head == c->tail) // check if circular buffer is empty
        return -1;          // and return with an error

    // next is where tail will point to after this read.
    int next = c->tail + 1;
    if(next >= c->maxLen)
        next = 0;

    *data = c->buffer[c->tail]; // Read data and then move
    c->tail = next;             // tail to next data offset.
    return 0;  // return success to indicate successful push.
}
```

### Usage

I think its pretty obvious that you have to define a buffer of a certain length and then create an instance of `circBuf_t` and assign the pointer to buffer and its `maxLen`.

It also goes without saying that the buffer has to be global or it has to be in stack so long as you need to use it.

To make maintenance a little easier, you could use this macro but compromises code readability for new users.

``` c
#define CIRCBUF_DEF(x,y)          \
    uint8_t x##_dataSpace[y];     \
    circBuf_t x = {               \
        .buffer = x##_dataSpace,      \
        .head = 0,                \
        .tail = 0,                \
        .maxLen = y               \
    }
```

So for example if you need a circular buffer of length 32 bytes, you would do something like this in your application,

``` c
CIRCBUF_DEF(myDatBuf, 32);

void thisIsYourAppCode()
{
    uint8_t outData, inData = 0x55;

    if (circBufPush(&myDatBuf, inData)) {
        DBG("Out of space in CB");
        return;
    }

    if (circBufPop(&myDatBuf, &outData)) {
        DBG("CB is empty");
        return;
    }

    // here outData = inData = 0x55;

    return data;
}
```

I hope this post was of some help in understanding circular buffers. We will see more such data structures and an advanced extensions to this circular buffer types in future posts.
