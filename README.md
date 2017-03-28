EmbedJournal Jekyll Template
============================

# Installation:


### General Dependencies:

``` shell
$ sudo apt-get install git curl gnupg2
```

### RVM, Ruby and Gem


**Install RVM:**

Before installing RVM first we need to import public key in our system then use curl to install rvm in our system.

``` shell
$ gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ curl -sSL https://get.rvm.io | bash -s stable
```

After installing RVM first we need to set up rvm environment using below command. so that current shell takes new environment settings.

``` shell
$ source /home/ubuntu/.rvm/scripts/rvm
```

**Install Ruby Dependencies:**

Install all the dependencies for installing Ruby automatically on system using below command.

``` shell
$ rvm requirements
```

**List Available Ruby Versions**

Now use following command to get a list of available ruby versions, which we can install on system. Install Ruby version of your choice (requirement ) in next step.

``` shell
$ rvm list known
```

**Install Ruby Version**

RVM provides option to manage multiple ruby version on single system. Use following command to install required version of Ruby. As below example we are installing Ruby 2.2.4 on our system.

``` shell
$ rvm install 2.4.0
```

**Setup Default Ruby Version**

Use rvm command to set up default ruby version to be used by applications. You may also install multiple versions of ruby using above step command and select which version you want to use.

``` shell
$ rvm use 2.4.0 --default 
```

**Check Ruby Version**

``` shell
$ ruby --version
```
### Jekyll and Bundler

``` shell
$ gem install jekyll bundler
```

# Jekyll

### Notes:

* Collection names do not seem to support "-" in them, use "_" instead.
* collection names cannot be same as global variables (site.VARIABLE) as collections get get into into global scope (site.COLLECTION) as well.
