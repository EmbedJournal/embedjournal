#!/usr/bin/perl -i

use Text::Unidecode qw(unidecode);
use HTML::Entities qw(decode_entities);

$front_matter = 0;

my $dir = '_pages/';
my @files;

opendir(DIR, $dir) or die "Can't open dir $dir, Perl says $!\n";
while (my $file = readdir DIR) {
	push @files, "$dir/$file" unless (-d "$dir/$file");
}
closedir DIR;

# now do an inplace edit. use a bare block and local to limit
# the scope of our changes to the global @ARGV array to just here
{
	local @ARGV = @files;   # set up a temporary @ARGV for in-place ed
	while(<>) {
		$_ = unidecode(decode_entities($_));
		if(/^---$/) {
			if($front_matter) {
				$front_matter = 0;
				print; print "\n";
				next;
			} else {
				$front_matter = 1;
				print; next;
			}
		}

		if ($front_matter) {
			unless (/^(id|title|layout|permalink):/) {
				$l;
				while(<>) {
					$l=$_;
					last unless (/^\s+-\s+/);
				}
				$_=$l;
				redo;
			}
			if (/^title/) {
				s/^(title:\s+)'/\1"/;
				s/'\s*$/"\n/;
			}
		} else {
			# in content section. careful!!!
			s|http://embedjournal.com/wp-content/uploads/|/images/posts/|g
		}

		print;
	}
}



