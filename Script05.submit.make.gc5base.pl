#!/usr/bin/perl -w
use strict;
use IO::File;
my @nucs = <GK*.nuc>;
for my $nuc (@nucs){
	
	system "bsub -o out.S05  perl Script04.make.gc5Base.pl $nuc";
}
