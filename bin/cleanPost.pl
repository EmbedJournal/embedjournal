#!/usr/bin/perl -i

use Text::Unidecode qw(unidecode);
use HTML::Entities qw(decode_entities);

$front_matter = 0;


my $dir = '_posts/';
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
			unless (/^(id|title|date|author|layout|permalink|dsq_thread_id|image|categories|tags):/) {
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
			if (/^dsq_thread_id:/) {
				$v=<>; chomp($v);
				$v =~ s/\s+-\s+(.*)$/\1/;
				s/(.*)/\1 $v\n/;
				print; next;
			}
			if (/^tags:/) {
				$t = $_;
				$l; @a = ();
				while (<>) {
					$l=$_;
					last unless (/^\s+-\s+/);
					s/^\s+-\s+//; chomp;
					$_ = '"' . $_ . '"' unless (/^"/);
					push @a, ($_);
				}
				if (@a) {
					$s = join ", ", @a;
					chomp($t);
					$t = $t . " [ " . $s . " ]\n";
				}
				print $t;
				$_ = $l;
				redo;
			}
			if (/^categories:/) {
				$t = $_;
				$l; @a = ();
				while (<>) {
					$l=$_;
					last unless (/^\s+-\s+/);
					s/^\s+-\s+//; chomp;
					$_ = '"' . $_ . '"' unless (/^"/);
					push @a, ($_);
				}
				if (@a) {
					$s = join ", ", @a;
					chomp($t);
					$t = $t . " [ " . $s . " ]\n";
				}
				print $t;
				$_ = $l;
				redo;
			}
		} else {
			# in content section. careful!!!
			s|http://embedjournal.com/wp-content/uploads/|/images/posts/|g
		}

		print;
	}
}



