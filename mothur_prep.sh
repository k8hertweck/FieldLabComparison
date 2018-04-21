## Microbiome Ant Field vs Lab Analysis OTUs using mothur

# usage: ./mothur_prep.sh OR bash mothur_prep.sh
# execute within project directory
# for explanation of commands: https://www.mothur.org/wiki/Sequence_processing

cd `pwd`

cd data

#convert fastq files fasta + qual files
for x in `cat SRP018246.lst`
	do
		mothur "#fastq.info(fastq=SRP018246/$x.fastq)"
done
#for x in `cat SRP018247.lst`
#	do
#		mothur "fastq.info(fastq=SRP018247/$x.fastq)"
#done

rm *.logfile

# move fasta and qual files to analysis/
cd ..
mkdir analysis
mv data/*/*.fasta data/*/*.qual analysis/
cd analysis

# trim sequences for quality
# output files: trim.fasta, scrap.fasta, trim.qual, and scrap.qual files
ls *.fasta | sed s/\.fasta// > all.lst
for x in `cat all.lst`
	do
		mothur "#trim.seqs(fasta=$x.fasta, qfile=$x.qual, maxambig=1, maxhomop=8, flip=T, qaverage=25, minlength=200, processors=6)"
done

# create group file
# output mergegroups
mothur "#make.group(fasta=SRR655327.trim.fasta-SRR655328.trim.fasta-SRR655329.trim.fasta-SRR655330.trim.fasta-SRR655331.trim.fasta-SRR655332.trim.fasta-SRR655333.trim.fasta-SRR655334.trim.fasta-SRR655335.trim.fasta-SRR655336.trim.fasta-SRR655337.trim.fasta-SRR655338.trim.fasta-SRR655339.trim.fasta-SRR655340.trim.fasta-SRR655341.trim.fasta-SRR655342.trim.fasta-SRR655343.trim.fasta-SRR655344.trim.fasta-SRR655345.trim.fasta-SRR655346.trim.fasta-SRR655347.trim.fasta-SRR655348.trim.fasta-SRR655349.trim.fasta-SRR655350.trim.fasta-SRR655351.trim.fasta-SRR655352.trim.fasta-SRR655353.trim.fasta-SRR655354.trim.fasta-SRR655355.trim.fasta-SRR655356.trim.fasta-SRR655357.trim.fasta-SRR655358.trim.fasta-SRR655359.trim.fasta-SRR655360.trim.fasta-SRR655361.trim.fasta-SRR655362.trim.fasta-SRR655363.trim.fasta-SRR655364.trim.fasta, groups=field-field-field-field-lab-lab-lab-lab-field-field-field-field-field-field-lab-lab-lab-lab-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field)"

# rename groups file
cp mergegroups analysis.groups

# make master fasta file (combines individual fasta files into a single file, analysis.fasta)
mothur "#merge.files(input=SRR655327.trim.fasta-SRR655328.trim.fasta-SRR655329.trim.fasta-SRR655330.trim.fasta-SRR655331.trim.fasta-SRR655332.trim.fasta-SRR655333.trim.fasta-SRR655334.trim.fasta-SRR655335.trim.fasta-SRR655336.trim.fasta-SRR655337.trim.fasta-SRR655338.trim.fasta-SRR655339.trim.fasta-SRR655340.trim.fasta-SRR655341.trim.fasta-SRR655342.trim.fasta-SRR655343.trim.fasta-SRR655344.trim.fasta-SRR655345.trim.fasta-SRR655346.trim.fasta-SRR655347.trim.fasta-SRR655348.trim.fasta-SRR655349.trim.fasta-SRR655350.trim.fasta-SRR655351.trim.fasta-SRR655352.trim.fasta-SRR655353.trim.fasta-SRR655354.trim.fasta-SRR655355.trim.fasta-SRR655356.trim.fasta-SRR655357.trim.fasta-SRR655358.trim.fasta-SRR655359.trim.fasta-SRR655360.trim.fasta-SRR655361.trim.fasta-SRR655362.trim.fasta-SRR655363.trim.fasta-SRR655364.trim.fasta, output=analysis.trim.fasta)"

# make master qual file
mothur "#merge.files(input=SRR655327.trim.qual-SRR655328.trim.qual-SRR655329.trim.qual-SRR655330.trim.qual-SRR655331.trim.qual-SRR655332.trim.qual-SRR655333.trim.qual-SRR655334.trim.qual-SRR655335.trim.qual-SRR655336.trim.qual-SRR655337.trim.qual-SRR655338.trim.qual-SRR655339.trim.qual-SRR655340.trim.qual-SRR655341.trim.qual-SRR655342.trim.qual-SRR655343.trim.qual-SRR655344.trim.qual-SRR655345.trim.qual-SRR655346.trim.qual-SRR655347.trim.qual-SRR655348.trim.qual-SRR655349.trim.qual-SRR655350.trim.qual-SRR655351.trim.qual-SRR655352.trim.qual-SRR655353.trim.qual-SRR655354.trim.qual-SRR655355.trim.qual-SRR655356.trim.qual-SRR655357.trim.qual-SRR655358.trim.qual-SRR655359.trim.qual-SRR655360.trim.qual-SRR655361.trim.qual-SRR655362.trim.qual-SRR655363.trim.qual-SRR655364.trim.qual, output=analysis.trim.qual)"

rm *.logfile