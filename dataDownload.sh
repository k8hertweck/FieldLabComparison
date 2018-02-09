#!/bin/bash

# download and extract raw data from SRA for microbiome analysis
# requires list of accession numbers (which should have associated metadata in another file, for later use)

cd `pwd`

#setting up silva reference file in silva directory
#download silva reference file version 128
wget https://www.mothur.org/w/images/b/b4/Silva.nr_v128.tgz

#untar and gunzip silva reference file
tar -zxvf Silva.nr_v128.tgz

#move silva.nr_v128.align reference file  to silva directory
mv silva.nr_v128.align silva/

#removing unnecessary silva files and mothur logfiles
rm *.logfile
rm *.nr_v128.*

#setting up data files and directories
mkdir data/SRP018246 data/SRP018247
cut -f 6 data/SraRunTableSRP018246corrected.txt | tail +2 > data/SRP018246.lst
cut -f 6 data/SraRunTableSRP018247.txt | tail +2 > data/SRP018247.lst

# download  Trachymyrmex/Cyphomyrmex
cd data/SRP018246
for x in `cat ../SRP018246.lst`
	do
		fastq-dump $x
done

# download Mycocepurus
cd ../SRP018247
for x in `cat ../SRP018247.lst`
	do
		fastq-dump $x
done
