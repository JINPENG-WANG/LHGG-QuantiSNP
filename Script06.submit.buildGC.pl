#!/usr/bin/perl -w
use strict;
use IO::File;
for my $chr (1..29){
	my $file = "$chr.gc5base.txt";
	my $cmd="perl buildGC.for.quantiSNP.pl  $file";
	system "bsub -o out.S6 '$cmd'";
}
