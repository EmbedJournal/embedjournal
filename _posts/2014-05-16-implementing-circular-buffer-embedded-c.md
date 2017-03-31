---
title: Implementing Circular/Ring Buffer in Embedded C
date: 2014-05-16T18:55:54+00:00
author: Siddharth
thumbnail: post-thumb.png
permalink: /implementing-circular-buffer-embedded-c/
dsq_thread_id: "3290596090"
categories: [ "Programming" ]
tags: [ "Theory", "Algorithms" ]
---

Most embedded programmers come to realize that majority of the code that they write in a day are either related to state machines or circular buffers or queues. In this article we will have a look at circular buffers and how you can implement them in low memory devices.

For those of you who don't know what a circular buffer is, its a kind of an array that will loop back to 0 after it reaches the maximum number of bytes in the buffer. This is done by having two pointers to the array. One points to the "head" and the other points to the "tail" of the buffer. As data is added to the buffer, the head pointer moves up and as the data is being removed (read) the tail pointer moves up. This is implementation dependent and varies with perspective. So, for the sake of argument we will agree, **you write at head and read from tail**.

The next big thing about circular buffers is that there is no "clean way" to differentiate the buffer full and buffer empty cases. This is because at both cases, head is equal to tail. There are a lot of ways/workarounds to deal with this issue but most of them are not very readable. I am presenting a way that is fairly readable.

In this method, there are two critical cases (boundary conditions) that have to be considered while implementing a circular buffer,

  * Head is equal to tail -> the buffer is empty
  * (Head + 1) is equal to tail -> the buffer is full

The essence is that every time you try to push, you check for "is-buffer-full" condition and every time there is pop, you check for "is-buffer-empty". Armed with this knowledge, I will proceed to define the data types!

``` c
typedef struct
{
	uint8_t * const buffer;
	int head;
	int tail;
	const int maxLen;
}circBuf_t;
```

There goes our primary structure to handle the buffer and its pointers. Notice that buffer is `uint8_t * const buffer` . `const uint8_t *` is a pointer to a `const uint8_t` , the value being pointed to can't be changed but the pointer can be. On the other hand `uint8_t * const` is a constant pointer to a `uint8_t`A the value being pointed to can changed but the pointer can't.

This is done so that you will be able to make changes to the buffer but you will not be able to accidentally orphan the pointer. This is a very good safety measure and I strongly suggest you not to skip that part.

``` c
int circBufPush(circBuf_t *c, uint8_t data)
{
	int next = c->head + 1;
	if (next >= c->maxLen)
		next = 0;

	// Cicular buffer is full
	if (next == c->tail)
		return -1;  // quit with an error

	c->buffer[c->head] = data;
	c->head = next;
	return 0;
}

int circBufPop(circBuf_t *c, uint8_t *data)
{
	// if the head isn't ahead of the tail, we don't have any characters
	if (c->head == c->tail)
		return -1;  // quit with an error

	*data = c->buffer[c->tail];
	c->buffer[c->tail] = 0;  // clear the data (optional)

	int next = c->tail + 1;
	if(next >= c->maxLen)
		next = 0;

	c->tail = next;

	return 0;
}
```

The variable 'next' in the functions will point to the location that the successive call to the routines will write-to/read-from. As discussed earlier, if the next location points to the location pointed by the tail then we know that the buffer is full so we don't write the new data into the buffer (return -1). Depending on the operation push/pop if there is space/data in the buffer, we will append/remove that data and move the head/tail pointer to the location pointed by the 'next' variable.

### How use it?

I think its pretty obvious. You have to define a buffer of a certain length and then create an instance of `circBuf_t` and assign the pointer to buffer and its max len. It goes without saying that the buffer has to be global (in most cases) or it has to be in stack so long as you need to use it if you prefer it be local.

To make life a little easier I wrote a macro that will make this look a lot better.

``` c
#define CIRCBUF_DEF(x,y) uint8_t x##_space[y]; circBuf_t x = { x##_space,0,0,y}
```

So for example if you need a circular buffer of length 32 bytes, you would do something like this in your application,

``` c
CIRCBUF_DEF(cb, 32);

uint8_t thisIsYourAppCode(uint8_t data)
{
	...
	some code..
	...
	if (circBufPush(&cb, data)) {
            DBG("Out of space in CB");
        }
	...
	some code..
	...
	if (circBufPop(&cb, &data)) {
            DBG("CB is empty");
        }
        ... some code.. ... 
        return data; 
}
```

I hope this post was of some help in understanding circular buffers. We will see more such data structures in the future.

**Update (2o Sep 2015):**

I think some of you might have guessed the drawback of this method. Yes we use only `maxLen - 1` space of the buffer. That is we never actually completely use the space. That is one element is wasted all the time. Some of you might have mistaken it for a off-by-one but trust me its not. I feel it is a very necessary evil for data units less than or equal to size of pointer.

I will take this up a separate discussion. Hope fully you should find it here soon.
