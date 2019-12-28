#
#  Author: Siddharth Chandrasekaran
#   Email: siddharth@embedjournal.com
#    Date: 28 December 2019
#

all: Gemfile.lock
	bundle exec jekyll build --trace

run:
	bundle exec jekyll serve --incremental -P 3858 -H 0.0.0.0 --trace

Gemfile.lock:
	bundle install

clean:
	rm -rf _site Gemfile.lock .jekyll-cache/
