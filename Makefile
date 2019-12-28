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
	bundle install --path .bundle/vendor

clean:
	rm -rf _site Gemfile.lock .jekyll-cache/

clean_vendor:
	rm -rf vendor/
