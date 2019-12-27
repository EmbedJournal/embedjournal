---
title: "Custom RFS for Beaglebone Black using Busybox"
date: 2016-11-09T20:44:41+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Mani
thumbnail: post-thumb.png
permalink: /custom-rfs-beaglebone-black/
dsq_thread_id: "5291157687"
category: "Linux"
tags: [ "Beagle Bone" ]
---

Hello folks,

In my previous post on [Linux kernel compilation for Beaglebone black](/kernel-compilation-beaglebone-black/), I had used pre-built RFS for booting the kernel. Also, I mentioned that the RFS could be built from scratch using a utility called Busybox. In this post, we'll see, how to create a Custom RFS using Busybox and what are all the additional files required to boot the kernel. The RFS which we're going to create contains only the bare minimum stuff required to boot the kernel, so you can't expect it to behave like your distribution's rootfs.

Before getting our hands dirty by working with Busybox, let's acquire some basic theory to get things organized!

## What is RFS?

RFS is the Root File System (/), the place where the kernel acts upon. All the applications will reside inside this root file system. Usually RFS is created and placed in the Flash memory of the device, which could be either your Android phone or your Personal computer. There is also one filesystem called initramfs, which is used in the boot process of the Linux based desktops/servers. But, initramfs is a RAM based filesystem which contains the entire root file system directories often compressed and passed along with the kernel image. Embedded Linux devices don't necessarily need initramfs for booting.

During the last stage of the Linux legacy booting process, the kernel executes the /sbin/init which in turn looks for the inittab file in /etc directory. It is based upon the SysV init process. But, most of the modern linux distros now switched from SysV init to Systemd, which is more flexible.

### How do I create a RFS?

Now, we know that rootfs is mandatory inorder to boot the linux kernel. But how do I create one? Have you tried "ls /" in your linux machine... Yes, there are lot of directories under '/'. Usually not all the directories are needed to get your linux system up and running. Only a fair amount of directories are needed by the kernel, but it entirely depends upon the end application your linux system is using. It could be either a server or an Embedded linux system for a dedicated application.

In our case we'll consider the latter one, because our target platform is Beaglebone black, which is mostly used for an Embedded application. Let's discuss the list of directories needed and their uses.

### Mandatory directories:

**/bin** directory contains the commands used by the normal linux user for day to day activities like ls, cp, rm. It also contains the commands needed during boot process like systemd etc...

**/sbin** directory contains the binaries used by the super user for system administration. Some of the commands are insmod, lsmod, ipconfig. Normal users can't use the commands in this directory without administrative privileages.

**/etc** directory contains the files needed for system configuration like init scripts, network conf files, bootloader init scripts, application conf files etc...

**/dev** directory contains the special files which represent the devices present in the system like char, block and net devices. It also contains the files needed to interact with the device drivers for a particular hardware using generic read/write calls. For all types of devices attached to the target, appropriate device nodes will be created in this directory.

**/lib** directory contains the shared libraries used by the applications in the system. Often it contains the glibc/klibc, ld-linux shared libraries. It also contains the loadable kernel modules under /lib/modules which could be inserted into the system dynamically using modprobe/insmod commands. List of modules should be built while building the kernel using 'make modules' command. Modules could also be loaded automatically when the devices are attached to the system using some utilities.

**/usr** directory contains the userspace programs and data. In older unix implementations, this is the place where the home directories of all users were placed. It contains the necessary data, headers, libraries and also some programs like telnet, git etc...

### Nice to have:

**/proc** directory is based on procfs filesystem. It is a type of virtual file system which contains files based on the processes existing in the system. There is no need to create any files under this directory, all files will be created once you mount the procfs in this directory.

**/sys** directory is based on sysfs filesystem. Like procfs, this is also a type of virtual file system based on the Kernel objects and its attributes. It is most widely used to interact with the device drivers like /dev directory. Drivers need to create sysfs entry, then it may contain files to send/receive data from the driver. For instance LED's in Beaglebone black could be configured using sysfs/class/leds.

**/config** directory is based on configfs filesystem. Major use of the configfs is to manage the Kernel objects from userspace. Unlike sysfs, which just acts on the Kernel objects, this one can modify it in runtime.

Alright, we have seen the list of directories needed and their uses. So, are we going to create all these directories and its contents by hand? It would be an over kill, isn't it?

For this scenario, we're going to use a utility called Busybox, which will make our life easier.

## Busybox Cross compilation

Here is what the busybox creators had to say about it,

> BusyBox combines tiny versions of many common UNIX utilities into a single small executable. It provides replacements for most of the utilities you usually find in GNU fileutils, shellutils, etc. The utilities in BusyBox generally have fewer options than their full-featured GNU cousins; however, the options that are included provide the expected functionality and behave very much like their GNU counterparts. BusyBox provides a fairly complete environment for any small or embedded system.

Busybox is focused mainly on Embedded platforms as the size optimization is vastly required. It could be built as the binary requiring shared libraries (default option) or a single static binary requiring no external shared libraries. We are going to use the latter one.

### Working with Busybox

Download the Busybox source from [here](https://busybox.net/downloads/busybox-1.24.1.tar.bz2).

Extract the tarball with `tar -xvf busybox-1.24.1.tar.bz2`. Then, cross compile the source for ARM platform using the following commands.

Note: This assumes that you have the arm cross compilation toolchain configured in your system. If not please go through my [previous post](/kernel-compilation-beaglebone-black/) to see how to get it done.

```shell
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- defconfig
$ make ARCH=arm CRSOO_COMPILE=arm-linux-gnueabihf- menuconfig
```

Select Busybox Settings -> Build Options -> Build Busybox as a static binary (no shared libs). Press y for selecting that option and save it. Then execute the following commands for building.

```shell
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- CONFIG_PREFIX=/path/to/RFS install
```

After the successful completion of the above commands, you can see 3 directories (bin, sbin, usr) and one file (linuxrc) created in your RFS directory. Path to RFS should be like /media/user/rfs which resides in SD card as ext3 file system. Apart from these, we need few more directories mentioned above to boot the kernel. So, move to the RFS location and create the following files and directories.

**/dev:**

Create /dev and some special files under this directory.

```shell
$ mkdir dev
$ mknod dev/console c 5 1
$ mknod dev/null c 1 3
$ mknod dev/zero c 1 5
```

- /dev/console, is the place where the kernel uses for interaction.
- /dev/null behaves like an empty file and is used to suppress the output from commands/programs.
- /dev/zero contains sequence of zeros used to fill up the memory regions.

**/lib and /usr/lib:**

For the static libraries, copy from the ARM cross compiler toolchain path.

```shell
$ mkdir lib usr/lib
$ rsync -a /opt/arm-linux-gnueabihf/lib/ ./lib/
$ rsync -a /opt/arm-linux-gnueabihf/lib/ ./usr/lib/
```

**/proc, /sys, /root:**

Create directories for mounting the virtual filesystems (procfs, sysfs) and root directory.

```shell
$ mkdir proc sys root
```

**/etc:**

Create /etc and then, create additional files inside this directory.

```shell
$ mkdir etc
$ cat >> etc/inittab
null::sysinit:/bin/mount -a
null::sysinit:/bin/hostname -F /etc/hostname
null::respawn:/bin/cttyhack /bin/login root
null::restart:/sbin/reboot
[ctrl-D]
```

Create another file called fstab and populate it. This file will mount the virtual file systems.

```shell
$ cat >> etc/fstab
proc  /proc proc  defaults  0 0
sysfs /sys  sysfs defaults  0 0
[ctrl-D]
```

Also, create files called hostname and passwd.

```shell
$ cat >> etc/hostname
embedjournal
[ctrl-D]

$ cat >> etc/passwd
root::0:0:root:/root:/bin/sh
[ctrl-D]
```

Busybox init will first look for /etc/init.d/rcS script, if it can't find that then it will look for /etc/inittab. Inittab file will mount the virtual filesystem using fstab. Also, it will have the command for getting login prompt and shell.

/sbin/init -> /bin/cttyhack -> /bin/login -> /bin/sh.

Here, we don't use password for login. So, after logging in, set the password by executing 'passwd' command.

Note: You may encounter 'read only filesystem error'. This is due to the kernel parameters which Uboot has passed. You can change it by modifying the `uEnv.txt` file as:

```shell
root=/dev/mmcblk0p2 rw
```

This will mount the RFS as read/write file system.

That's it...

Voila! You have successfully created one Custom RFS using Busybox for Beaglebone Black. Just insert the SD card into BBB's slot and hold the Boot switch (SW2) while powering up. This will boot your linux kernel using Custom built RFS.

As we always say, if you get stuck at any point kindly post your questions in comments in somewhat detailed manner (No need to post the entire log...), we'll help you out.
