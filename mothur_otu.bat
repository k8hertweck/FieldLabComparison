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
fastq.info(fastq=data/SRP018246/SRR655358.fastq)
fastq.info(fastq=data/SRP018246/SRR655359.fastq)
fastq.info(fastq=data/SRP018246/SRR655360.fastq)
fastq.info(fastq=data/SRP018246/SRR655361.fastq)
fastq.info(fastq=data/SRP018246/SRR655362.fastq)
fastq.info(fastq=data/SRP018246/SRR655363.fastq)
fastq.info(fastq=data/SRP018246/SRR655364.fastq)

# move fata and qual files to analysis/
system(mkdir analysis/)
system(mv data/*/*.fasta data/*/*.qual analysis/)

# set working directory to analysis for rest of script
set.dir(input=analysis)

# create group file
# output mergegroups
make.group(fasta=SRR655327.fasta-SRR655328.fasta-SRR655329.fasta-SRR655330.fasta-SRR655331.fasta-SRR655332.fasta-SRR655333.fasta-SRR655334.fasta-SRR655335.fasta-SRR655336.fasta-SRR655337.fasta-SRR655338.fasta-SRR655339.fasta-SRR655340.fasta-SRR655341.fasta-SRR655342.fasta-SRR655343.fasta-SRR655344.fasta-SRR655345.fasta-SRR655346.fasta-SRR655347.fasta-SRR655348.fasta-SRR655349.fasta-SRR655350.fasta-SRR655351.fasta-SRR655352.fasta-SRR655353.fasta-SRR655354.fasta-SRR655355.fasta-SRR655356.fasta-SRR655357.fasta-SRR655358.fasta-SRR655359.fasta-SRR655360.fasta-SRR655361.fasta-SRR655362.fasta-SRR655363.fasta-SRR655364.fasta, groups=field-field-field-field-lab-lab-lab-lab-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-field-lab-lab-lab-lab-field-field-field-field)

# use mothur system command to copy file with a new name
#system(cp analysis/mergegroups analysis/merge.groups)
rename.file(input=mergegroups, new=merge.groups)

# make master fasta file (combines individual fasta files into a single file, analysis.fasta)
merge.files(input=SRR655327.fasta-SRR655328.fasta-SRR655329.fasta-SRR655330.fasta-SRR655331.fasta-SRR655332.fasta-SRR655333.fasta-SRR655334.fasta-SRR655335.fasta-SRR655336.fasta-SRR655337.fasta-SRR655338.fasta-SRR655339.fasta-SRR655340.fasta-SRR655341.fasta-SRR655342.fasta-SRR655343.fasta-SRR655344.fasta-SRR655345.fasta-SRR655346.fasta-SRR655347.fasta-SRR655348.fasta-SRR655349.fasta-SRR655350.fasta-SRR655351.fasta-SRR655352.fasta-SRR655353.fasta-SRR655354.fasta-SRR655355.fasta-SRR655356.fasta-SRR655357.fasta-SRR655358.fasta-SRR655359.fasta-SRR655360.fasta-SRR655361.fasta-SRR655362.fasta-SRR655363.fasta-SRR655364.fasta, output=analysis/analysis.fasta)

# make master qual file
merge.files(input=SRR655327.qual-SRR655328.qual-SRR655329.qual-SRR655330.qual-SRR655331.qual-SRR655332.qual-SRR655333.qual-SRR655334.qual-SRR655335.qual-SRR655336.qual-SRR655337.qual-SRR655338.qual-SRR655339.qual-SRR655340.qual-SRR655341.qual-SRR655342.qual-SRR655343.qual-SRR655344.qual-SRR655345.qual-SRR655346.qual-SRR655347.qual-SRR655348.qual-SRR655349.qual-SRR655350.qual-SRR655351.qual-SRR655352.qual-SRR655353.qual-SRR655354.qual-SRR655355.qual-SRR655356.qual-SRR655357.qual-SRR655358.qual-SRR655359.qual-SRR655360.qual-SRR655361.qual-SRR655362.qual-SRR655363.qual-SRR655364.qual, output=analysis/analysis.qual)

# summarize complete sequences
summary.seqs(fasta=analysis.fasta)

# trim sequences for quality
# output files: trim.fasta, scrap.fasta, trim.qual, and scrap.qual files
trim.seqs(fasta=analysis.fasta, qfile=analysis.qual, maxambig=1, maxhomop=8, flip=T, qaverage=25, minlength=200, processors=2)
 
# inspect trimmed sequences
# output: summary file
summary.seqs(fasta=analysis.trim.fasta)

# simplifying the dataset to only unique sequences
# output: names file, unique.fasta file
unique.seqs(fasta=analysis.trim.fasta)

# inspect unique sequences
# output: unique.summary file
summary.seqs(fasta=analysis.trim.unique.fasta, name=analysis.trim.names)

# align our data to silva reference
# output: unique.align, unique.align.report, unique.flip.accnos file
align.seqs(fasta=analysis.trim.unique.fasta, reference=silva/silva.bacteria.pcr.fasta, flip=T, processors=6)

# inspect aligned sequences
# output: unique.summary
summary.seqs(fasta=analysis.trim.unique.align, name=analysis.trim.names)

# remove sequences outside the desired range of alignment space
# output: unique.good.align, unique.bad.accnos, good.names, good.groups file
screen.seqs(fasta=analysis.trim.unique.align, name=analysis.trim.names, group=merge.groups, optimize=end, criteria=90, processors=2)

# inspect sequences 
# output: unique.good.summary file
summary.seqs(fasta=analysis.trim.unique.good.align, name=analysis.trim.good.names) 

# filter alignment to remove columns that don't contain data
# the parameter trump=. will remove any column that has a "." character, which indicates missing data
# vertical=T option will remove any column that contains exclusively gaps
# output: unique.good.filter.fasta, filter file
filter.seqs(fasta=analysis.trim.unique.good.align, vertical=T, processors=2)

# remove redundant sequences in the alignment region
# output: unique.good.filter.names,and unique.good.filter.unique.fasta
unique.seqs(fasta=analysis.trim.unique.good.filter.fasta, name=analysis.trim.good.names)

# pre-cluster within each group 
# output: unique.good.filter.unique.precluster.fasta, unique.good.filter.unique.precluster.names, unique.good.filter.unique.precluster.field.map,and unique.good.filter.unique.precluster.lab.map file
pre.cluster(fasta=analysis.trim.unique.good.filter.unique.fasta, name=analysis.trim.unique.good.filter.names, group=merge.good.groups, diffs=2)

# inspect the preclustered files
# output: unique.good.filter.unique.precluster.summary file
summary.seqs(fasta=analysis.trim.unique.good.filter.unique.precluster.fasta, name=analysis.trim.unique.good.filter.unique.precluster.names)

# detecting and removing chimeras (unnecessary since completed in SRA data)
# output: unique.good.filter.unique.precluster.denovo.uchime.chimeras and unique.good.filter.unique.precluster.denovo.uchime.accnos file
#chimera.uchime(fasta=analysis.trim.unique.good.filter.unique.precluster.fasta, name=analysis.trim.unique.good.filter.unique.precluster.names, group=merge.good.groups, processors=2)

# rename files 
#system(cp analysis.trim.unique.good.filter.unique.precluster.fasta final.fasta)
rename.file(input=analysis.trim.unique.good.filter.unique.precluster.fasta, output=final.fasta)
#system(cp analysis.trim.unique.good.filter.unique.precluster.names final.names)
rename.file(input=analysis.trim.unique.good.filter.unique.precluster.names, output=final.names)
#system(cp analysis.trim.good.groups final.groups)
rename.file(input=analysis.trim.good.groups, output=final.groups)

# Option 1 or 2 are different methods available to build OTUs
# Output from Option 2 should be similar to Option 1
# This workflow uses Option 1.

# Option 1: generate distance matrix, and use a 
# cutoff of 0.15 means removing all pairwise distance larger than 0.15
# If output is >100 GBs of memory, something is wrong
# output: final.dist
dist.seqs(fasta=final.fasta, cutoff=0.15, processors=2)

# cluster sequences into OTUs based on distance matrix
# cutoff is typically 0.03 for further analysis
# output: final.an.sabund, final.an.rabund,and final.an.list file
cluster(column=final.dist, name=final.names) 

# Option 2: quick and dirty
#cluster.split(fasta=final.fasta, taxonomy=final.taxonomy, name=final.names, taxlevel=3, processors=4)

