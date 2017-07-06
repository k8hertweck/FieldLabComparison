## Microbiome Ant Field vs Lab Analysis OTUs using mothur

# usage: mothur mothur_otu.bat
# execute within project directory

#convert fastq files fasta + qual files
fastq.info(fastq=data/SRP018246/SRR655327.fastq)
fastq.info(fastq=data/SRP018246/SRR655328.fastq)
fastq.info(fastq=data/SRP018246/SRR655329.fastq)
fastq.info(fastq=data/SRP018246/SRR655330.fastq)
fastq.info(fastq=data/SRP018246/SRR655331.fastq)
fastq.info(fastq=data/SRP018246/SRR655332.fastq)
fastq.info(fastq=data/SRP018246/SRR655333.fastq)
fastq.info(fastq=data/SRP018246/SRR655334.fastq)
fastq.info(fastq=data/SRP018246/SRR655335.fastq)
fastq.info(fastq=data/SRP018246/SRR655336.fastq)
fastq.info(fastq=data/SRP018246/SRR655337.fastq)
fastq.info(fastq=data/SRP018246/SRR655338.fastq)
fastq.info(fastq=data/SRP018246/SRR655339.fastq)
fastq.info(fastq=data/SRP018246/SRR655340.fastq)
fastq.info(fastq=data/SRP018246/SRR655341.fastq)
fastq.info(fastq=data/SRP018246/SRR655342.fastq)
fastq.info(fastq=data/SRP018246/SRR655343.fastq)
fastq.info(fastq=data/SRP018246/SRR655344.fastq)
fastq.info(fastq=data/SRP018246/SRR655345.fastq)
fastq.info(fastq=data/SRP018246/SRR655346.fastq)
fastq.info(fastq=data/SRP018246/SRR655347.fastq)
fastq.info(fastq=data/SRP018246/SRR655348.fastq)
fastq.info(fastq=data/SRP018246/SRR655349.fastq)
fastq.info(fastq=data/SRP018246/SRR655350.fastq)
fastq.info(fastq=data/SRP018246/SRR655351.fastq)
fastq.info(fastq=data/SRP018246/SRR655352.fastq)
fastq.info(fastq=data/SRP018246/SRR655353.fastq)
fastq.info(fastq=data/SRP018246/SRR655354.fastq)
fastq.info(fastq=data/SRP018246/SRR655355.fastq)
fastq.info(fastq=data/SRP018246/SRR655356.fastq)
fastq.info(fastq=data/SRP018246/SRR655357.fastq)
fastq.info(fastq=data/SRP018246/SRR655364.fastq)

# move fata and qual files to analysis/
system(mkdir analysis/)
system(mv data/*/*.fasta data/*/*.qual analysis/)

# set working directory to analysis for rest of script
set.dir(input=analysis)

# create group file
# input fasta file and the group names; output mergegroups
make.group(fasta=SRR655327.fasta-SRR655328.fasta-SRR655329.fasta-SRR655330.fasta-SRR655331.fasta-SRR655332.fasta-SRR655333.fasta-SRR655334.fasta-SRR655335.fasta-SRR655336.fasta-SRR655337.fasta-SRR655338.fasta-SRR655339.fasta-SRR655340.fasta-SRR655341.fasta-SRR655342.fasta-SRR655343.fasta-SRR655344.fasta-SRR655345.fasta-SRR655346.fasta-SRR655347.fasta-SRR655348.fasta-SRR655349.fasta-SRR655350.fasta-SRR655351.fasta-SRR655352.fasta-SRR655353.fasta-SRR655354.fasta-SRR655355.fasta-SRR655356.fasta-SRR655357.fasta-SRR655358.fasta-SRR655359.fasta-SRR655360.fasta-SRR655361.fasta-SRR655362.fasta-SRR655363.fasta-SRR655364.fasta, groups=field-field-field-field-lab-lab-lab-lab-field-field-field-field-field-field-lab-lab-lab-lab-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field)

# use mothur system command to copy file with a new name
system(cp mergegroups SRP018246.groups)

# make master fasta file (combines individual fasta files into a single file, analysis.fasta)
merge.files(input=SRR655327.fasta-SRR655328.fasta-SRR655329.fasta-SRR655330.fasta-SRR655331.fasta-SRR655332.fasta-SRR655333.fasta-SRR655334.fasta-SRR655335.fasta-SRR655336.fasta-SRR655337.fasta-SRR655338.fasta-SRR655339.fasta-SRR655340.fasta-SRR655341.fasta-SRR655342.fasta-SRR655343.fasta-SRR655344.fasta-SRR655345.fasta-SRR655346.fasta-SRR655347.fasta-SRR655348.fasta-SRR655349.fasta-SRR655350.fasta-SRR655351.fasta-SRR655352.fasta-SRR655353.fasta-SRR655354.fasta-SRR655355.fasta-SRR655356.fasta-SRR655357.fasta-SRR655358.fasta-SRR655359.fasta-SRR655360.fasta-SRR655361.fasta-SRR655362.fasta-SRR655363.fasta-SRR655364.fasta, output=analysis.fasta)

# make master qual file
merge.files(input=SRR655327.qual-SRR655328.qual-SRR655329.qual-SRR655330.qual-SRR655331.qual-SRR655332.qual-SRR655333.qual-SRR655334.qual-SRR655335.qual-SRR655336.qual-SRR655337.qual-SRR655338.qual-SRR655339.qual-SRR655340.qual-SRR655341.qual-SRR655342.qual-SRR655343.qual-SRR655344.qual-SRR655345.qual-SRR655346.qual-SRR655347.qual-SRR655348.qual-SRR655349.qual-SRR655350.qual-SRR655351.qual-SRR655352.qual-SRR655353.qual-SRR655354.qual-SRR655355.qual-SRR655356.qual-SRR655357.qual-SRR655358.qual-SRR655359.qual-SRR655360.qual-SRR655361.qual-SRR655362.qual-SRR655363.qual-SRR655364.qual, output=analysis.qual)

# trim sequences when average quality score in 50-by sliding window drops below 35
# remove the barcode and primer sequences: for 200 bp long sequences, remove any with homopolymers >8 bp, reverse complement each sequence
# input files: fasta and qual files, output files: trim.fasta, scrap.fasta, trim.qual, and scrap.qual files
trim.seqs(fasta=analysis.fasta, qfile=analysis.qual, maxambig=0, maxhomop=8, flip=T, bdiffs=1, pdiffs=2, qwindowaverage=35, qwindowsize=50, minlength=200, processors=2)

# inspect trimmed sequences
#input: fasta file, output: summary file
summary.seqs(fasta=analysis.fasta)

# simplifying the dataset to only unique sequences
#input: fasta file, output: names file, unique.fasta file
unique.seqs(fasta=analysis.fasta)

# inspect unique sequences
# input: unique.fasta file, output: unique.summary file
summary.seqs(fasta=analysis.unique.fasta, name=analysis.names)

#generate an alignment of our data using the align.seqs command by aligning our data from MiSeq SOP named silva.bacteria.fasta
#input: unique.fasta file
#output: unique.align, unique.align.report, unique.flip.accnos file
align.seqs(fasta=SRP018246.unique.fasta, reference=~/Desktop/Silva.bacteria/silva.bacteria.pcr.fasta, processors=2)

#inspect aligned sequences
#input: unique.align, names file
#output: unique.summary
summary.seqs(fasta=SRP018246.unique.align, name=SRP018246.names)

#remove those sequences that are outside the desired range of alignment space
#input: unique.align file, names file, and group file
#output: unique.good.align, unique.bad.accnos, good.names, good.groups file
screen.seqs(fasta=SRP018246.unique.align, name=SRP018246.names, group=SRP018246.groups, optimize=end, criteria=90, processors=2)

#inspect sequences and determine whiche parameters in screen.seqs() works best for the data
#input: unique.good.align and good.names file
#output: unique.good.summary file
summary.seqs(fasta=SRP018246.unique.good.align, name=SRP018246.good.names) 

#filter our alignment so that all of our sequences only overlap in the same region and 
#to remove any columns in the alignment that don't contain data
#the parameter trump=. will remove any column that has a "." character, which indicates missing data
#vertical=T option will remove any column that containsb  exclusively gaps
#input: unique.good.align
#output: unique.good.filter.fasta, filter file
filter.seqs(fasta=SRP018246.unique.good.align, vertical=T, processors=2)

#remove redundant sequences in the alignment region
#input: unique.good.filter.fasta,and good.names
#output: unique.good.filter.names,and unique.good.filter.unique.fasta
unique.seqs(fasta=SRP018246.unique.good.filter.fasta, name=SRP018246.good.names)

#splits the sequences by group and then within each group the sequences are pre-clustered 
#by which sequences that are within 1 or 2 bases of a more abundant sequence
#the next step is to merge all the sequences back into one fasta file a names file 
#input: unique.good.filter.unique.fasta, unique.good.filter.names,and good.groups file
#output: unique.good.filter.unique.precluster.fasta, unique.good.filter.unique.precluster.names, unique.good.filter.unique.precluster.field.map,and unique.good.filter.unique.precluster.lab.map file
pre.cluster(fasta=SRP018246.unique.good.filter.unique.fasta, name=SRP018246.unique.good.filter.names, group=SRP018246.good.groups, diffs=2)

#inspect the preclustered files
#input: unique.good.filter.unique.precluster.fasta and unique.good.filter.unique.precluster.names file
#output: unique.good.filter.unique.precluster.summary file
summary.seqs(fasta=SRP018246.unique.good.filter.unique.precluster.fasta, name=SRP018246.unique.good.filter.unique.precluster.names)

#Detecting and removing chimeras
#This method will first split the sequences by group and then check each sequence within a group using the more abundant sequences
as reference sequences. This enables us to parallelize the entire process by putting each group onto a separate processor
#input: unique.good.filter.unique.precluster.fasta, unique.good.filter.unique.precluster.names,and good.groups file
#output: unique.good.filter.unique.precluster.denovo.uchime.chimeras and unique.good.filter.unique.precluster.denovo.uchime.accnos file
chimera.uchime(fasta=SRP018246.unique.good.filter.unique.precluster.fasta, name=SRP018246.unique.good.filter.unique.precluster.names, group=SRP018246.good.groups, processors=2)

##Rename files on a mac
#use the mothur System command to make copies of same files for mac
system(cp SRP018246.unique.good.filter.unique.precluster.fasta final.fasta)
system(cp SRP018246.unique.good.filter.unique.precluster.names final.names)
system(cp SRP018246.good.groups final.groups)

#use the mothur System command to make copies of same files for Windows
#If this code does not work, then manually copy all of the 4 files
system(copy SRP018246.unique.good.filter.unique.precluster.fasta final.fasta)
system(copy SRP018246.unique.good.filter.unique.precluster.names final.names)
system(copy SRP018246.good.groups final.groups)

#Option 1 or Option 2 are two different methods available in mothur to build operational taxonomic units (OTUs)
#The output from Option 2 should be about the same as Option 1. The remainder of this code uses Option 1.

#Option 1: generate a distance matrix and use a cutoff of 0.15(which means you're chucking any pairwise distance larger than 0.15)
#If the output of this command is in the >100 GBs of memory range you have probably done something incorrectly
#SRP018246.unique.good.filter.unique.precluster.fasta was renamed final.fasta
#input: final.fasta file
#output: final.dist
dist.seqs(fasta=final.fasta, cutoff=0.15, processors=2)

#cluster these sequences into OTUs based on the newly created distance matrix and name files
#cutoff is typically 0.03 for further analysis
#SRP018246.unique.good.filter.unique.precluster.names was renamed final.names
#input: final.dist and final.names file
#output: final.an.sabund, final.an.rabund,and final.an.list file
cluster(column=final.dist, name=final.names) 

#Option 2: use the cluster.split command if you are in a time crunch
#The output from Option 2 should be about the same as Option 1. The remainder of this code uses Option 1
#cluster.split(fasta=final.fasta, taxonomy=final.taxonomy, name=final.names, taxlevel=3, processors=4)

