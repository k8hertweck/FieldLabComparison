#!/bin/bash

# download and extract raw data from SRA for microbiome analysis
# requires list of accession numbers (which should have associated metadata in another file, for later use)

cd `pwd`

mkdir SRP018246 SRP018247
cut -f 6 data/SraRunTableSRP018246.txt | tail +2 > SRP018246.lst
cut -f 6 data/SraRunTableSRP018246corrected.txt | tail +2 > SRP018247.lst


# download  Trachymyrmex/Cyphomyrmex (need metadata corrected)
cd SRP018246
for x in `cat ../SRP018246.lst`
	do
		fastq-dump $x
done

# download Mycocepurus (no changes to data needed)
cd ../SRP018247
for x in `cat ../SRP018247.lst`
	do
		fastq-dump $x
done
