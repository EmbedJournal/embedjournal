#
#  Author: Siddharth Chandrasekaran
#   Email: siddharth@embedjournal.com
#    Date: 28 December 2019
#

all: Gemfile.lock
	jekyll build --trace

run:
	jekyll serve --incremental --port 8080 --trace

Gemfile.lock:
	bundle install

clean:
	rm -rf _site Gemfile.lock .jekyll-cache/
