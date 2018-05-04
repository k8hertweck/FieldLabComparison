## Microbiome Ant Field vs Lab Analysis OTUs using mothur

# usage: mothur mothur_otu.bat
# execute within project directory
# for explanation of commands: https://www.mothur.org/wiki/Sequence_processing

# change mothur working directory to analysis
set.dir(input=analysis)

# summarize complete sequences
# output: analysis.trim.4ant.summary
#summary.seqs(fasta=analysis.trim.4ant.fasta)

# simplifying the dataset to only unique sequences
# output: analysis.trim.4ant.names, analysis.trim.4ant.unique.fasta 
#unique.seqs(fasta=analysis.trim.4ant.fasta)

# inspect unique sequences
# output: analysis.trim.4ant.unique.summary 
#summary.seqs(fasta=analysis.trim.4ant.unique.fasta, name=analysis.trim.4ant.names)

# align our data to silva reference
# output: analysis.trim.4ant.unique.align, analysis.trim.4ant.unique.align.report, analysis.trim.4ant.unique.flip.accnos 
#align.seqs(fasta=analysis.trim.4ant.unique.fasta, reference=silva/silva.nr_v128.pcr.align, flip=T, processors=6)

# inspect aligned sequences
# output: analysis.trim.4ant.unique.summary
#summary.seqs(fasta=analysis.trim.4ant.unique.align, name=analysis.trim.4ant.names)

# remove sequences outside the desired range of alignment space
# output: analysis.trim.4ant.unique.good.align, analysis.trim.4ant.unique.bad.accnos, analysis.trim.4ant.good.names, analysis.4ant.good.groups file
#screen.seqs(fasta=analysis.trim.4ant.unique.align, name=analysis.trim.4ant.names, group=analysis.4ant.groups, optimize=end, criteria=90, processors=6)

# inspect sequences 
# output: analysis.trim.4ant.unique.good.summary 
#summary.seqs(fasta=analysis.trim.4ant.unique.good.align, name=analysis.trim.4ant.good.names) 

# filter alignment to remove columns that don't contain data
# the parameter trump=. will remove any column that has a "." character, which indicates missing data
# vertical=T option will remove any column that contains exclusively gaps
# output: analysis.trim.4ant.unique.good.filter.fasta, filter file
#filter.seqs(fasta=analysis.trim.4ant.unique.good.align, vertical=T, processors=6)

# remove redundant sequences in the alignment region
# output: analysis.trim.4ant.unique.good.filter.names, analysis.trim.4ant.unique.good.filter.unique.fasta
#unique.seqs(fasta=analysis.trim.4ant.unique.good.filter.fasta, name=analysis.trim.4ant.good.names)

# pre-cluster within each group 
# output: analysis.trim.4ant.unique.good.filter.unique.precluster.fasta, analysis.trim.4ant.unique.good.filter.unique.precluster.names, analysis.trim.4ant.unique.good.filter.unique.precluster.field.map, analysis.trim.4ant.unique.good.filter.unique.precluster.lab.map 
#pre.cluster(fasta=analysis.trim.4ant.unique.good.filter.unique.fasta, name=analysis.trim.4ant.unique.good.filter.names, group=analysis.4ant.good.groups, diffs=2, processors=6)

# inspect the preclustered files
# output: analysis.trim.4ant.unique.good.filter.unique.precluster.summary 
#summary.seqs(fasta=analysis.trim.4ant.unique.good.filter.unique.precluster.fasta, name=analysis.trim.4ant.unique.good.filter.unique.precluster.names)

# detecting and removing chimeras (unnecessary since completed in SRA data)
# output: analysis.trim.4ant.unique.good.filter.unique.precluster.denovo.uchime.chimeras, analysis.trim.4ant.unique.good.filter.unique.precluster.denovo.uchime.accnos 
#chimera.uchime(fasta=analysis.trim.4ant.unique.good.filter.unique.precluster.fasta, #name=analysis.trim.4ant.unique.good.filter.unique.precluster.names, group=analysis.4ant.good.groups, processors=6)

#generate count table to be used
#count.seqs(name=analysis.trim.4ant.unique.good.filter.unique.precluster.names)

#generate taxonomy file
#classify.seqs(fasta=analysis/analysis.trim.4ant.unique.good.filter.unique.precluster.fasta, count=analysis/analysis.trim.4ant.unique.good.filter.unique.precluster.count_table, reference=silva/silva.nr_v128.pcr.align, taxonomy=silva/silva.nr_v128.tax, cutoff=80)

# rename files (rename command is unreliable)
#system(cp analysis/analysis.trim.4ant.unique.good.filter.unique.precluster.fasta analysis/final.4ant.fasta)
#rename.file(input=analysis.trim.4ant.unique.good.filter.unique.precluster.fasta, output=final.4ant.fasta)
#system(cp analysis/analysis.trim.4ant.unique.good.filter.unique.precluster.names analysis/final.4ant.names)
#rename.file(input=analysis.trim.4ant.unique.good.filter.unique.precluster.names, output=final.4ant.names)
#system(cp analysis/analysis.4ant.good.groups analysis/final.4ant.groups)
#rename.file(input=analysis.4ant.good.groups, output=final.4ant.groups)
#system(cp analysis/analysis.trim.4ant.unique.good.filter.unique.precluster.nr_v128.wang.taxonomy analysis/final.4ant.taxonomy)
#rename.file(input=analysis.trim.4ant.unique.good.filter.unique.precluster.nr_v128.wang.taxonomy, output=final.4ant.taxonomy)

# Option 1 or 2 are different methods available to build OTUs
# Output from Option 2 should be similar to Option 1
# This workflow uses Option 1.

# Option 1: generate distance matrix
# cutoff of 0.15 means removing all pairwise distance larger than 0.15
# If output is >100 GBs of memory, something is wrong
# output: final.4ant.dist
#dist.seqs(fasta=final.4ant.fasta, cutoff=0.15, processors=6)

# cluster sequences into OTUs based on distance matrix
# cutoff is typically 0.03 for further analysis
# output: final.4ant.an.sabund, final.4ant.an.rabund, final.4ant.an.list 
#cluster(column=final.4ant.dist, name=final.4ant.names, cutoff=0.03) 

# Option 2: quick and dirty
#cluster.split(fasta=final.4ant.fasta, taxonomy=final.4ant.taxonomy, name=final.4ant.names, taxlevel=3, processors=6)

#The output from Option 2 should be about the same as Option 1. The remainder of this code uses Option 1

#create a table that indicates the number of times an OTU shows up in each sample also known as a shared file
#input: final.4ant.an.list and final.4ant.groups file
#output: final.4ant.an.shared file
#make.shared(list=final.4ant.an.list, group=final.4ant.groups)

#The final step to getting good OTU data is to normalize the number of sequences in each sample
#First we need to know how many sequences are in each step
#count.groups()

#sub-sample all the samples to the sample with the fewest sequences(59768)
#input: final.4ant.an.shared file
#output: final.4ant.an.unique.subsample.shared
#sub.sample(shared=final.4ant.an.shared, size=59768)

#Extract specific ant species to view in venn diagram using phylotype analysis 
#goes through the taxonomy file and bins sequences together that have the same taxonomy, 6 different bins.These bins are known as phylotypes.
#output: final.4ant.tx.list, final.4ant.tx.rabund, final.4ant.tx.sabund
#phylotype(taxonomy=final.4ant.taxonomy, name=final.4ant.names)

#get the taxonomy of each phylotype, there are 6 phylotypes
#produces consensus taxnomy & summary taxonomy files for each phylotype
#output files: 
#final.4ant.tx.1.cons.taxonomy, final.4ant.tx.1.cons.tax.summary,
#final.4ant.tx.2.cons.taxonomy, final.4ant.tx.2.cons.tax.summary,
#final.4ant.tx.3.cons.taxonomy, final.4ant.tx.3.cons.tax.summary,
#final.4ant.tx.4.cons.taxonomy, final.4ant.tx.4.cons.tax.summary,
#final.4ant.tx.5.cons.taxonomy, final.4ant.tx.5.cons.tax.summary,
#final.4ant.tx.6.cons.taxonomy, final.4ant.tx.6.cons.tax.summary
#classify.otu(list=final.4ant.tx.list, name=final.4ant.names, taxonomy=final.4ant.taxonomy)

#merge all the taxonomy summary files together in one file called final.4ant.cons.tax.summary
#merge.taxsummary(input=final.4ant.tx.1.cons.tax.summary-final.4ant.tx.2.cons.tax.summary-final.4ant.tx.3.cons.tax.summary-final.4ant.tx.4.cons.tax.summary-final.4ant.tx.5.cons.tax.summary-final.4ant.tx.6.cons.tax.summary, output=analysis/final.4ant.cons.tax.summary)

#In terminal within the analysis folder,create final.4ant.list.tax.summary file to determine lowest taxonomic rank in merged taxonomy summary file, lowest taxonomic rank is genus
#selected 3 columns:
#taxlevels(put in numerical order)
#taxon name
#total no. of sequences for specific taxonomic rank
#cut -f 1,3,5 final.4ant.cons.tax.summary|sort -n > final.4ant.list.tax.summary

##To make venn diagram of each ant species, split the sequences in the fasta, names and groups files into 4 groups, each group represents each ant species
# The four ant species groups are:
# Trachymyrmex_zeteki
# Cyphomyrmex_longiscapus
# Cyphomyrmex_muelleri
# Mycocepurus_smithii
# output: analysis.trim.4ant.Trachymyrmex_zeteki.fasta, analysis.4ant2.Trachymyrmex_zeteki.groups, analysis.trim.4ant.Trachymyrmex_zeteki.names; analysis.trim.4ant.Cyphomyrmex_longiscapus.fasta, analysis.4ant2.Cyphomyrmex_longiscapus.groups, analysis.trim.4ant.Cyphomyrmex_longiscapus.names; analysis.trim.4ant.Cyphomyrmex_muelleri.fasta, analysis.4ant2.Cyphomyrmex_muelleri.groups, analysis.trim.4ant.Cyphomyrmex_muelleri.names; analysis.trim.4ant.Mycocepurus_smithii.fasta, analysis.4ant2.Mycocepurus_smithii.groups, analysis.trim.4ant.Mycocepurus_smithii.names
mothur "#split.groups(fasta=analysis.trim.4ant.fasta, group=analysis.4ant2.groups, name=analysis.trim.4ant.names, groups=Trachymyrmex_zeteki-Cyphomyrmex_longiscapus-Cyphomyrmex_muelleri-Mycocepurus_smithii)"
