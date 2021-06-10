#!/usr/bin/perl

my $ucscGTF    = $ARGV[0];
my $id2Entrez  = $ARGV[1];
my $entrezName = $ARGV[2];

##	getting the annotation information
my $map2Entrez    = getEntrez($id2Entrez); 
my $mouseGeneName = getEntrezName($entrezName);

##	Modify the UCSC download gtf file

open (IN, $ucscGTF) || die "can't open $1!"; 
while (my $lineIN=<IN>)
{
	chomp ($lineIN);
	@ins = split /\t/, $lineIN;
	@temp = split /;/, $ins[8];
	$temp[0] =~ s/gene_id \"(\S+)\"//g;
	if (exists $$map2Entrez{$1})
	{
		$entrezID   = $$map2Entrez{$1};
		$entrezName = $$mouseGeneName{$entrezID};
		my $modGeneID = "gene_id \"".$entrezName."|".$entrezID.";\" ".$temp[1];
		my $line = join ("\t", @ins[0..7]);
		$line = $line."\t".$modGeneID;
		print "$line\n";
	}else{
#		print "$lineIN\n";
	}
}
close(IN);
exit(0); 

##========================
##	Subroutines
##=======================

sub getEntrezName
{
        $f = shift;
        my %entrezName = {};
        open (IN, $f) || die "can't open $1!";
	(<IN>);
        while (<IN>)
        {
                chomp;
                @ins = split /\t/, $_;
                next if ( exists $entrezName{$ins[1]}) ;
                $entrezName{$ins[1]}=$ins[2];
        }
        close(IN);
        return (\%entrezName);
}
sub getEntrez
{
	$f = shift;
	my %entrezHash = {};
	open (IN, $f) || die "can't open $1!";
	while (<IN>)
	{
        	chomp;
		next if ( $_ !~ /^10090/ ); 
		@ins = split /\t/, $_;
		next if ( exists $entrezHash{$ins[2]}) ; 
		$entrezHash{$ins[2]}=$ins[1];
	}
	close(IN);
	return (\%entrezHash);        
}
__END__

##=======================================
##	sample input information	=
##=======================================

chr1    mm10_ncbiRefSeq stop_codon      134202951       134202953       0.000000        -       .       gene_id "NM_001291928.1"; transcript_id "NM_001291928.1";

release96.accession2geneid 
10020   105980079       XM_013012534.1  XP_012867988.1
10020   105980080       XM_013009162.1  XP_012864616.1
Mus_musculus.gene_info

10090   11539   Adora1  -       A1-AR|A1AR|A1R|AA1R|AI848715|ARA1|BB176431|Ri   MGI:MGI:99401|Ensembl:ENSMUSG00000042429        1       1|1 E4  adenosine A1 receptor   protein-coding  Adora1  adenosine A1 receptor   O       adenosine receptor A1   20191028   -

gene_id "DDX11L1|100287102|locus1of1";
