use FileCache;
$infile=shift @ARGV;
#$infile = "lhgg.gc5Base.txt"; # input file (hgXX.gc5Base.txt downloadable from USCS)
$outdir = "lhgggc5base/"; # output directory
$nWin = 200; # number 5 bp windows to use for each 1kb region 

open(INFILE, $infile) or die "Cannot read $infile\n";

	$gcTotal = 0;
	$winCount = $nWin;
	$startPos = 0;
	$endPos = 0;

	while( $line = <INFILE> ) {
	
		chomp($line);
	
		# check if we have started a new chromosome and get chromosome number
		if( $line =~ /variableStep/ ) {
		
			( $tmp1, $chr, $tmp2 ) = split(/ /, $line);
			( $tmp3, $chr) = split(/=chr/, $chr);
		
			print "$chr\n";
			
			next;
			
		}
		
		# read position and gc content 
		( $pos, $gc ) = split(/\t/, $line);
		
		# if we have started a new 1kb region then store start position
		if ( $winCount == $nWin ) {
			$startPos = $pos;
		}
		
		# if we have not reached the end of the 1kb window, then accumulate GC 
		if ( $winCount > 0 ) {
		
			$gcTotal = $gcTotal + $gc;
			$winCount--;
		
		} else {
		
			# if we have reached the end of the 1kb window, then calculate average GC and write to file
			$endPos = $pos;
			$gcContent = $gcTotal/$nWin;
			
			$path = "$outdir/" . $chr ."_1k.txt";
			cacheout ">", $path;
			print $path "$startPos\t$endPos\t$gcContent\n";
			
			$winCount = $nWin;
			$gcTotal = 0;
		}

	}

close(INFILE);
