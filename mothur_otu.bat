## Microbiome Ant Field vs Lab Analysis OTUs using mothur

# execute within project directory

#convert fastq files fasta + qual files
fastq.info(fastq=~/Desktop/SRP018246/SRR655327.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655328.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655329.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655330.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655331.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655332.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655333.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655334.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655335.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655336.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655337.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655338.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655339.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655340.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655341.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655342.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655343.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655344.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655345.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655346.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655347.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655348.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655349.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655350.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655351.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655352.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655353.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655354.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655355.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655356.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655357.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655358.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655359.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655360.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655361.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655362.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655363.fastq)
fastq.info(fastq=~/Desktop/SRP018246/SRR655364.fastq)

# create group file
# input fasta file and the group names; output mergegroups
make.group(fasta=~/Desktop/SRP018246/SRR655327.fasta-~/Desktop/SRP018246/SRR655328.fasta-~/Desktop/SRP018246/SRR655329.fasta-~/Desktop/SRP018246/SRR655330.fasta-~/Desktop/SRP018246/SRR655331.fasta-~/Desktop/SRP018246/SRR655332.fasta-~/Desktop/SRP018246/SRR655333.fasta-~/Desktop/SRP018246/SRR655334.fasta-~/Desktop/SRP018246/SRR655335.fasta-~/Desktop/SRP018246/SRR655336.fasta-~/Desktop/SRP018246/SRR655337.fasta-~/Desktop/SRP018246/SRR655338.fasta-~/Desktop/SRP018246/SRR655339.fasta-~/Desktop/SRP018246/SRR655340.fasta-~/Desktop/SRP018246/SRR655341.fasta-~/Desktop/SRP018246/SRR655342.fasta-~/Desktop/SRP018246/SRR655343.fasta-~/Desktop/SRP018246/SRR655344.fasta-~/Desktop/SRP018246/SRR655345.fasta-~/Desktop/SRP018246/SRR655346.fasta-~/Desktop/SRP018246/SRR655347.fasta-~/Desktop/SRP018246/SRR655348.fasta-~/Desktop/SRP018246/SRR655349.fasta-~/Desktop/SRP018246/SRR655350.fasta-~/Desktop/SRP018246/SRR655351.fasta-~/Desktop/SRP018246/SRR655352.fasta-~/Desktop/SRP018246/SRR655353.fasta-~/Desktop/SRP018246/SRR655354.fasta-~/Desktop/SRP018246/SRR655355.fasta-~/Desktop/SRP018246/SRR655356.fasta-~/Desktop/SRP018246/SRR655357.fasta-~/Desktop/SRP018246/SRR655358.fasta-~/Desktop/SRP018246/SRR655359.fasta-~/Desktop/SRP018246/SRR655360.fasta-~/Desktop/SRP018246/SRR655361.fasta-~/Desktop/SRP018246/SRR655362.fasta-~/Desktop/SRP018246/SRR655363.fasta-~/Desktop/SRP018246/SRR655364.fasta, groups=field-field-field-field-lab-lab-lab-lab-field-field-field-field-field-field-lab-lab-lab-lab-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field)

# use mothur system command to copy file to new name
system(cp ~/Desktop/SRP018246/mergegroups ~/Desktop/SRP018246/SRP018246.groups)

# make master fasta file (combines individual fasta files into a single file, ~/Desktop/SRP018246.fasta)
merge.files(input=~/Desktop/SRP018246/SRR655327.fasta-~/Desktop/SRP018246/SRR655328.fasta-~/Desktop/SRP018246/SRR655329.fasta-~/Desktop/SRP018246/SRR655330.fasta-~/Desktop/SRP018246/SRR655331.fasta-~/Desktop/SRP018246/SRR655332.fasta-~/Desktop/SRP018246/SRR655333.fasta-~/Desktop/SRP018246/SRR655334.fasta-~/Desktop/SRP018246/SRR655335.fasta-~/Desktop/SRP018246/SRR655336.fasta-~/Desktop/SRP018246/SRR655337.fasta-~/Desktop/SRP018246/SRR655338.fasta-~/Desktop/SRP018246/SRR655339.fasta-~/Desktop/SRP018246/SRR655340.fasta-~/Desktop/SRP018246/SRR655341.fasta-~/Desktop/SRP018246/SRR655342.fasta-~/Desktop/SRP018246/SRR655343.fasta-~/Desktop/SRP018246/SRR655344.fasta-~/Desktop/SRP018246/SRR655345.fasta-~/Desktop/SRP018246/SRR655346.fasta-~/Desktop/SRP018246/SRR655347.fasta-~/Desktop/SRP018246/SRR655348.fasta-~/Desktop/SRP018246/SRR655349.fasta-~/Desktop/SRP018246/SRR655350.fasta-~/Desktop/SRP018246/SRR655351.fasta-~/Desktop/SRP018246/SRR655352.fasta-~/Desktop/SRP018246/SRR655353.fasta-~/Desktop/SRP018246/SRR655354.fasta-~/Desktop/SRP018246/SRR655355.fasta-~/Desktop/SRP018246/SRR655356.fasta-~/Desktop/SRP018246/SRR655357.fasta-~/Desktop/SRP018246/SRR655358.fasta-~/Desktop/SRP018246/SRR655359.fasta-~/Desktop/SRP018246/SRR655360.fasta-~/Desktop/SRP018246/SRR655361.fasta-~/Desktop/SRP018246/SRR655362.fasta-~/Desktop/SRP018246/SRR655363.fasta-~/Desktop/SRP018246/SRR655364.fasta, output=~/Desktop/SRP018246/~/Desktop/SRP018246.fasta)

# make master qual file
merge.files(input=~/Desktop/SRP018246/SRR655327.qual-~/Desktop/SRP018246/SRR655328.qual-~/Desktop/SRP018246/SRR655329.qual-~/Desktop/SRP018246/SRR655330.qual-~/Desktop/SRP018246/SRR655331.qual-~/Desktop/SRP018246/SRR655332.qual-~/Desktop/SRP018246/SRR655333.qual-~/Desktop/SRP018246/SRR655334.qual-~/Desktop/SRP018246/SRR655335.qual-~/Desktop/SRP018246/SRR655336.qual-~/Desktop/SRP018246/SRR655337.qual-~/Desktop/SRP018246/SRR655338.qual-~/Desktop/SRP018246/SRR655339.qual-~/Desktop/SRP018246/SRR655340.qual-~/Desktop/SRP018246/SRR655341.qual-~/Desktop/SRP018246/SRR655342.qual-~/Desktop/SRP018246/SRR655343.qual-~/Desktop/SRP018246/SRR655344.qual-~/Desktop/SRP018246/SRR655345.qual-~/Desktop/SRP018246/SRR655346.qual-~/Desktop/SRP018246/SRR655347.qual-~/Desktop/SRP018246/SRR655348.qual-~/Desktop/SRP018246/SRR655349.qual-~/Desktop/SRP018246/SRR655350.qual-~/Desktop/SRP018246/SRR655351.qual-~/Desktop/SRP018246/SRR655352.qual-~/Desktop/SRP018246/SRR655353.qual-~/Desktop/SRP018246/SRR655354.qual-~/Desktop/SRP018246/SRR655355.qual-~/Desktop/SRP018246/SRR655356.qual-~/Desktop/SRP018246/SRR655357.qual-~/Desktop/SRP018246/SRR655358.qual-~/Desktop/SRP018246/SRR655359.qual-~/Desktop/SRP018246/SRR655360.qual-~/Desktop/SRP018246/SRR655361.qual-~/Desktop/SRP018246/SRR655362.qual-~/Desktop/SRP018246/SRR655363.qual-~/Desktop/SRP018246/SRR655364.qual, output=~/Desktop/SRP018246/~/Desktop/SRP018246.qual)

# trim sequences when average quality score in 50-by sliding window drops below 35
# remove the barcode and primer sequences: for 200 bp long sequences, remove any with homopolymers >8 bp, reverse complement each sequence
# input files: fasta and qual files, output files: trim.fasta, scrap.fasta, trim.qual, and scrap.qual files
trim.seqs(fasta=~/Desktop/SRP018246/~/Desktop/SRP018246.fasta, qfile=~/Desktop/SRP018246/~/Desktop/SRP018246.qual, maxambig=0, maxhomop=8, flip=T, bdiffs=1, pdiffs=2, qwindowaverage=35, qwindowsize=50, minlength=200, processors=2)

# inspect trimmed sequences
#input: fasta file, output: summary file
summary.seqs(fasta=~/Desktop/SRP018246/~/Desktop/SRP018246.fasta)

# simplifying the dataset to only unique sequences
#input: fasta file, output: names file, unique.fasta file
unique.seqs(fasta=~/Desktop/SRP018246/~/Desktop/SRP018246.fasta)

# inspect unique sequences
# input: unique.fasta file, output: unique.summary file
summary.seqs(fasta=~/Desktop/SRP018246/~/Desktop/SRP018246.unique.fasta, name=~/Desktop/SRP018246/~/Desktop/SRP018246.names)
