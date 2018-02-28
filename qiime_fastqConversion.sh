#!/bin/bash
#execute this script in main project directory

# activate qiime 1
cd `pwd`

# activate qiime 1
source activate qiime1

#convert fastq files to fasta and qual files and place those files in the analysis directory
cd data/SRP018246
for x in `cat ../SRP018246.lst`
	do
		convert_fastaqual_fastq.py -f $x.fastq -c fastq_to_fastaqual -o ../analysis
done

cd ../SRP018247
for x in `cat ../SRP018247.lst`
	do
		convert_fastaqual_fastq.py -f $x.fastq -c fastq_to_fastaqual -o ../analysis
done