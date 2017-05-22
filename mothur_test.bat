###MiSeq_SOP
##The goal of this tutorial is to demonstrate the standard operating procedure (SOP) that the Schloss lab uses to process their 16S rRNA gene sequences that are generated using Illumina's MiSeq platform using paired end reads
#For this tutorial you will need several sets of files that can be downloaded here: https://mothur.org/wiki/MiSeq_SOP (or if on Mac, run mothurIlluminaData.sh)
#Working (project) directory contains no subdirectories and contents from following zip files:
#	MiSeqSOPData.zip 
# 	Silva.bacteria.zip
#	Trainset9_032012.pds.zip
# add this batch file to project directory and execute as: mothur mothurIlluminaOTUs.bat
# will result in ~4 non-fatal warnings

#Can make a stability.files using a make.file command (example below)
#The first column is the name of the sample
#The second column is the name of the forward read for that sample
#The third columns in the name of the reverse read for that sample
#make.file(inputdir=, type=fastq, prefix=stability)

##Combine two sets of each sample then combine the data from all samples using the make.contigs command
#the command extracts the sequence and quality score data from the fastq files and creates the reverse complement of the reverse read and then joins the reads into contigs
#[WARNING]: your sequence names contained ':'.  I changed them to '_' to avoid problems in your downstream analysis.
#Input files are the stability files 
# output file names
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.fasta
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.qual
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.contigs.report
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.scrap.contigs.fasta
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.scrap.contigs.qual
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.contigs.groups
#copy and paste the stability.files file to the same directory as the mothur executable file
make.contigs(file=stability.files, processors=2)

#see what these contig sequences look like 
# output /Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.summary
summary.seqs(fasta=stability.trim.contigs.fasta)

##Reducing sequencing and PCR errors
#remove any sequences with ambiguous bases and anything longer than 275 bp
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.fasta
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.bad.accnos
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.contigs.good.groups
screen.seqs(fasta=stability.trim.contigs.fasta, group=stability.contigs.groups, maxambig=0, maxlength=275)
#This may be faster than the command above because the summary.seqs output file already has the number of ambiguous bases and sequence length calculated for your sequences
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.summary
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.fasta
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.bad.accnos
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.contigs.good.groups
screen.seqs(fasta=stability.trim.contigs.fasta, group=stability.contigs.groups, summary=stability.trim.contigs.summary, maxambig=0, maxlength=275)

#show your latest fasta file and group file as well as the number of processors you have
# output current_files.summary
get.current()

##Processing Improved sequences
#remove duplicates of sequences
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.names
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.fasta 
unique.seqs(fasta=stability.trim.contigs.good.fasta)

#simplify the names and group files by generating a table where the rows are the names of the unique sequences and the columns are the names of the groups
#the table is then filled with the number of times each unique sequence shows up in each group
count.seqs(name=stability.trim.contigs.good.names, group=stability.contigs.good.groups)

#see what the table look like 
# output /Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.count_table
summary.seqs(count=stability.trim.contigs.good.count_table) 

#Using stability.trim.contigs.good.unique.fasta as input file for the fasta parameter.
#need to align our sequences to the reference alignment(silva.bacteria.fasta) to make a database customized to our region of interest using the pcr.seqs command
# output silva.bacteria.pcr.fasta
pcr.seqs(fasta=silva.bacteria.fasta, start=11894, end=25319, keepdots=F, processors=8)

#see what customized reference alignment looks like
# silva.bacteria.pcr.summary
summary.seqs(fasta=silva.bacteria.pcr.fasta)

#align sequences to customized reference alignment
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.align
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.align.report
align.seqs(fasta=stability.trim.contigs.good.unique.fasta, reference=silva.bacteria.pcr.fasta)

#see what alignment looks like
# output /Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.summary
summary.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table)

#to make sure that the sequences overlap the same region using screen.seqs
#Note that you need the count table so that we can update the table for the sequences we're removing and we're also using the summary file so we don't have to figure out again all the start and stop positions 
#Input file is stability.trim.contigs.good.good.count_table for the count parameter
#Input file is stability.trim.contigs.good.unique.good.align for the fasta parameter
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.summary
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.align
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.bad.accnos
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.good.count_table
screen.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table, summary=stability.trim.contigs.good.unique.summary, start=1968, end=11550, maxhomop=8)
# output /Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.summary
summary.seqs(fasta=current, count=current)

#filter the sequences to remove the overhangs at both ends
#pull out the columns in the alignment that only contain gap characters (i.e. "-")
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.filter
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.fasta
filter.seqs(fasta=stability.trim.contigs.good.unique.good.align, vertical=T, trump=.)

#remove redundancy added by trimming the ends of the sequences
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.count_table
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.fasta
unique.seqs(fasta=stability.trim.contigs.good.unique.good.filter.fasta, count=stability.trim.contigs.good.good.count_table)

#pre-cluster the sequences by splitting the sequences by group and then sort them by abundance
#go from most abundant to least and identify sequences that are within 2 nucleotides of each other and if they are then they get merged
# output 
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.*.map
pre.cluster(fasta=stability.trim.contigs.good.unique.good.filter.unique.fasta, count=stability.trim.contigs.good.unique.good.filter.count_table, diffs=2)

#to detect and remove chimeras the data will be split by sample and checked for chimeras
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.count_table
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.chimeras
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.accnos
chimera.uchime(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.count_table, dereplicate=t)

#Running chimera.uchime with the count file will remove the chimeric sequences from the count file
#Need to remove those sequences from the fasta file now
# output /Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta
remove.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta, accnos=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.accnos)

#to see the sequences that remain
# output /Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.summary
summary.seqs(fasta=current, count=current)

#classify sequences using the Bayesian classifier because we only want members of Bacteria
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.taxonomy
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.tax.summary
classify.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.count_table, reference=trainset9_032012.pds.fasta, taxonomy=trainset9_032012.pds.tax, cutoff=80)

#remove all sequences that are not classified as bacteria
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.taxonomy
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table
remove.lineage(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.taxonomy, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota)

#create an updated taxonomy summary file that is made up of bacterial sequences
# output /Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.tax.summary
summary.tax(taxonomy=current, count=current)

##Measuring the error rate of the bacterial taxonomy summary file is something you can only do if you have co-sequenced a mock community
#pull the sequences out that were from our "Mock" samples
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.fasta
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table
get.groups(count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table, fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta, groups=Mock)

#measure the error rates of the mock sample
# output
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.summary
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.seq
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.chimera
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.seq.forward
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.seq.reverse
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.count
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.matrix
#/Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.ref
seq.error(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table, reference=HMP_MOCK.v35.fasta, aligned=F)

#cluster the sequences into OTUs to see how many spurious OTUs we have
# output files in directory = /Users/KHertweck/Desktop/MiSeq_SOP/
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.summary
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.seq
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.chimera
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.seq.forward
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.seq.reverse
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.count
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.matrix
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.ref

dist.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.fasta, cutoff=0.20)
# output /Users/KHertweck/Desktop/MiSeq_SOP/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.dist
cluster(column=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.dist, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table)
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.list
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.steps
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.sensspec
make.shared(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table, label=0.03)
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.shared
rarefaction.single(shared=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.shared)
 
##Preparing for analysis to assign sequences to OTUs and phylotypes
#remove the Mock sample from our dataset 
# output filenames:
#stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.fasta
#stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table
#stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.taxonomy
remove.groups(count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table, fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.taxonomy, groups=Mock)

#clustering sequences into OTUs using dist.seqs and cluster commands
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.dist
dist.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.fasta, cutoff=0.20)
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.dist
cluster(column=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.dist, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table)
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.list
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.steps
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.sensspec

#alternative approach for clustering is the cluster.split command NO WORK
#cluster.split(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.taxonomy, splitmethod=classify, taxlevel=4, cutoff=0.03)

#to know how many sequences are in each OTU from each group using make.shared command and a cutoff level of 0.03 
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.shared
make.shared(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table, label=0.03)

#to know the taxonomy for each of our OTUs using the classify.otu command
# output 
#stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.0.03.cons.taxonomy
#stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.0.03.cons.tax.summary
classify.otu(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.taxonomy, label=0.03)

#to bin your sequences in to phylotypes according to their taxonomic classification using the phylotype command
# output
#stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.sabund
#stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.rabund
#stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.list
phylotype(taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.taxonomy)

#To get the the genus-level shared file for the phylotype
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.shared
make.shared(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table, label=1)

#want to know the specific OTUs so can use the classify.otu on the phylotypes
# output
#stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.1.cons.taxonomy
#stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.1.cons.tax.summary
classify.otu(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.tx.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.pick.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.pick.taxonomy, label=1)

##Phylogenetics
#to generate a tree using the dist.seqs and clearcut commands
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.phylip.dist
dist.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.fasta, output=lt, processors=2)
# output stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.phylip.tre
clearcut(phylip=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.phylip.dist)
