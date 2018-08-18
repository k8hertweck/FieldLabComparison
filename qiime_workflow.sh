#!/bin/bash
#execute this script in main project directory
#requires mapping file and parameters file

cd `pwd`

# activate qiime 1
source activate qiime1

#convert fastq files to fasta and qual files and place those files in the analysis directory
cd data/SRP018246
for x in `cat ../SRP018246.lst`
	do
		convert_fastaqual_fastq.py -f $x.fastq -c fastq_to_fastaqual -o ../../analysis
done

cd ../SRP018247
for x in `cat ../SRP018247.lst`
	do
		convert_fastaqual_fastq.py -f $x.fastq -c fastq_to_fastaqual -o ../../analysis
done

cd ../../

#create a combined_seqs.fna file with all fasta files to be analysed
add_qiime_labels.py -i analysis -c InputFileName -m metadata_mapping_file.txt -o seqs.fna

#move combined_seqs.fna file to analysis folder
mv seqs.fna/combined_seqs.fna analysis/combined_seqs.fna

#remove empty directory
rmdir seqs.fna

#setting up silva reference & taxonomy files for assign taxonomy step in pick_de_novo_otus.py script
cd silva

#download qiime-compatible silva 128 release
wget "https://www.arb-silva.de/fileadmin/silva_databases/qiime/Silva_128_release.tgz"

#decompress qiime-compatible silva 128 release
tar xvzf Silva_128_release.tgz

cd ..
#copy qiime-compatible silva 128 release reference file to silva directory
cp silva/Silva_128_QIIME_release/rep_set/rep_set_16S_only/97/97_otus_16S.fasta silva/

#copy qiime-compatible silva 128 release taxonomy file to silva directory
cp silva/Silva_128_QIIME_release/taxonomy/16S_only/97/consensus_taxonomy_all_levels.txt silva/

#run qiime workflow with parameter file
pick_de_novo_otus.py -i analysis/combined_seqs.fna -p qiime_parameters.txt -o results
