---
title: "IoT RTOS Zephyr on cheap STM32 Minimum Development Board"
date: 2017-05-28T11:02:56+0530
author: Siddharth
thumbnail: post-thumb.jpg
permalink: /iot-rtos-zephyr-stm32-minimum-system-development-board/
dsq_thread_id: "N2U5ZmFkNzE5NGQ5"
category: "Embedded"
tags: [ "Zephyr", "RTOS", "STM32", "stm32_min_dev", "XCompile" ]
---

If you have been listening closely, you would have heard the buzz around [Zephyr][zephyr-project-home] - a Real Time Operating system (RTOS) for embedded systems. The real buzz comes from the fact that this RTOS is being tweaked for IoT platforms in particular.

A lot of action is happening around Zephyr in the past few months and it is going to play a major role in the embedded/IoT space in the forthcoming days. Support for Tensilica's Xtensa core is also in the progress, this will be a game changer if we can run Zephyr on our favourite ESP32 in the near future.

Let's take a look at zephyr and how we can use it to create amazing applications.

Why Zephyr?
-----------

The Linux Foundation, backed by companies like Linaro, Intel, ST, and NXP are spearheading Zephyr development. Zephyr is released under Open Source Apache license, needless to say, MIT and Apache are some of the most desirable licenses for Free and Open Source Software (FOSS) as they don't pose much regulation. This means you can use it on, pretty much any commercial product without having to worry about licensing related implications.

Zephyr is being developed by the Linux developer community. So the source code organisation is very well done and resembles the Linux kernel source tree in a lot of sense. The make system has been adopted from the Linux kernel, it kind off makes you feel at home.

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

Now before you start building with zephyr, you will need to setup the zephyr toolchain and kernel sources. This is fairly straight forward procedure and Zephyr's [Development Environment Setup][zephyr-dev] page does an excellent job at it. If you run into any issues, leave a comment and I will try to sort it out.

I am going to assume you choose the defaults when setting up your zephyr SDK and that you would be using west. If you made modification to the paths during setup, be sure to alter the below guide accordingly. That said, lets go ahead and build the embedded equivalent of a hello-world project &mdash; blink-an-led.

For our app to build correctly, you need to source `zephyr-env.sh` from the root level of the zephyr repository.

``` bash
cd ~/zephyrproject/zephyr && source zephyr-env.sh
```

If you plan on workring with zephyr frequently, I found that adding an alias to source the zephyr environment file comes in pretty handy.

``` bash
echo "alias get_zephyr='source ~/zephyrproject/zephyr/zephyr-env.sh'" >> ~/.bashrc
```

Zephyr allows your application to be built outside of the kernel and it's dependencies &mdash; shaddow building. It is a good practice to keep your source code out of the upstream repos (to maintain a clean git tree). So let's copy the blinky samples into your workspace and then build them.

``` shell
get_zephyr # (optional) this is to source zephyr-env.sh
cp -r $ZEPHYR_BASE/samples/basic/blinky ~/workspace/
mkdir ~/workspace/blinky/build && cd ~/workspace/blinky/build
cmake -DBOARD=stm32_min_dev_black ..
make
```

If you did everything right, this `make` should build without any warnings or errors. This build triggers a recursive _make_ process that walks up the Zephyr source tree and builds all required modules. Since this is a Zephyr primer, we won't get into the details on how to configure the kernel. This will be tasked in a separate post.

Now, the final step, sending the built binary into the board to see the output. To do this, all you have to do is, invoke the `flash` target and the rest of the work is done for you.

``` shell
make flash
```

You will notice that Zephyr invokes [open On Chip Debugger (openOCD)][openocd-home] to flash the board. You could also invoke the `debug` target to setup a GDB session with the board. Again, this is a huge topic and hence merits a separate post.

Once this succeeds, you should see the only LED on the board, blink away to eternity.

If you run into some issues with `make flash`, it porbably due to permission issues. Add the following udev rules to fix them.

```sh
wget https://raw.githubusercontent.com/zephyrproject-rtos/openocd/master/contrib/60-openocd.rules
mv 60-openocd.rules /etc/udev/rules.d/
udevadm control --reload-rules
udevadm trigger
```

Once the rules are loaded, you must add yourself to the group `plugdev`. If the group doesn't already exist, just crate it. After this, you should be able to successfully flash the device. In my next post we will explore some other interesting features of Zephyr that could come in handy.

```
Edit History:
28 May 2017 - Initial draft
14 Jul 2019 - Update "Build and Flash" section to that in latest upstream.
28 Sep 2019 - Add note on udev rules for make flash.
```



[freertos]: http://www.freertos.org/
[arduino-101]: https://www.arduino.cc/en/Main/ArduinoBoard101
[zephyr-project-home]: https://www.zephyrproject.org/
[zephyr-stm32-min-dev]: https://www.zephyrproject.org/doc/boards/arm/stm32_min_dev/doc/stm32_min_dev.html
[zephry-github]: https://github.com/zephyrproject-rtos/zephyr
[zephry-list-1]: https://lists.zephyrproject.org/pipermail/zephyr-devel/2017-May/007664.html
[zephry-list-2]: https://lists.zephyrproject.org/pipermail/zephyr-devel/2017-May/007678.html
[zephyr-pull]: https://github.com/zephyrproject-rtos/zephyr/pull/272
[zephyr-dev]:https://www.zephyrproject.org/doc/latest/getting_started/installation_linux.html
[openocd-home]: http://openocd.org/
[stm32-ebay]: http://www.ebay.in/itm/STM32F103C8T6-ARM-STM32-Minimum-System-Development-Board-Module-For-arduino-/142309080435
[stlink-v2-ebay]: http://www.ebay.in/itm/ST-Link-V2-upgrade-for-STM8-STM32-Downloader-Programer-Emulator-STLink-V2-/141670713904
[usb-uart-ebay]: http://www.ebay.in/itm/FT232RL-USB-TO-TTL-5V-3-3V-Download-Cable-To-Serial-Adapter-Module-For-Arduino-/142321843275
