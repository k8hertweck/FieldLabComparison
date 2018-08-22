#!/bin/bash

## Downloading sequence data from SRA and silva database for microbiome analysis

# usage: ./dataDownload.sh OR bash dataDownload.sh
# execute in project directory
# requires list of accession numbers (which should have associated metadata in another file, for later use)
# currently set for Linux/Ubuntu, uncomment appropriate lines for Mac usage

cd `pwd`

# setting up silva reference file in silva directory
# download silva reference file version 128
# Mac
curl https://www.mothur.org/w/images/b/b4/Silva.nr_v128.tgz -o Silva.nr_v128.tgz
# Linux/Ubuntu
#wget https://www.mothur.org/w/images/b/b4/Silva.nr_v128.tgz

# untar and gunzip silva reference file and send to directory
tar -zxvf Silva.nr_v128.tgz -C silva/
# remove tarball
rm *.tgz

# setting up data files and directories
mkdir data/SRP018246 data/SRP018247
# Mac
cut -f 6 data/SraRunTableSRP018246corrected.txt | tail +2 | sort > data/SRP018246.lst
cut -f 6 data/SraRunTableSRP018247.txt | tail +2 | sort > data/SRP018247.lst
# Linux/Ubuntu
#cut -f 6 data/SraRunTableSRP018246corrected.txt | tail --lines=+2 | sort > data/SRP018246.lst
#cut -f 6 data/SraRunTableSRP018247.txt | tail --lines=+2 | sort > data/SRP018247.lst

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
