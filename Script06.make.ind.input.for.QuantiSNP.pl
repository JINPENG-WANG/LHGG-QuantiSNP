#!/usr/bin/perl -w
use strict;
use IO::File;
my $finalreport_file = shift @ARGV;
my $fh_snpmap=IO::File->new("Bovine_50K_SNP_Map.txt",'r');
my %snpmap;
my $snpmap_line=0;
while(<$fh_snpmap>){
	chomp;
	my $line = $_;
	$snpmap_line++;
	if($snpmap_line>1){
		my @eles = split /\s+/, $line;
		my ($snpid,$chr,$pos)=@eles[1,2,3];
		if($chr eq "X"){
			$chr=30;
		}
		$snpmap{$snpid}{chr}=$chr;
		$snpmap{$snpid}{pos}=$pos;
	}
}

# my $fh_signal_for_quantisnp=IO::File->new(">lhgg.signal.for.quantisnp.txt");
#$fh_signal_for_quantisnp->print("Sample ID\tSNP Name\tChromosome\tPosition\tLog R Ratio\tB Allele Freq\n");
my %indsignals;
	my $fh_fr_in = IO::File->new("$finalreport_file",'r');
	my $n;
	if($finalreport_file=~/\d+_BAF_LR_\d+_(\d+)\.FinalReport\.txt/){
		$n=$1;
	}
	mkdir "quantiSNPsignalfiles/n$n";
	my $line_count_fr=0;
	while(<$fh_fr_in>){
		chomp;
		my $line = $_;
		$line_count_fr++;
		if($line_count_fr>10){
			my @eles = split /\s+/, $line;
			my ($snpid,$sampleid,$baf,$lrr)=@eles[0,1,11,12];
			my $chr = $snpmap{$snpid}{chr};
			my $pos = $snpmap{$snpid}{pos};
			if(exists $indsignals{$sampleid}){
				my $fh_out = $indsignals{$sampleid};
				$fh_out->print("$snpid\t$chr\t$pos\t$lrr\t$baf\n");
			}
			else{
				my $fh_out = IO::File->new(">quantiSNPsignalfiles/n$n/$sampleid.signals.txt");
				$indsignals{$sampleid}=$fh_out;
				$indsignals{$sampleid}->print("SNP Name\tChromosome\tPosition\tLog R Ratio\tB Allele Frequency\n");
				$indsignals{$sampleid}->print("$snpid\t$chr\t$pos\t$lrr\t$baf\n");
			}
		}
	}
