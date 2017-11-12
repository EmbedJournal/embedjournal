---
title: "IoT RTOS Zephyr on cheap STM32 Minimum Development Board"
date: 2017-05-28T11:02:56+0530
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /iot-rtos-zephyr-stm32-minimum-system-development-board/
dsq_thread_id: "N2U5ZmFkNzE5NGQ5"
category: "Embedded"
tags: [ "Zephyr", "RTOS", "STM32", "stm32_min_dev" ]
---

If you have been listening closely, you would have heard the buzz around [Zephyr][zephyr-project-home] - a Real Time Operating system (RTOS) for embedded systems. The real buzz comes from the fact that this RTOS is being tweaked for IoT platforms in particular.

A lot of action is happening around Zephyr in the past few months and it is going to play a major role in the embedded/IoT space in the forthcoming days. Support for Tensilica's Xtensa core is also in the progress, this will be a game changer if we can run Zephyr on our favorite ESP8266 in the near future.

Let's take a look at zephyr and how we can use it to create amazing applications.

Why Zephyr?
-----------

The Linux Foundation, backed by companies like Linaro, Intel, ST, and NXP are spearheading Zephyr development. Zephyr is released under Open Source Apache license, needless to say, MIT and Apache are some of the most desirable licenses for Free and Open Source Software (FOSS) as they don't pose much regulation. This means you can use it on, pretty much any commercial product without having to worry about licensing related implications.

Zephyr is being developed by the Linux developer community. So the source code organization is very well done and resembles the Linux kernel source tree in a lot of sense. The make system has been adopted from the Linux kernel, it kind off makes you feel at home.

I have used [FreeRTOS][freertos] in the past, and during my initial days, have had great difficulty in locating where a given module fell ie., it wasn't very intuitive to begin with. Also, it had the macro soup (#ifdefs literally everywhere) issue that Zephyr doesn't (currently) suffer.

To follow this article, you will need the following,
  * [STM32 Minimum Development Board][stm32-ebay]
  * [STLink V2][stlink-v2-ebay]
  * [USB to UART converter][usb-uart-ebay]

STM32 Minimum Development Board
-------------------------------

Since Zephyr is a fairly new RTOS, there are very few boards to which it has already been ported to. Most of the boards which already have a port are either not available or outright expensive. In this post I will take up the "STM32 Minimum Development Board" - a cheaper alternative and try to run Zephyr on it.

Well, this is not exactly a development board in the strictest of senses (all it has is an on board LED). This is more of a breakout board with just the bare minimum to get the CPU to boot. Somehow, the term "STM32 Minimum Development Board" seems to have caught on to it and for the sake of consistency with the existing SEO, we will refer to this board in the same way. Mote details on the board cab be found at [zephyr's board document page][zephyr-stm32-min-dev].

{% include image.html src="stm32_min_dev.jpg" alt="minimum system development board" %}

I have been having my eye on the STM32F103C8T6 series SoC for some time. Reason being, they were inexpensive and had sufficient juice to do some intermediate level stuffs. So I went ahead and bought one of these [minimum system development board][stm32-ebay] from eBay for like $4 including shipment.

STLink V2
---------

{% include image.html src="stlink_v2_openocd.jpg" alt="stlink v2 debugger" %}

Although STM32 can be bootloaded without the need for any external hardware, I bought one of this [STLink V2][stlink-v2-ebay] to flash and debug mu code. It was dirt cheap and I know it will come in handy at some point in time.

Hardware Setup
--------------

My setup as the following, STM32 breakout board connected to STLink and an UART to USB converter connected to the STM32 to get the console out.

**STLink Connections:**

|-------+------------|
| STM32 | STLink     |
|:-----:+:----------:|
| IO    | SWIO (2)   |
| CLK   | SWCLK (6)  |
| V3    | 3.3V (7/8) |
| G     | GND (3/4)  |
|-------+------------|
{: .table .table-bordered .width-50 }

**UART to USB Connections:**

|-------+------------|
| STM32 | USB-UART   |
|:-----:+:----------:|
| A9    | RXD        |
| A10   | TXD        |
| G     | GND        |
|-------+------------|
{: .table .table-bordered .width-50 }

{% include image.html src="stm32_stlink_zephyr_setup.jpg" %}

Zephyr - Board Support Package
------------------------------

To my disappointment, Zephyr wouldn't run on the board out of the box as the SoC wasn't ported and the board itself didn't have a port ie., there was no Board Support Package (BSP) for this board as yet.

Then I read through Zephyr's docs and looked at other supported hardware. After some time, I branched off to start making changes of my own. Within the first 5 or 6 hours of effort, I was able to get a make shift BSP port working with the my board (although I wasn't able to get the UART to work at that point).

After a bunch of email exchanges with Erwan Gouriou (Zephyr developer), [here][zephry-list-1] and [here][zephry-list-2], I was able to get a fully working BSP for the STM32F103C8T6 breadboard breakout board. I raised a [pull request][zephyr-pull] sometime back and ~~expecting it to be merged sometime soon~~ is now available upstream.

Build and Flash
---------------

Now before you start building with zephyr, you will need to setup the zephyr tool chain. This is fairly straight forward procedure and Zephyr's [Development Environment Setup][zephyr-dev] page is pretty accurate.

Now that we have the right setup in place, lets go ahead and build the embedded equivalent of a "hello world".

To being with, you will need a local copy of the Zephyr source tree. So lets go ahead and clone the upstream repository from [GitHub][zephry-github].

``` shell
$ cd ~/workspace
$ git clone https://github.com/zephyrproject-rtos/zephyr.git
```

Once you have clone the zephyr source tree, you will have export zephyr SDK path and GCC variant so that the zephyr make system understand where to find the toolchains. You will also need to source `zephyr-env.sh` present in the top level of the cloned repository.

``` shell
$ export ZEPHYR_GCC_VARIANT=zephyr
$ export ZEPHYR_SDK_INSTALL_DIR=/path/to/zephyr-sdk/
$ cd zephyr
$ source zephyr-env.sh
```

Zephyr allows your application software to be isolated from the Zephyr kernel (although, they are built together) so, it's a good practice to copy samples into your workspace and then build them. This way, your git tree remains pristine.

``` shell
$ cp -r $ZEPHYR_BASE/samples/basic/blinky ~/workspace/stm32/
$ cd ~/workspace/stm32/blinky
$ make BOARD=stm32_min_dev
```

If you did everything right, this `make` should build without any warnings or errors. This build triggers a recursive _make_ process that walks up the Zephyr source tree and builds all required modules. Since this is a Zephyr primer, we won't get into the details on how to configure the kernel. This will be tasked in a separate post.

Now, the final step, sending the built binary into the board to see the output. To do this, all you have to do is, invoke the `flash` target and the rest of the work is done for you.

``` shell
$ make BOARD=stm32_min_dev flash
```

You will notice that Zephyr invokes [open On Chip Debugger (openOCD)][openocd-home] to flash the board. You could also invoke the `debug` target to setup a GDB session with the board. Again, this is a huge topic and hence merits a separate post.

Once this succeeds, you should see the only LED on the board, blink away to eternity. In my next post we will explore some other interesting features of Zephyr that could come in handy.

[freertos]: http://www.freertos.org/
[arduino-101]: https://www.arduino.cc/en/Main/ArduinoBoard101
[zephyr-project-home]: https://www.zephyrproject.org/
[zephyr-stm32-min-dev]: https://www.zephyrproject.org/doc/boards/arm/stm32_min_dev/doc/stm32_min_dev.html
[zephry-github]: https://github.com/zephyrproject-rtos/zephyr
[zephry-list-1]: https://lists.zephyrproject.org/pipermail/zephyr-devel/2017-May/007664.html
[zephry-list-2]: https://lists.zephyrproject.org/pipermail/zephyr-devel/2017-May/007678.html
[zephyr-pull]: https://github.com/zephyrproject-rtos/zephyr/pull/272
[zephyr-dev]:https://www.zephyrproject.org/doc/1.3.0/getting_started/installation_linux.html
[openocd-home]: http://openocd.org/
[stm32-ebay]: http://www.ebay.in/itm/STM32F103C8T6-ARM-STM32-Minimum-System-Development-Board-Module-For-arduino-/142309080435
[stlink-v2-ebay]: http://www.ebay.in/itm/ST-Link-V2-upgrade-for-STM8-STM32-Downloader-Programer-Emulator-STLink-V2-/141670713904
[usb-uart-ebay]: http://www.ebay.in/itm/FT232RL-USB-TO-TTL-5V-3-3V-Download-Cable-To-Serial-Adapter-Module-For-Arduino-/142321843275
