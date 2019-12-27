---
title: "Memory Leak - Analysis and Detection Strategies"
date: 2017-07-09T19:55:54+0530
author: Siddharth
permalink: /memory-leak-analysis-detection-strategies/
dsq_thread_id: "noha9byxov"
category: "Programming"
tags: [ "Theory", "Ideas" ]
---

The first thing that comes to mind when we talk about dynamic memory and leaks is Valgrind. You may also be familiar with static analysis tools, such as Coverity. It could be DevPartner or Boundschecker or many such tools that I won't dare attempt to list here.

But what if such tools are _NOT_ an option?

{% include toc.html %}

This is not as remote as it appears at first glance. Coverity is not open source, ergo not at your disposal when you really need it. Valgrind may not have been ported on to your target platform or there may not be enough space&mdash;in a near production product&mdash;left to add a beast like Valgrind.

For all you know, it could just be that your delivery time lines are too rigid to accommodate the time taken to setup the necessary test bed to do a full scale memory analysis. This is particularly likely in memory leaks; they have a nasty habit of surfacing during the last minute when longevity test are conducted.

Nonetheless, it helps to understand what makes a leak, a leak. Even if you are using a tool, you need to understand how to discern the meaning of the logs they spit out (you are right, they don't scream: there's your leak go fix it!) and spot a leak, in an endless list of false positives.

Broad Categories of Memory Leaks
--------------------------------

For most practical situations, you will be facing a deterministic, reproducible leak in one or more processes resulting in inflation of total used memory and eventually system failure due to starvation. We will get to that in a bit. But for now, let's take a look at the board categories of the memory leak bugs.

Obviously, there are a lot of other remote places where a memory leak can happen too. The goal here is to be aware of most commonly occurring patterns (low hanging fruits) for a rainy day.

### Early returns

This is perhaps the single most common type of leak that I have come across. The cause is pretty simple, code changes that introduce a return statement made by ignorant maintenance programmers. Generally, the software written by a programmer with full context in mind (usually the initial developer) doesn't suffer such problems.

This can be better explained with an example.  Let's assume method `print_model_name` gets a cars model name (dynamically allocated pointer for some odd reason!) and prints it.

```c
int get_print_model_name(car_t *car)
{
    char *model = malloc(sizeof(CAR_MODEL_STR));
    if (model == null)
        return -1;

    get_car_model_name(car->model_id, car->year, &model);
    printf("Model: %s\n", model);
    free(model);
    return 0;
}
```

So far so good. Later, a maintenance programmer drops by and find that `get_car_model_name` returns error for cars that were manufactured before 1999 (not relevant, but maybe they didn't have a model number back them). He goes ahead and makes the changes necessary to handle this case. After the change, the code looked like this:

```c
int get_print_model_name(car_t *car)
{
    char *model = malloc(sizeof(CAR_MODEL_STR));
    if (model == null)
        return -1;

    // get_car_model_name returns non-zero on errors.
    // propagate the error to caller.
    if (get_car_model_name(car->model_id, car->year, &model) != 0)
        return -1;

    printf("Model: %s\n", model);
    free(model);
    return 0;
}
```

As you must have noticed, the return that he added now, does not free the allocated pointer `model`.

This is a classical example of an early return causing a leak. In this example it may look seemingly obvious, as there are only a couple of lines in the entire method. Things may not look as obvious when functions are a 100 lines long.

Now, is the time you recollect those programming best practices class where you were instructed to break down your functions into smaller blocks so they fit one widow width?

A good practice is to stick to 30 or 40 lines as the upper limit for your methods.

### Strdup pointer mix-up

strdup is a method that is used to duplicate a given string on to an allocated pointer. strdup will allocated a pointer sufficiently large to accommodate the string and the tailing null character. This comes in handy at times; (though I have no liking for this method) Very painful at times too.

Normally, we tend to subconsciously name the duped pointer with a similar name as that of the original pointer. Some prefer adding the suffix `_dup` or just a number to indicated its the same string. What ever the case, they end up calling free on the original pointer instead of the duped one.

```c
void print_string(const char *p)
{
    char *p1 = strdup(p);
    print_char_pointer(p1);
    free(p);
}
```
The sad truth of the matter is, GCC doesn't catch this sort of errors (even with `-Wall` and `-Wextra`).

### Nesting allocated pointers

With complex problem statements, we are forced to use complex data structures. Often times, we allocate memory for a structure and then allocated memory for some members within the structure. For example,

```c
struct sensor_data {
    int sendor_id;
    char *sensor_name;
    float data;
}

struct sensor_data *get_my_sensor_data()
{
    struct sensor_data *d = malloc(sizeof(struct sensor_data));
    if (d == null)
        return NULL;

    d->sensor_id = MY_COOL_SESOR_ID;
    d->sensor_name = strdup(SENSOR_NAME_STRING);
    d->data = get_sensor_data();

    return d;
}
```

Here the returned pointer to `struct sensor_data` has two allocated pointers instead of one. The caller will have to free `d->sensor_name` first and then free pointer to `struct sensor_data`.

The way this is done is create a dedicated destructor method to free all such child allocations and then free the parent itself.

```c
void destroy_sensor_data(struct sensor_data *d)
{
    free(d->sensor_name);
    free(d);
}
```

At a lot of places where they don't have such helper methods to release allocated memory, not all these child allocations are not freed before the parent is free-ed. The destructor method nicely scales as you add more pointers into the structure that needs to be free-ed.

### Pointer arithmetic loss

Pointer arithmetics is so popular that, pointer without arithmetic operations on them is just unthinkable (unusable). It is also a popular way to loose an allocated pointer without a trace.

You allocate a pointer to a series of integers. Then, by force of habit, inside loops you increment the pointer dereferencing it at each iteration to store a value that that offset. The end result, you have an array of non-free-able integers.

```c
int *get_numbers(int till)
{
    int i;
    int *p = malloc(sizeof(int) * till);
    for (i=1; i<=till; i++) {
        *(p++) = i;
    }
    return p;
}
```

Notice that the pointer that the caller will get will be pointing to the end of the allocated memory chunk in instead of the beginning. A free on p at this point will have no effect what-so-ever.

### Abandoned list node

Lists (single or double) are a very common data structure. Often times, each node in the list dynamically allocated on demand. The problem is that, the nodes have to be removed from the list and then destroyed (remember nesting allocated pointers). Sometimes, we remove an item from the list and just forget to properly clean it up.

Again, this is a classic place where a destructor method for each node make a lot of sense.

Strategies for locating/fixing memory leaks
-------------------------------------------

There are several strategies that you can employ to effectively locate and fix memory leaks. Some of them are common sense, while some come with work experience. I have listed down whatever I remember from my time fixing such issues. This is more of a reminder for myself when I have to get back to such issues.

### Least tested/added code first

If your project is of a reasonable size, you will have a bunch of third-party/FOSS packages included in source tree. Generally (convention), stable releases of these software packages are ported into your applications. This is a good thing because it's an audited code surface and you can bank on the fact that those packages have already gone through rigorous testing before their releases.

Now that you have ruled out those packages (be sure to git annotate those files to see if any other changes have been added on top of the downloaded packages), you are probably left with code that was developed in-house and those that has a lot of changes made in-house. You can be almost sure that majority of your leak is happening in this area.

### Watch out for log flooding

This has been said over and over again. Most of the time, a log file that your application wrote to a RAMFS directory will let you go on a wild goose chase (in this case a leak, of course) for hours, if not days. A general  good practice is to disable logging while looking for a leak in the system.

Also note that, deleting a file from RAMFS does not guarantee that the kernel will recollect that memory. That is, even if you delete the flooded log file, the total used memory doesn't come back down. But don't let that fool you into look elsewhere.

### Accelerate activity for early reproduction

Initially, I mentioned that the leak has to be deterministic and reproducible. The idea is that, you should be able to perform a measured number of steps to reproduce the leak. In some cases, the leak happens even if you don't do anything, and leave the device powered on for sometime. But that is not true, the device is doing a lot of things even when it is sting around doing nothing.

Now comes the deterministic part, for a set of actions, over a given period, the leak has to be deterministic. If this is the case, you are very close to finding and fixing it. Now that we know so much about it's behavior, we can try to narrow down which subset of the action or actions are contributing more to the leak.

Let's say you have a HTTP server that you suspect is leaking memory. You start by performing a lot of GET/POST requests on the server to see with code code path is causing/contributing to the leak. This will give you some hints on how to focus your search for the leak.

### Selective patching

Although I mentioned that you can rely on testing done on external packages, that's only for initial elimination to reduce the number of balls you have to juggle. You still cannot entirely rule out the possibility that there could be a leak in such packages as well.

This where you go into release notes of each packages and look for any hints on memory leak fixes in later releases. If there is one, you just got lucky. Sometimes it may not be possible to upgrade the entire package to later version. In such case you will have to selectively patch changes that correspond to the leak alone and see if that helps.

If employed correctly, this can turn out to be a life saver. It is a common practice to issue patches for critical fixes to older versions too. You could contact the package maintainers and ask them if they have a patch rolled out for your version.

### Kill suspected process

This when you know that the total system memory is going up but you haven't determined with process/processes are leaking memory. Typically you resort to doing `free` or `top` or even `cat /proc/meminfo` to over an extended range of time and then look at these logs to see if any process has steadily increased in memory consumption.

Once you have narrowed down a list of possible suspected processes, you can restart these process one at a time to see of the total available memory has increased. This method can also be effectly employed to see if the leak caused by a given process if significant enough and thereby re-prioritizing your goals.

Doing it the hard way
---------------------

Armed with all these information, let's see what it takes to create a tool to profile and log sufficient information so we can do some smartness over the dumped data to locate and fix memory leaks.

### Lay down the ground rules for the tool:

  * Solution should not take more than 5 to 10 minutes to setup.
  * Should try to cover most common types of leaks (low hanging fruits discussed here).
  * Must do some bounds check while we are at it.
  * Should catch free errors (free on unallocated pointers).

With all these in mind, I wrote a simple but effective [memory profiler][dmprof] that helped me sort of lot of memory leaks. I know there are a dozen such tools that try to address the exact same thing. For sub-1000 lines of programs, (IMHO, of course) it it is far easier to write it yourself then to look and understand someone's code. It takes almost the same time, and gives far better control over the software.

Hope that was helpful. Did I miss something? leave you comments below. I will gladly take your inputs into this post.

[dmprof]: https://github.com/cbsiddharth/DinkyMemProf
