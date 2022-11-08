#!/usr/bin/perl -w
use strict;
use IO::File;

	my $nuc=shift @ARGV;
	my $chr;
	if($nuc=~/GK(\d+)\.2\.nuc/){
		$chr=$1/1;
	}
	my $fh_in = IO::File->new("$nuc",'r');
	my $fh_out = IO::File->new(">$chr.gc5base.txt");
	$fh_out->print("variableStep chrom=chr$chr span=5\n");
	my $line_count=0;
	while(<$fh_in>){
		my $line = $_;
		$line_count++;
		if($line_count>1){
			my @eles = split /\s+/, $line;
			my ($start,$gc)=@eles[1,4];
			$gc=$gc*100;
			$start=$start+1;
			$fh_out->print("$start\t$gc\n");
		}
	}

