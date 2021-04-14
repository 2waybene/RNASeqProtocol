#!/bin/bash/

# This script takes a fastq file of RNA-Seq data, runs FastQC and outputs a counts file for it.
# USAGE: sh rnaseq_analysis_on_allfiles.sh <name of fastq file>

# initialize a variable with an intuitive name to store the name of the input fastq file

fq=$1

# grab base of filename for naming outputs

file=`basename $fq`
if [[ $file =~ ^(.*)(_1\.fq.gz)$ ]]; 
then 
  base=${BASH_REMATCH[1]} ; 
else 
  echo "Not proper format"; 
fi


# specify the number of cores to use


##	trouble shoot, using Sara gtf and STAR_index

#	set up output filenames and locations


mm10_kallisto_index=/ddn/gs1/home/li11/refDB/mm10/kallistoIndex/kallistoMM10
kalliso_out=/ddn/gs1/home/li11/project2019/RNAseqProj/results/Kallisto/${base}".kallisto"
fq1=/ddn/gs1/home/li11/project2019/RNAseqProj/raw_data/${base}"_1.fq.gz"
fq2=/ddn/gs1/home/li11/project2019/RNAseqProj/raw_data/${base}"_2.fq.gz"
script=/ddn/gs1/home/li11/project2019/RNAseqProj/scripts/executeScripts/$base"_analysis.sh"

# Produce  STAR script

echo "salmon quant -i $mm10_kallisto_index  -l MU -1 <(zcat -c $fq1 ) -2 <(zcat -c $fq2 ) -o $kalliso_out "  > $script

echo "" >>  $script









#salmon quant -i /ddn/gs1/home/li11/refDB/mm10/salmonIndex/mm10_salmon_index  -l MU -1 <(zcat -c /ddn/gs1/home/li11/project2021/RNAProj/rawData/usftp21.novogene.com/raw_data/E59A_1/E59A_1_1.fq.gz ) -2 <(zcat -c /ddn/gs1/home/li11/project2021/RNAProj/rawData/usftp21.novogene.com/raw_data/E59A_1/E59A_1_2.fq.gz ) -o /ddn/gs1/home/li11/project2021/RNAProj/results/Salmon/E59A_1.salmon 

