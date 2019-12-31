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
	find assets/ -type f -name 'post-thumb.*' | grep -v '/scaled/' | \
		perl -ne ' \
			use File::Basename; \
			chomp; \
			($$n,$$p)i = fileparse($$_); \
			next if (-f "$$p/scaled/$$n"); \
			system("mkdir -p $$p/scaled"); \
			system("convert $$_ -resize 80x80^ -gravity center -extent 80x80 $$p/scaled/$$n"); \
			print "Scaling: $$_\n" \
		'
	bundle install --path .bundle/vendor

clean:
	rm -rf _site Gemfile.lock .jekyll-cache/

clean_bundles:
	rm -rf .bundle/

.PHONY: all run clean clean_bundles
