## Microbiome Ant Field vs Lab Analysis OTUs using mothur

# execute within project directory

#convert fastq files fasta + qual files
fastq.info(fastq=SRP018246/SRR655327.fastq)
fastq.info(fastq=SRP018246/SRR655328.fastq)
fastq.info(fastq=SRP018246/SRR655329.fastq)
fastq.info(fastq=SRP018246/SRR655330.fastq)
fastq.info(fastq=SRP018246/SRR655331.fastq)
fastq.info(fastq=SRP018246/SRR655332.fastq)
fastq.info(fastq=SRP018246/SRR655333.fastq)
fastq.info(fastq=SRP018246/SRR655334.fastq)
fastq.info(fastq=SRP018246/SRR655335.fastq)
fastq.info(fastq=SRP018246/SRR655336.fastq)
fastq.info(fastq=SRP018246/SRR655337.fastq)
fastq.info(fastq=SRP018246/SRR655338.fastq)
fastq.info(fastq=SRP018246/SRR655339.fastq)
fastq.info(fastq=SRP018246/SRR655340.fastq)
fastq.info(fastq=SRP018246/SRR655341.fastq)
fastq.info(fastq=SRP018246/SRR655342.fastq)
fastq.info(fastq=SRP018246/SRR655343.fastq)
fastq.info(fastq=SRP018246/SRR655344.fastq)
fastq.info(fastq=SRP018246/SRR655345.fastq)
fastq.info(fastq=SRP018246/SRR655346.fastq)
fastq.info(fastq=SRP018246/SRR655347.fastq)
fastq.info(fastq=SRP018246/SRR655348.fastq)
fastq.info(fastq=SRP018246/SRR655349.fastq)
fastq.info(fastq=SRP018246/SRR655350.fastq)
fastq.info(fastq=SRP018246/SRR655351.fastq)
fastq.info(fastq=SRP018246/SRR655352.fastq)
fastq.info(fastq=SRP018246/SRR655353.fastq)
fastq.info(fastq=SRP018246/SRR655354.fastq)
fastq.info(fastq=SRP018246/SRR655355.fastq)
fastq.info(fastq=SRP018246/SRR655356.fastq)
fastq.info(fastq=SRP018246/SRR655357.fastq)
fastq.info(fastq=SRP018246/SRR655358.fastq)
fastq.info(fastq=SRP018246/SRR655359.fastq)
fastq.info(fastq=SRP018246/SRR655360.fastq)
fastq.info(fastq=SRP018246/SRR655361.fastq)
fastq.info(fastq=SRP018246/SRR655362.fastq)
fastq.info(fastq=SRP018246/SRR655363.fastq)
fastq.info(fastq=SRP018246/SRR655364.fastq)

# create group file
# input fasta file and the group names; output mergegroups
make.group(fasta=SRP018246/SRR655327.fasta-SRP018246/SRR655328.fasta-SRP018246/SRR655329.fasta-SRP018246/SRR655330.fasta-SRP018246/SRR655331.fasta-SRP018246/SRR655332.fasta-SRP018246/SRR655333.fasta-SRP018246/SRR655334.fasta-SRP018246/SRR655335.fasta-SRP018246/SRR655336.fasta-SRP018246/SRR655337.fasta-SRP018246/SRR655338.fasta-SRP018246/SRR655339.fasta-SRP018246/SRR655340.fasta-SRP018246/SRR655341.fasta-SRP018246/SRR655342.fasta-SRP018246/SRR655343.fasta-SRP018246/SRR655344.fasta-SRP018246/SRR655345.fasta-SRP018246/SRR655346.fasta-SRP018246/SRR655347.fasta-SRP018246/SRR655348.fasta-SRP018246/SRR655349.fasta-SRP018246/SRR655350.fasta-SRP018246/SRR655351.fasta-SRP018246/SRR655352.fasta-SRP018246/SRR655353.fasta-SRP018246/SRR655354.fasta-SRP018246/SRR655355.fasta-SRP018246/SRR655356.fasta-SRP018246/SRR655357.fasta-SRP018246/SRR655358.fasta-SRP018246/SRR655359.fasta-SRP018246/SRR655360.fasta-SRP018246/SRR655361.fasta-SRP018246/SRR655362.fasta-SRP018246/SRR655363.fasta-SRP018246/SRR655364.fasta, groups=field-field-field-field-lab-lab-lab-lab-field-field-field-field-field-field-lab-lab-lab-lab-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field)

# use mothur system command to copy file to new name


# make master fasta file (combines individual fasta files into a single file, SRP018246.fasta)
merge.files(input=SRP018246/SRR655327.fasta-SRP018246/SRR655328.fasta-SRP018246/SRR655329.fasta-SRP018246/SRR655330.fasta-SRP018246/SRR655331.fasta-SRP018246/SRR655332.fasta-SRP018246/SRR655333.fasta-SRP018246/SRR655334.fasta-SRP018246/SRR655335.fasta-SRP018246/SRR655336.fasta-SRP018246/SRR655337.fasta-SRP018246/SRR655338.fasta-SRP018246/SRR655339.fasta-SRP018246/SRR655340.fasta-SRP018246/SRR655341.fasta-SRP018246/SRR655342.fasta-SRP018246/SRR655343.fasta-SRP018246/SRR655344.fasta-SRP018246/SRR655345.fasta-SRP018246/SRR655346.fasta-SRP018246/SRR655347.fasta-SRP018246/SRR655348.fasta-SRP018246/SRR655349.fasta-SRP018246/SRR655350.fasta-SRP018246/SRR655351.fasta-SRP018246/SRR655352.fasta-SRP018246/SRR655353.fasta-SRP018246/SRR655354.fasta-SRP018246/SRR655355.fasta-SRP018246/SRR655356.fasta-SRP018246/SRR655357.fasta-SRP018246/SRR655358.fasta-SRP018246/SRR655359.fasta-SRP018246/SRR655360.fasta-SRP018246/SRR655361.fasta-SRP018246/SRR655362.fasta-SRP018246/SRR655363.fasta-SRP018246/SRR655364.fasta, output=SRP018246/SRP018246.fasta)

# make master qual file
merge.files(input=SRP018246/SRR655327.qual-SRP018246/SRR655328.qual-SRP018246/SRR655329.qual-SRP018246/SRR655330.qual-SRP018246/SRR655331.qual-SRP018246/SRR655332.qual-SRP018246/SRR655333.qual-SRP018246/SRR655334.qual-SRP018246/SRR655335.qual-SRP018246/SRR655336.qual-SRP018246/SRR655337.qual-SRP018246/SRR655338.qual-SRP018246/SRR655339.qual-SRP018246/SRR655340.qual-SRP018246/SRR655341.qual-SRP018246/SRR655342.qual-SRP018246/SRR655343.qual-SRP018246/SRR655344.qual-SRP018246/SRR655345.qual-SRP018246/SRR655346.qual-SRP018246/SRR655347.qual-SRP018246/SRR655348.qual-SRP018246/SRR655349.qual-SRP018246/SRR655350.qual-SRP018246/SRR655351.qual-SRP018246/SRR655352.qual-SRP018246/SRR655353.qual-SRP018246/SRR655354.qual-SRP018246/SRR655355.qual-SRP018246/SRR655356.qual-SRP018246/SRR655357.qual-SRP018246/SRR655358.qual-SRP018246/SRR655359.qual-SRP018246/SRR655360.qual-SRP018246/SRR655361.qual-SRP018246/SRR655362.qual-SRP018246/SRR655363.qual-SRP018246/SRR655364.qual, output=SRP018246/SRP018246.qual)

# trim sequences when average quality score in 50-by sliding window drops below 35
# remove the barcode and primer sequences: for 200 bp long sequences, remove any with homopolymers >8 bp, reverse complement each sequence
# input files: fasta and qual files, output files: trim.fasta, scrap.fasta, trim.qual, and scrap.qual files
trim.seqs(fasta=SRP018246/SRP018246.fasta, qfile=SRP018246/SRP018246.qual, maxambig=0, maxhomop=8, flip=T, bdiffs=1, pdiffs=2, qwindowaverage=35, qwindowsize=50, minlength=200, processors=2)

# inspect trimmed sequences
#input: fasta file, output: summary file
summary.seqs(fasta=SRP018246/SRP018246.fasta)

# simplifying the dataset to only unique sequences
#input: fasta file, output: names file, unique.fasta file
unique.seqs(fasta=SRP018246/SRP018246.fasta)

# inspect unique sequences
# input: unique.fasta file, output: unique.summary file
summary.seqs(fasta=SRP018246/SRP018246.unique.fasta, name=SRP018246/SRP018246.names)
