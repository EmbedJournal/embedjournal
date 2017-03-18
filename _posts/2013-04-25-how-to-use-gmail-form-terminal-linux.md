---
title: How to use gmail form terminal (Linux)
date: 2013-04-25T18:33:39+00:00
author: Siddharth
layout: post
permalink: /how-to-use-gmail-form-terminal-linux/
dsq_thread_id: "2728571155"
categories: [ "How To", "Linux" ]
tags: [ "CLI", "Intro" ]
---


{% include image.html src="Gmail-Icon.png" caption="Gmail Icon" %}

Great news gmail our favorite mail service can be accessed form command line!!

Now you can access your favorite mail service -gmail form terminal in a linux system with a command line interface.A People may wonder why anyone would want to use gmail from the command line, whenA GoogleA has created such a nice user friendly interface for its users. There are a lot of reasons why one would want to use a CLI (command-line interface) for sending mail. One of the main reasons being the power of shell scripting in a Linux machine. You can automate the entire process by writing small shell scripts and make life much easier. The other reason why I use the command line way is because it uses very less bandwidth. Due the recent D-DOS (Distributed Denial-of-Service) attack on the domain name system by a group of really talented Hackers my computer seemed to take ages to load evenA FacebookA that was when the terminal way of sending mails came in handy.

Lets get started. I use Ubuntu (currentA version) I'm having issues with this method. If you have some otherA flavor of Linux you might have to port the commands to work on your system.

**Step1 :** A Open a new terminal and type the following command to install the package from theA UbuntuA repositories.

{% highlight shell %}
# apt-get install msmtp-mta
{% endhighlight %}

You have to enter your system password to provide administrative rights. Say 'y' when it asks for you choice after the size of the file to be downloaded is determined.
  
**Step2 :** Now fire up you favorite text editor by typing

{% highlight shell %}
$ vim ~/.msmtprc
{% endhighlight %}

If Vim is not already installed do a 'sudo apt-get install vim' install vim and proceed to typing the above command.
  
Vim is one of the most powerful text editors in the Linux Environment consider mastering it. once inside the file you have to hit 'i' to enter the insert mode. then copy the following code into the editor.

{% highlight shell %}
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
userA <yourmail@gmail.com>
password <your-password>
port 587
#set gmail as your default mail server.
account default : gmail
{% endhighlight %}

then press ESC to enter into the command mode in vim then type ':wq' to save and quit the editor. Now if you do a 'ls -al' you should see the file in your home directory.

**Step3 :** Now this is lame.. any one who has access to you computer could open this file to see your password. So you have to modify the access permit for this file to the root only (you). So type the following command

{% highlight shell %}
$ chmod 600 .msmtprc
{% endhighlight %}

For more details see manual page of chmod.

**Step4 :** Now we have configured the gmail settings and your computer should not have any troublesA talkingA to the remote server. We have to set up a command-line email program to talk to theA mail-server. So install mailx.


{% highlight shell %}
# apt-get install heirloom-mailx
{% endhighlight %}

**Step5 :** Now configure Mailx by creating a file called '.mailrc' in your home directory.

{% highlight shell %}
$ vim ~/.mailrc
{% endhighlight %}


follow the same procedure as in step2 to copy the following code into the newly created text file.

{% highlight shell %}
set sendmail="/usr/bin/msmtp"
set message-sendmail-extra-arguments="-a gmail"
{% endhighlight %}

This should be enough to set up gmail to work form the command line. If you are having any problems with the above procedure leave a comment and I will get back to you shortly.

**How to use it?**

****Type this command and hit enter.

{% highlight shell %}
mail -s "subject" -a "attachment-if-any" "receiver@some-domain.com"
{% endhighlight %}

Now you have to type your message here.

then hit enter and come to a new line and press CTRL+D you should see a EOT at the line this indicates that you haveA successfullyA sent the mail. The -a <A attachmentA > is completely optional so you canA omitA it. you can also use IO redirection operators in in linux to transfer the contents of a file into a mail like,

{% highlight shell %}
mail -s "subject" "receiver@some-domain.com" < message.txt
{% endhighlight %}

This should send the contents of the text file to the receiver. If you are really concerned about your privacy then you have to become the superuser and perform the above steps in the root home directory.

Hope this helps some one out there. Please leave yourA feedback.
