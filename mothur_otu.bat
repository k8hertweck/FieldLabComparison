## Microbiome Ant Field vs Lab Analysis OTUs using mothur

# usage: mothur mothur_otu.bat
# execute within project directory
# for explanation of commands: https://www.mothur.org/wiki/Sequence_processing

# change mothur working directory to analysis
set.dir(input=analysis)

# summarize complete sequences
# output: analysis.trim.summary
summary.seqs(fasta=analysis.trim.fasta)

# simplifying the dataset to only unique sequences
# output: analysis.trim.names, analysis.trim.unique.fasta 
unique.seqs(fasta=analysis.trim.fasta)

# inspect unique sequences
# output: analysis.trim.unique.summary 
summary.seqs(fasta=analysis.trim.unique.fasta, name=analysis.trim.names)

# align our data to silva reference
# output: analysis.trim.unique.align, analysis.trim.unique.align.report, analysis.trim.unique.flip.accnos 
align.seqs(fasta=analysis.trim.unique.fasta, reference=silva/silva.nr_v128.pcr.align, flip=T, processors=6)

# inspect aligned sequences
# output: analysis.trim.unique.summary
summary.seqs(fasta=analysis.trim.unique.align, name=analysis.trim.names)

# remove sequences outside the desired range of alignment space
# output: analysis.trim.unique.good.align, analysis.trim.unique.bad.accnos, analysis.good.names, analysis.trim.good.groups file
screen.seqs(fasta=analysis.trim.unique.align, name=analysis.trim.names, group=analysis.groups, optimize=end, criteria=90, processors=6)

# inspect sequences 
# output: analysis.trim.unique.good.summary 
summary.seqs(fasta=analysis.trim.unique.good.align, name=analysis.trim.good.names) 

# filter alignment to remove columns that don't contain data
# the parameter trump=. will remove any column that has a "." character, which indicates missing data
# vertical=T option will remove any column that contains exclusively gaps
# output: analysis.trim.unique.good.filter.fasta, filter file
filter.seqs(fasta=analysis.trim.unique.good.align, vertical=T, processors=6)

# remove redundant sequences in the alignment region
# output: analysis.trim.unique.good.filter.names, analysis.trim.unique.good.filter.unique.fasta
unique.seqs(fasta=analysis.trim.unique.good.filter.fasta, name=analysis.trim.good.names)

# pre-cluster within each group 
# output: analysis.trim.unique.good.filter.unique.precluster.fasta, analysis.trim.unique.good.filter.unique.precluster.names, analysis.trim.unique.good.filter.unique.precluster.field.map, analysis.trim.unique.good.filter.unique.precluster.lab.map 
pre.cluster(fasta=analysis.trim.unique.good.filter.unique.fasta, name=analysis.trim.unique.good.filter.names, group=analysis.good.groups, diffs=2, processors=6)

# inspect the preclustered files
# output: analysis.trim.unique.good.filter.unique.precluster.summary 
summary.seqs(fasta=analysis.trim.unique.good.filter.unique.precluster.fasta, name=analysis.trim.unique.good.filter.unique.precluster.names)

# detecting and removing chimeras (unnecessary since completed in SRA data)
# output: analysis.trim.unique.good.filter.unique.precluster.denovo.uchime.chimeras, analysis.trim.unique.good.filter.unique.precluster.denovo.uchime.accnos 
#chimera.uchime(fasta=analysis.trim.unique.good.filter.unique.precluster.fasta, name=analysis.trim.unique.good.filter.unique.precluster.names, group=analysis.good.groups, processors=6)

#generate count table to be used
count.seqs(name=analysis.trim.unique.good.filter.unique.precluster.names)

#generate taxonomy file
classify.seqs(fasta=analysis/analysis.trim.unique.good.filter.unique.precluster.fasta, count=analysis/analysis.trim.unique.good.filter.unique.precluster.count_table, reference=silva/silva.nr_v128.pcr.align, taxonomy=silva/silva.nr_v128.tax, cutoff=80)

# rename files (rename command is unreliable)
system(cp analysis/analysis.trim.unique.good.filter.unique.precluster.fasta analysis/final.fasta)
#rename.file(input=analysis.trim.unique.good.filter.unique.precluster.fasta, output=final.fasta)
system(cp analysis/analysis.trim.unique.good.filter.unique.precluster.names analysis/final.names)
#rename.file(input=analysis.trim.unique.good.filter.unique.precluster.names, output=final.names)

system(cp analysis/analysis.trim.unique.good.filter.unique.precluster.nr_v128.wang.taxonomy analysis/final.taxonomy)
#rename.file(input=analysis.trim.unique.good.filter.unique.precluster.nr_v128.wang.taxonomy, output=final.taxonomy)

system(cp analysis/analysis.good.groups analysis/final.groups)
#rename.file(input=analysis.good.groups, output=final.groups)

# Option 1 or 2 are different methods available to build OTUs
# Output from Option 2 should be similar to Option 1
# This workflow uses Option 1.

# Option 1: generate distance matrix
# cutoff of 0.15 means removing all pairwise distance larger than 0.15
# If output is >100 GBs of memory, something is wrong
# output: final.dist
dist.seqs(fasta=final.fasta, cutoff=0.15, processors=6)

# cluster sequences into OTUs based on distance matrix
# cutoff is typically 0.03 for further analysis
# output: final.an.sabund, final.an.rabund, final.an.list 
cluster(column=final.dist, name=final.names) 

# Option 2: quick and dirty
#cluster.split(fasta=final.fasta, taxonomy=final.taxonomy, name=final.names, taxlevel=3, processors=6)

#The output from Option 2 should be about the same as Option 1. The remainder of this code uses Option 1

#create a table that indicates the number of times an OTU shows up in each sample also known as a shared file
#input: final.an.list and final.groups file
#output: final.an.shared file
make.shared(list=final.an.list, group=final.groups, label=0.03)

#The final step to getting good OTU data is to normalize the number of sequences in each sample
#First we need to know how many sequences are in each step
count.groups()

#sub-sample all the samples to the sample with the fewest sequences(4420)
#input: final.an.shared file
#output: final.an.0.03.subsample.shared
sub.sample(shared=final.an.shared, size=4420)

#Extract specific ant species to view in venn diagram using phylotype analysis 
#goes through the taxonomy file and bins sequences together that have the same taxonomy, 6 different bins.These bins are known as phylotypes.
#output: final.tx.list, final.tx.rabund, final.tx.sabund
phylotype(taxonomy=final.taxonomy, name=final.names)

#get the taxonomy of each phylotype, there are 6 phylotypes
#produces consensus taxnomy & summary taxonomy files for each phylotype
#output files: 
#final.tx.1.cons.taxonomy, final.tx.1.cons.tax.summary,
#final.tx.2.cons.taxonomy, final.tx.2.cons.tax.summary,
#final.tx.3.cons.taxonomy, final.tx.3.cons.tax.summary,
#final.tx.4.cons.taxonomy, final.tx.4.cons.tax.summary,
#final.tx.5.cons.taxonomy, final.tx.5.cons.tax.summary,
#final.tx.6.cons.taxonomy, final.tx.6.cons.tax.summary
classify.otu(list=final.tx.list, name=final.names, taxonomy=final.taxonomy)

#merge all the taxonomy summary files together in one file called final.cons.tax.summary
merge.taxsummary(input=final.tx.1.cons.tax.summary-final.tx.2.cons.tax.summary-final.tx.3.cons.tax.summary-final.tx.4.cons.tax.summary-final.tx.5.cons-final.tx.6.cons.tax.summary, output=final.cons.tax.summary)

#In terminal,create final.list.tax.summary file to determine lowest taxonomic rank in merged taxonomy summary file, lowest taxonomic rank is genus
#selected 3 columns:
#taxlevels(put in numerical order)
#taxon name
#total no. of sequences for specific taxonomic rank
#cut -f 1,3,5 final.cons.tax.summary|sort -n > final.list.tax.summary

#get lineage for the 6 groups
get.lineage(constaxonomy=final.tx.1.cons.taxonomy,shared=final.an.0.03.subsample.shared,taxon=Edaphobacter)
get.lineage(constaxonomy=final.tx.2.cons.taxonomy,shared=final.an.0.03.subsample.shared,taxon=Edaphobacter)
get.lineage(constaxonomy=final.tx.3.cons.taxonomy,shared=final.an.0.03.subsample.shared,taxon=Edaphobacter)
get.lineage(constaxonomy=final.tx.4.cons.taxonomy,shared=final.an.0.03.subsample.shared,taxon=Edaphobacter)
get.lineage(constaxonomy=final.tx.5.cons.taxonomy,shared=final.an.0.03.subsample.shared,taxon=Edaphobacter)
get.lineage(constaxonomy=final.tx.6.cons.taxonomy,shared=final.an.0.03.subsample.shared,taxon=Edaphobacter)

