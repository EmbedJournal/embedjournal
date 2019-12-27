---
title: "Installing and configuring a TFTP Server on Ubuntu"
date: 2017-11-23T23:56:30+0530
author: Siddharth
permalink: /installing-configuring-a-tftp-server-ubuntu/
dsq_thread_id: "nowo0tixak"
category: "linux"
tags: [ "Tools", "Basics" ]
---

TFTP is a very simple UDP file transfer protocol that can be implemented with very little effort and footprint. For this reason, TFTP servers are very crucial for embedded developers even if they are used only for the purpose of firmware upgrades. This article is more of a note-to-self so I don't have to hunt for it elsewhere.

We start by installing tftp client and server packages along with xinitd.

```shell
$ sudo apt-get install xinetd tftpd tftp
```

Create a directory to to act as your TFTP root (the place from which you serve your files) and set permissions so as to allow everyone to read-write-execute from there. Typically, this directory would be called `tftpboot` and placed at root level, and we will just stick to that convention.

```shell
$ sudo mkdir /tftpboot
$ sudo chmod -R 777 /tftpboot
$ sudo chown -R nobody /tftpboot
```

Create a new service in xinitd by creating `/etc/xinetd.d/tftp` with the following contents.

```text
service tftp
{
    protocol        = udp
    port            = 69
    socket_type     = dgram
    wait            = yes
    user            = nobody
    server          = /usr/sbin/in.tftpd
    server_args     = /tftpboot
    disable         = no
}
```

Now that everything is in place, restart the xinetd service for the changes to kick-in and start your TFTP server.

```shell
sudo service xinetd restart
```

You can pass an additional `-c` option to `server_args` to allow remote file creation, but that is generally not preferred.

Now the TFTP server should be up and running. Now let's test if its working,

```shell
$ echo "Test TFTP Server" > /tftpboot/test.txt
$ tftp <server-ip>
tftp> get test.txt
tftp> quit
```

After performing the above steps, you should have a file named `test.txt` in your current directory with the contents "Test TFTP Server". If you did, your server is configured correctly.
