#!/usr/bin/perl -w
use strict;
use IO::File;
my @files = <*length>;
for my $file (@files){
	my $chr;
	if($file=~/(.+)\.length/){
		$chr=$1;
	}

	my $cmd ="bedtools makewindows -g $file -w 5 > $chr.windows.5base";
	system "bsub -o out.S02 '$cmd'";
}

