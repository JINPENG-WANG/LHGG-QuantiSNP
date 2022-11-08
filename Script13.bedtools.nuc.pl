#!/usr/bin/perl -w
use strict;
use IO::File;
my @windows5base=<GK*.windows.5base>;
for my $window5base (@windows5base){
	my $chr;
	if($window5base=~/(.+)\.windows.5base/){
		$chr=$1;
		my $cmd="bedtools nuc -fi GCA_000003055.5_Bos_taurus_UMD_3.1.1_genomic.fna -bed $window5base > $chr.nuc";
		system "bsub -o out.bedtools.nuc '$cmd'";
	}
}
