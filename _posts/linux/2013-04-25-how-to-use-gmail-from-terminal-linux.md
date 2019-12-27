---
title: "How to use gmail from terminal (Linux)"
date: 2013-04-25T18:33:39+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /how-to-use-gmail-from-terminal-linux/
dsq_thread_id: "2728571155"
category: "Linux"
tags: [ HowTo, "CLI", "Intro" ]
---

{% include image.html src="Gmail-Icon.png" %}

Great news!! Gmail, our favorite mail service can be accessed from the command line!!

Now you can access your favorite mail service - Gmail - from a terminal in a Linux system with a command line interface. People may wonder why anyone would want to use Gmail from the command line, when Google has created such a nice user friendly interface for its users. There are a lot of reasons why one would want to use a CLI (command-line interface) for sending mails. One of the main reasons being the power of shell scripting in a Linux machine. You can automate the entire process by writing small shell scripts and make life much easier. The other reason why I use the command line way is because it uses very less bandwidth (Gmail tab on chrome takes up 400MB of RAM these days).

Lets get started. I use Ubuntu (current version) . If you have some other flavor of Linux you might have to port the commands to work on your system.

**Step1 :** Open a new terminal and type the following command to install the package from the Ubuntu repositories.

```shell
$ sudo apt-get install msmtp-mta
```

You have to enter your system password to provide administrative rights. Say 'y' when it asks for you choice after the size of the file to be downloaded is determined.

**Step2 :** Now fire up you favorite text editor by typing

```shell
$ vim ~/.msmtprc
```

If Vim is not already installed do a 'sudo apt-get install vim' install vim and proceed to typing the above command.

Vim is one of the most powerful text editors in the Linux Environment consider mastering it. Once inside the file you have to hit 'i' to enter the insert mode, then copy the following code into the editor.

```shell
#Gmail account

defaults
#change the location of the log file to any desired location.
logfile ~/msmtp.log
account gmail
auth on
host smtp.gmail.com
from <yourmail@gmail.com>
auth on
tls on
tls_trust_file /usr/share/ca-certificates/mozilla/Equifax_Secure_CA.crt
user <yourmail@gmail.com>
password <your-password>
port 587
#set gmail as your default mail server.
account default : gmail
```

then press ESC to enter into the command mode in vim then type ':wq' to save and quit the editor. Now if you do an 'ls -la' you should see the file in your home directory.

**Step3 :** Now this is lame.. any one who has access to you computer could open this file to see your password. So you have to modify the access permit for this file to the root only (you). So type the following command

```shell
$ chmod 600 .msmtprc
```

For more details see manual page of chmod.

**Step4 :** Now we have configured the Gmail settings and your computer should not have any trouble talking to the remote server. We have to set up a command-line email program to talk to the mail-server. So install mailx.


```shell
$ sudo apt-get install heirloom-mailx
```

**Step5 :** Now configure Mailx by creating a file called '.mailrc' in your home directory.

```shell
$ vim ~/.mailrc
```

follow the same procedure as in step2 to copy the following code into the newly created text file.

```shell
set sendmail="/usr/bin/msmtp"
set message-sendmail-extra-arguments="-a gmail"
```

This should be enough to set up Gmail to work from the command line. If you are having any problems with the above procedure leave a comment and I will get back to you shortly.

**How to use it?**

****Type this command and hit enter.

```shell
$ mail -s "subject" -a "attachment-if-any" "receiver@some-domain.com"
```

Now you have to type your message here and then hit enter and come to a new line and press CTRL+D you should see a EOT at the line this indicates that you have successfully sent the mail. The -a <A attachmentA > is completely optional so you can omit it. You can also use IO redirection operators in Linux to transfer the contents of a file into a mail like,

```shell
$ mail -s "subject" "receiver@some-domain.com" < message.txt
```

This should send the contents of the text file to the receiver. If you are really concerned about your privacy then you have to become the superuser and perform the above steps in the root home directory.

Hope this helps some one out there. Please leave your feedback.
