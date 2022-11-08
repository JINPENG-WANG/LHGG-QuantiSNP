#!/usr/bin/perl -w
use strict;
use IO::File;
my $fh_in = IO::File->new("UMD.chrs.length",'r');
while(<$fh_in>){
	chomp;
	my ($chr, $length)= split /\s+/, $_;
	my $fh_out = IO::File->new(">$chr.length");
	$fh_out->print("$chr\t$length\n");
}
