#!/usr/bin/perl
#$ -cwd

## to build genome FASTA from UCSC files

use Net::FTP;

$species = $ARGV[0];    # e.g. "Homo_sapiens"; "Mus_musculus"
$sp = $ARGV[1];         # e.g. "hg19"; "mm10"


$ucschost = "hgdownload.cse.ucsc.edu";
$ftp = Net::FTP->new("$ucschost", Debug => 0) or die "Cannot connect to some.host.name: $@";
$ftp->login("anonymous",'-anonymous@') or die "Cannot login ", $ftp->message;

$dir = $sp; system "mkdir $dir";
@files = $ftp->ls("goldenPath/currentGenomes/$species/chromosomes");
foreach $f (@files) {
  next unless ($f =~ /\.fa\.gz/);
  @ar1 = split/\//, $f;
  system "wget -q -O $dir/$ar1[$#ar1] ftp://$ucschost/$f";
}
system "wget -q -O $dir/md5sum.txt ftp://$ucschost/goldenPath/currentGenomes/$species/chromosomes/md5sum.txt";

open(CHK, "$dir/md5sum.txt"); @chk = <CHK>; close(CHK);
open(LOG, ">$sp.log");
@forfa = ();
foreach $line (@chk) {
  @ar1 = split/\s+/, $line; $md5sum = $ar1[0]; $file = $ar1[1];
  if (-e "$dir/$file") {
    $chkmd5sum = `md5sum $dir/$file`;
    @ar2 = split/\s+/, $chkmd5sum;
    if ($ar2[0] eq $md5sum) { print LOG "$file\tSUCCESS\n"; push @forfa, "$dir/$file"; }
    else { print LOG "$file\tFAILED\n"; }
  }
  else { print LOG "$file\tFAILED\n"; }
}
close(LOG);

foreach $file (@forfa) {
  system "gunzip $file";
  $file =~ s/\.gz//;
  system "cat $file >> $sp.fa";
  system "gzip $file";
}

