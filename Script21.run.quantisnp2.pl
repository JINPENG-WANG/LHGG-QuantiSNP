#!/usr/bin/perl -w
use strict;
use IO::File;
chomp(my $path=`pwd`);
chdir "01.data/02.signals";
my @subdir=qw(n193 n196 n200 n268 n279 n285 n294 n398 n399 n94 n96);
for my $subdir (@subdir){
	chdir "$path/01.data/02.signals/$subdir";
	my @indsigs=<*.txt>;
	for my $indsig (@indsigs){
		my $indid;
		if($indsig=~/(\w+)\.signals\.txt/){
			$indid=$1;
		}
		chdir "$path";
		mkdir "$path/02.out/$subdir";
		my $cmd="bash run_quantisnp2.sh  /public/home/wangjinpeng/03.software/matlab/v79/  --chr 1:29  --outdir 02.out/$subdir --sampleid $indid --gender female --gcdir 00.gc5base/lhgggc5base   --config params.dat  --levels levels.dat   --emiters  10  --lsetting 2000000 --plot --genotype --input-files 01.data/02.signals/$subdir/$indsig  --logfile log/$indid.log --chrX 30 ";
		system "bsub -o out.S.run.quantisnp2.gc -n 8 -R span[hosts=1] '$cmd'";
	}
}
