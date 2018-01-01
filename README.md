EmbedJournal Jekyll Template
============================

# Installation:

### Build Dependencies:

The build process and internal tools reqire the following dependecies. Make sure
you have perl and cpan installed. To build some native modules you will need
build essentials too.

``` shell
sudo apt-get update
$ sudo apt install build-essential
$ sudo apt-get install perl git curl wget gnupg2
$ cpan -i 'YAML::XS'

$ sudo apt install install php7.0 php7.0-curl libapache2-mod-php7.0
 # alternatively, (when php7 is not available)
$ sudo apt install install php5 php5-curl libapache2-mod-php5
```

### Clone Repo

Clone and update submodules with the following commands.

``` shell
$ git clone https://gitlab.com/embedjournal/jekyll-depot.git ej-jekyll
$ cd ej-jekyll/content && git submodule init && git submodule update
```

### Mailchimp Integration:

All PHP code required to subscribe a user to EJ mailing list is already present in
the source tree and no changes are required. For protection of privacy reasons, we
keep the API Key in a separate file which is not in VCS.

Put the API Key in the following format and place it in jekyll/assets/php/config.ini

``` text
api_key = your-api-key
```

### RVM, Ruby and Gem

**Install RVM:**

Before installing RVM first we need to import public key in our system then use
curl to install rvm in our system.

``` shell
$ gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ curl -sSL https://get.rvm.io | bash -s stable
```

After installing RVM first we need to set up rvm environment using below
command. so that current shell takes new environment settings.

``` shell
$ source /home/${USER}/.rvm/scripts/rvm # for non-root users
$ source /etc/profile.d/rvm.sh          # for roor
```

You might want to append the following to your bashrc if you don't what to keep
sourcing rvm scripts manually.

``` shell
if [ -f /home/${USER}/.rvm/scripts/rvm ]; then
        source /home/${USER}/.rvm/scripts/rvm

        # Add RVM to PATH for scripting. Make sure this is the last PATH
        # variable change.
        export PATH="$PATH:/home/${USER}/.rvm/bin"
fi
```

**Install Ruby Dependencies:**

Install all the dependencies for installing Ruby automatically on system using
below command.

``` shell
$ rvm requirements
```

**List Available Ruby Versions**

Now use following command to get a list of available ruby versions, which we
can install on system. Install Ruby version of your choice (requirement ) in
next step.

``` shell
$ rvm list known
```

**Install Ruby Version**

RVM provides option to manage multiple ruby version on single system. Use
following command to install required version of Ruby. As below example we are
installing Ruby 2.2.4 on our system.

``` shell
$ rvm install 2.4.1
```

**Setup Default Ruby Version**

Use rvm command to set up default ruby version to be used by applications. You
may also install multiple versions of ruby using above step command and select
which version you want to use.

``` shell
$ rvm use 2.4.1 --default
```

**Check Ruby Version**

``` shell
$ ruby --version
```
### Install and Configure Apache

We will use Apache as our HTTP server. Build script will attempt to build the
site to /var/www/embedjoural.com/public_html. Make sure that this directory is
present and writable.

``` shell
sudo apt-get install apache2 libapache2-mod-php7.0
sudo mkdir -p /var/www/embedjournal.com/public_html
sudo chown $USER:$USER /var/www/embedjournal.com/public_html
```
Enable mode_rewrite in apache2 and setup a new site with DocumentRoot at
/var/www/embedjoural.com/public_html.

``` shell
sudo a2enmod ssl
sudo a2enmod rewrite

cat > /etc/apache2/sites-available/embedjournal.conf << EOF
<VirtualHost *:80>
	ServerName loc.embedjournal.com
	ServerAdmin admin@embedjournal.com
	DocumentRoot /var/www/embedjournal.com/public_html

	ErrorLog ${APACHE_LOG_DIR}/ej_error.log
	CustomLog ${APACHE_LOG_DIR}/ej_access.log combined
</VirtualHost>
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
EOF

sudo a2ensite embedjournal.conf
sudo service apache2 restart
```

Edit /etc/hosts file (C:\Windows\System32\drivers\etc\hosts) and add the following
line.

``` text
127.0.0.1       loc.embedjournal.com
```

### Jekyll, Bundler and Build

Since we alreay have ruby and gems installed, we can install Jekyll just as any other
gem. So let's go ahead and install jekyll and bundler.

``` shell
$ gem install jekyll bundler
```

Now, we have met all ruby, jekyll related dependencies. Time to meet embedjoural's
dependencies (sigh!). Since we have bundler, this is quite simple.

``` shell
$ cd ej-jekyll/jekyll/
$ bundle install
```

Now we have installed everything you need to build embedjournal.com, time to build.

``` shell
$ ./fervour --build
```
See what else you can do with "fervour" - our build assistant!

``` shell
$ ./fervour --help
```
