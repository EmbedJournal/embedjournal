#
#  Author: Siddharth Chandrasekaran
#   Email: siddharth@embedjournal.com
#    Date: 28 December 2019
#

all: Gemfile.lock
	bundle exec jekyll build --trace

run:
	bundle exec jekyll serve --watch -P 3858 -H 0.0.0.0 --trace

scale:
	find assets/ -type f -name 'post-thumb.*' | \
		perl -ne ' \
			use File::Basename; \
			chomp; \
			($$n,$$p) = fileparse($$_); \
			next if (-f "$$p/post-thumb-80x80.jpg"); \
			system("convert $$_ -resize 80x80^ -gravity center -extent 80x80 $$p/post-thumb-80x80.jpg"); \
			print "Scaling: $$_\n" \
		'

Gemfile.lock:
	bundle install --path .bundle/vendor

clean:
	rm -rf _site Gemfile.lock .jekyll-cache/

clean_bundles:
	rm -rf .bundle/

.PHONY: all run clean clean_bundles scale
