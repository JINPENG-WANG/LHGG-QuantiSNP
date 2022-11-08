#!/usr/bin/perl -w
use strict;
use IO::File;
my @frs=<*.FinalReport.txt>;
for my $fr (@frs){
	system "bsub -o out.$fr perl Script06.make.ind.input.for.QuantiSNP.pl  $fr";
}

