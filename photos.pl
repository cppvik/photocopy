#!/usr/bin/perl

use strict;
use File::Copy qw/move/;

my $dir = shift @ARGV;
my $ddir = shift @ARGV;
my $basename;
my $destdir;
my @files = <$dir/*.NEF>;
foreach my $file (@files) {
	my ($year, $month, $day, $hour, $minute, $second) = split(/[:\ ]/, `exiftool -b -CreateDate $file`);
	$basename = `basename $file`;
	$basename =~ s/^\s+|\s+$//g;
	# $basename = "$year-$month-${day}_$hour-$minute-$second.NEF";
	# print "basename: $basename\n";
	$destdir = "$ddir/$year/$month/$day";
	$destdir =~ s/^\s+|\s+$//g;
	print "$destdir/$basename\n";
	system("mkdir -p $destdir");
	if (! -f "$destdir/$basename")
	{
		move($file, "$destdir/$basename");
	}
}
