#!/bin/bash

# checking SRA metadata against archived sff files
# usage: ./dataCheck.sh
# execute from GitHub directory
# dependencies: seq_crumbs https://bioinf.comav.upv.es/seq_crumbs/

# SraRunTableSRP018247.txt (Trachymyrmex/Cyphomyrmex) is OK
# SraRunTableSRP018246.txt (Mycocepurus) requires corrections

SCRIPTS=~/GitHub/FieldLabComparison
CRUMBS=/Applications/seq_crumbs-0.1.9/bin
RAW=/Volumes/Seagate/KellnerOrtizSequenceAnalysis/MuellerSff06292011

cd data/

# create list of samples where library name doesn't match sample name
sed s/454Reads.//g SraRunTableSRP018246.txt | tail +2 | awk '{
	if ($3 == $8)
		echo -n
	else 
		print $8
}' > $SCRIPTS/data/problems.lst

# convert sff to fastq 
cd $RAW
for x in `cat $SCRIPTS/data/problems.lst`
	do	
		echo $x
		$CRUMBS/sff_extract -o $x.fastq --min_left_clip 22 454Reads.$x*
done

# manually compare SRA data and fastq from archived sff
# replace sample names in metadata sheet
# export new metadata sheet as SraRunTableSRP018246corrected.txt
