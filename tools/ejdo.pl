#!/usr/bin/env perl
# Custom post generation script for internal use by authors of
# embedjournal.com
#
#   Owner: EmbedJournal
#  Author: Siddharth Chandrasekaran
#   Email: siddharth@embedjournal.com
#    Date: 05 April 2017
#

use warnings;
use strict;
use Time::Piece;
use POSIX 'strftime';
use Getopt::Long 'HelpMessage';
use Pod::Usage 'pod2usage';

=head1 SYNOPSIS

  EmbedJournal Post Management Utility.
  ejdo [OPTIONS]

=head1 OPTIONS

  -n, --new-post       Create new draft interactively
  -p, --pack PATH      Pack post specified by PATH for email.
  -h, --help           Print this help

=head1 VERSION

0.01

=cut

my $argc = @ARGV;

GetOptions(
  'new-post'      => \ my $newPost,
  'pack=s'        => \ my $packPostPath,
  'help'          =>   sub { pod2usage(1) },
);

pod2usage(1) if($argc == 0);

my @categories = (
	"Arduino",
	"Embedded",
	"General Posts",
	"Hardware",
	"Linux",
	"Microchip PIC",
	"News",
	"Programming",
	"Review",
	"Robotics"
);

sub readInput {
	my $inp;
	while (1) {
		print "$_[0]: ";
		chomp($inp = <STDIN>);
		return $inp if $inp;
	}
}

sub getSlug
{
	my $s = shift;
	$s = lc $s;
	$s =~ s/\s/-/g;
	$s =~ s/[^A-Za-z0-9\-\.]//g;
	$s =~ s/--/-/g;
	return $s;
}

sub getFileName
{
	my $s = shift;
	my @locTime = localtime();
	return strftime ("%Y-%m-%d-", localtime()) . $s;
}

sub getCategory
{
	for my $i (0..$#categories) {
		printf "\t%2d - %s\n", $i+1, $categories[$i];
	}
	print "\n";
	my $catID = readInput("Category index");
	die "Invalid choice.\n" if ($catID !~ /^\d+$/);
	die "Invalid choice.\n" if (int($catID) < 0 or int($catID) > ($#categories + 1));
	return $categories[int($catID)-1];
}

sub getInputInteractive()
{
	print "\n\t----------------------------------------------------------------------------\n";
	print "\t   EmbedJournal.com  - Add a brain to eveything with embedded electronics       ";
	print "\n\t----------------------------------------------------------------------------\n";

	print "\n\tWelcome Author, Give your article a title. be sure to keep the title attractive\n";
	print   "\tmeaningful and short. This how your post will be called once it is published\n";
	print   "\tThink what your readers will search for when they have to reach your post. Use\n";
	print   "\tthose keywords in the post title so your post will be ranked well at google.\n\n";

	my $t = readInput("Post title");

	print "\n\tGive a nickname by which you would like to be refered to. It is important that\n";
	print   "\tyou stick to the same name as this how you will be called in all your posts. so\n";
	print   "\tthis is usually not not your full name.\n\n";

	my $a = readInput("Author's name");
	$a =~ s/(\w\S*)/\u\L$1/g;

	print "\n\tCurrently we support the following categories. Choose the broad field that best\n";
	print   "\tsuits your content. If your field is not here, or you have some doubts mail one\n";
	print   "\tother authors and they should be able to help you out.\n\n";

	my $c = getCategory();

	return ($t, $a, $c);
}

sub createDraft()
{
	my ($title, $author, $category) = getInputInteractive();

	my $slug = getSlug($title);
	my $date = strftime '%Y:%m:%dT%H:%M:%S%z', localtime();
	my $name = getFileName($slug);
	my $catSlug = getSlug($category);
	my $mdFile = "drafts/$name/$name.md";
	my $imagePath = "drafts/$name";
	print "\n$imagePath will be created with with the following information,\n\n";
	print "title: \"$title\"\n";
	print "author: $author\n";
	print "category: $category\n";
	print "\n";

	if (readInput("Do you wish to proceed? [y/N]") !~ /y/i) {
		return;
	}

	print "Generating post related files at $imagePath ...\n";
	system("mkdir -p $imagePath");
	open(my $F, ">", $mdFile);

	die "Unable to open file $mdFile\n" unless defined $F;

	print $F "---\n";
	print $F "published: false\n";
	print $F "title: \"$title\"\n";
	print $F "date_created: $date\n";
	print $F "author: $author\n";
	print $F "thumbnail: \n";
	print $F "permalink: /$slug/\n";
	print $F "category: \"$category\"\n";
	print $F "tags: [  ]\n";
	print $F "---\n\n";
	print $F "This is the first paragraph. Delete this to start writing you content. You dont\n";
	print $F "have to put your title before content. We will do that for you. Just start writing!\n";

	print "\nCreated new draft at $imagePath.\n";
	print "Happy Blogging!\n\n";
}

sub main()
{
	createDraft() if $newPost;
	if (defined $packPostPath) {
		die "Unable to find $packPostPath. Should be path to post directory." unless (-d $packPostPath);
		my $zipName = strftime ('%y%m%d', localtime()) . "_post.tar.gz";
		system("tar", "czf", $zipName, $packPostPath);
	}
}

main();
