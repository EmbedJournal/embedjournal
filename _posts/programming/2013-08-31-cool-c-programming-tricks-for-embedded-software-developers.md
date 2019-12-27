---
title: "Cool C Programming Tricks For Embedded Software Developers"
date: 2013-08-31T08:29:27+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /cool-c-programming-tricks-for-embedded-software-developers/
dsq_thread_id: "2728571436"
category: "Programming"
tags: [ "Ideas" ]
---

Proficiency in C is an essential skill set for embedded software developers. In this post we will see some really cool C programming tricks that you should have already known. If you didn't, it's time to take a pen and paper.

Be warned this is just a small collection of routines that will help embedded software developers write better code. Of course I have listed only those that came to my mind while writing this article and I most probably left out something much better. In case something pops up in your head, leave a comment and I will update this post.

> After finishing an intensive, week long, hands-on session on C programming, my teacher said "I have taught you all that is there to know about the syntax in C. This is one of those things that will take days to learn and a lifetime to master. Now it's up to you to practice and perfect".

'_Practice and Perfect_' is the unsaid mantra of C. The more you write, the better you get at it. I'm no professional at C. Hence I will not be writing any posts on C programming as such. There are a lot of resources on the internet and books for learning C.

For learning C from it's very basic, I would suggest [C and UNIX: Tools for Software Design by Martin L. Barrett, Clifford H. Wagner](http://www.amazon.com/C-UNIX-Tools-Software-Design/dp/0471309273) The book covers a lot about C and [using GCC to compile C programs in a Linux](/compiling-c-programs-using-gcc/) machine. Linux is mostly written in C and hence provides a native environment for the language. If you are really interested, you can find some books and links to follow for getting started with Linux [here](/getting-started-with-linux/).

#### Rotate left or right in C

In assembly there are direct instruction for rotate left and rotate right. But in C there is no straight forward method to do so. Here is a snippet that will let you do just that. And the best part is that, PIC C compiler will automatically know what you are trying to do and will replace this line of C with the corresponding assembly instruction.

```c
val = ( (val >> 1) | (val << 7) );
```

The `val << 7` is used as I assumed an 8 bit variable is being rotated. If you were to rotate a 16 bit value , use `val << 15` instead.

#### Bit Set and Bit Clear in Macro

In embedded software applications, we will always will be setting and clearing bits. Some of us feel like using the mask and set/clear strategy each time there is a need to set and clear bits. But when working with 32 bit systems (ARM), it is not practical to write masks each time we need to set/clear a single bit. That's when functions are written to handle this. But having a function will occupy memory. A better alternative for this is to have code macros to take care of this at compile time.

```c
#define BitSet ( var, bitnum ) ( (var) |= 1UL << (bitnum) )
#define BitClr ( var, bitnum ) ( (var) &= ~(1UL << (bitnum) ) )
```

You can use this function in you program like this, BitSet( myVar, 5); this will set bit 5 of myVar. Similarly BitClr(myVar,5); will clear bit 5 of myVar.

#### Bitfields

In embedded systems, most of the time there is a need to access the individual bits of a byte (in 8 bit system) or group of bytes (in a 16 or 32 bit system). One way of doing this is by using the shift operations. The other way is to use the bit fields in C.

The bit field is a lesser known feature of the C programming language (at least to a common user). It comes in handy for low level firmware developers (system software) to have bit level access to the registers. If you take a look at the device specific header file for your favorite microcontroller you will find that most of the code is _structure_ and _union_ definitions much like what is below.

I will take the liberty to assume you have a working knowledge on structures and unions to understand bit fields. The size of a structure is the sum of the size of all its member variables where as in the case of a union, its size is given by the size of its biggest member. Union is used when only either of its member is needed at any time.

```c
typedef union {
        uint8_t data;
        struct {
                uint8_t bit0:1;
                uint8_t bit1:1;
                uint8_t bit2:1;
                uint8_t bit3:1;
                uint8_t bit4:1;
                uint8_t bit5:1;
                uint8_t bit6:1;
                uint8_t bit7:1;
        };
}bitF;
```

Here, you can set the value of data to something and then access each and every bit in the byte by using the variables of the anonymous union bit0 to bit7.

#### Duality of Array names

You should have heard about the duality of light, but duality of array names??

Yes, Array names are not just the label for the group of elements of similar data types. It is also a pointer to the base element of the array. All normal pointer reference and arithmetic to the array label is allowed. But this pointer is a constant pointer and cannot be modified by the user.

ie., if you have an array test\_arr[5] = { 1, 2, 3, 4, 5 }; then test\_arr is a pointer that has the address of the first element of the array. So a difference like, \*test\_arr will return 1 and \*(test\_arr+2) will return 3.

#### Interoperability of array index

In C, if you had an array `int arr[5];` you could access it with an index 'i' and assign values to it. That is you can write `arr[i] = 7;`

Turns out you could swap the array names and array index. That means you could write the same statement as `i[arr] = j;`  and its perfectly valid C code.

#### Passing an array to functions and returning them

Arrays are one of the best way to store elements of similar datatypes. The elements are stored in sequential memory blocks hence making pointer operations possible. In fact it would have been useless to have pointer arithmetic without having arrays.

Single variables can be passed directly to a function as a parameter. But in case of an array, the pointer to the first element is sent to the receiving function. This pointer is used to navigate the array.

When a flow of control reaches the end of a function, the variables created in that function are destroyed and no longer accessible. So returning an array from a function is not possible. There are two ways for tackling this issue.

One way is by using a globally declared array and let the functions make use of this array. But using globally declared arrays is not always possible and is not a good practice. There comes the second and better alternative, while calling a function give it the pointer of the array defined in the calling function. This way, the array is not declared globally and still is available for the calling function locally.

Not clear? consider this case, 2 arrays have to be added in a separate function and store them in another array. Here is how you can do this,

```c
int main()
{
    int arr1[5] = { 1, 4, 5, 7, 9 };    // Array No 1
    int arr2[5] = { 4, 7, 2, 1, 8 };    // Array No 2
    int res[5] = {0};                   // Resultant Array
    int i;                              // loop variable

    add(arr1,arr2,res);     // call to func add with all there arrays
    for (i=0; i<5; i++)     // this loops runs 5 times
        printf("Elelmetn %d is %d\n",i,*(res+i));   //Prints the resultant array
    return 0;
}

void add(int *arr1, int *arr2, int *res)
{
    int i;                  // Loop varuable
    for (i=0; i<5; i++)     // 5 times again
        *(res+i) = *(arr1+i) + *(arr2+i);   // Adds the two arryas and sotes the
    // result in the res array. Note: loop index is added to the pointer everytime
}
```

#### What did I miss?

Have I missed anything that you feel is a really neat trick? In what way does it improve the coding efficiency of an embedded engineer? Let's start the discussion in the comment section.

**Update #1: Paolopat said,**

Sometimes I have to swap two variables.

You can avoid using a temporary variable using an EXOR swap like following :

```c
a = a ^ b
b = a ^ b
a = a ^ b
```

Wow, that is a really cool trick! You can now swap variables without using the conventional `temp = a; a = b; b = temp;`. As vijay pointed out, you could also do it in one line as, `a ^= b ^= a ^= b;` which looks sleek but is rather cryptic.
