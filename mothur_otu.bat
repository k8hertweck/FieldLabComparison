## OTU calling for microbiome analysis with mothur

## usage: mothur mothur_otu.bat
# execute within project directory
# for explanation of commands: https://www.mothur.org/wiki/Sequence_processing
# any step without time estimate takes less than 1 minute

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

# align our data to silva reference (takes ~10 minutes)
# output: analysis.trim.unique.align, analysis.trim.unique.align.report, analysis.trim.unique.flip.accnos
align.seqs(fasta=analysis.trim.unique.fasta, reference=silva/silva.nr_v128.pcr.align, flip=T, processors=6)

# inspect aligned sequences
# output: analysis.trim.unique.summary
summary.seqs(fasta=analysis.trim.unique.align, name=analysis.trim.names)

# remove sequences outside the desired range of alignment space
# output: analysis.trim.unique.good.align, analysis.trim.unique.bad.accnos, analysis.trim.good.names, analysis.trim.good.groups file
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

# pre-cluster within each group (takes hours)
# output: analysis.trim.unique.good.filter.unique.precluster.fasta, analysis.trim.unique.good.filter.unique.precluster.names, analysis.trim.unique.good.filter.unique.precluster.field.map, analysis.trim.unique.good.filter.unique.precluster.lab.map
pre.cluster(fasta=analysis.trim.unique.good.filter.unique.fasta, name=analysis.trim.unique.good.filter.names, group=analysis.good.groups, diffs=2, processors=6)

# inspect the preclustered files
# output: analysis.trim.unique.good.filter.unique.precluster.summary
summary.seqs(fasta=analysis.trim.unique.good.filter.unique.precluster.fasta, name=analysis.trim.unique.good.filter.unique.precluster.names)

# detecting and removing chimeras (unnecessary since completed in SRA data)
# output: analysis.trim.unique.good.filter.unique.precluster.denovo.uchime.chimeras, analysis.trim.unique.good.filter.unique.precluster.denovo.uchime.accnos
#chimera.uchime(fasta=analysis.trim.unique.good.filter.unique.precluster.fasta, name=analysis.trim.unique.good.filter.unique.precluster.names, group=analysis.good.groups, processors=6)

# generate count table to be used
# output: analysis.trim.unique.good.filter.unique.precluster.count_table
count.seqs(name=analysis.trim.unique.good.filter.unique.precluster.names)

# generate taxonomy file (takes ~1 hour)
# output: analysis.trim.unique.good.filter.unique.precluster.nr_v128.wang.taxonomy
classify.seqs(fasta=analysis.trim.unique.good.filter.unique.precluster.fasta, count=analysis.trim.unique.good.filter.unique.precluster.count_table, reference=silva/silva.nr_v128.pcr.align, taxonomy=silva/silva.nr_v128.tax, cutoff=80, processors=6)

# rename files (rename command is unreliable)
system(cp analysis/analysis.trim.unique.good.filter.unique.precluster.fasta analysis/final.fasta)
system(cp analysis/analysis.trim.unique.good.filter.unique.precluster.names analysis/final.names)
system(cp analysis/analysis.trim.unique.good.filter.unique.precluster.nr_v128.wang.taxonomy analysis/final.taxonomy)
system(cp analysis/analysis.good.groups analysis/final.groups)

# build OTUs
# two methods, option 1 used here
# Option 1: generate distance matrix (9 hours to calculate distance, )
# cutoff of 0.15 means removing all pairwise distance larger than 0.15
# If output is >100 GBs of memory, something is wrong
# output: final.dist
dist.seqs(fasta=final.fasta, cutoff=0.15, processors=6)
# cluster sequences into OTUs based on distance matrix
# cutoff is 0.03 (default) for further analysis
# output: final.opti_mcc.list, final.opti_mcc.steps, final.opti_mcc.sabund, final.opti_mcc.rabund, final.opti_mcc.sensspec
cluster(column=final.dist, name=final.names)
# Option 2: quick and dirty alternative (should be about the same as Option 1)
#cluster.split(fasta=final.fasta, taxonomy=final.taxonomy, name=final.names, taxlevel=3, processors=6)

# create table indicating number of times an OTU shows up in each sample (shared file)
# output: final.opti_mcc.shared file
make.shared(list=final.opti_mcc.list, group=final.groups, label=0.03)

# normalize by number of sequences
# count sequences
count.groups(shared=final.opti_mcc.shared,)
# sub-sample to fewest sequences
# output: final.an.0.03.subsample.shared
sub.sample(shared=final.opti_mcc.shared, size=348)

# extract taxonomy for each OTU
# output: final.opti_mcc.0.03.cons.taxonomy, final.opti_mcc.0.03.cons.tax.summary
classify.otu(list=final.opti_mcc.list, name=final.names, taxonomy=final.taxonomy, label=0.03)

# make biom files
# all sequences
# output: final.opti_mcc.0.03.biom
make.biom(shared=final.opti_mcc.shared, constaxonomy=final.opti_mcc.0.03.cons.taxonomy)
# subsampled sequences
# output: final.opti_mcc.0.03.subsample.0.03.biom
make.biom(shared=final.opti_mcc.0.03.subsample.shared, constaxonomy=final.opti_mcc.0.03.cons.taxonomy)

# build phylogenetic tree
# construct distance matrix
#dist.seqs(fasta=final.fasta, output=phylip, processors=2)
# build tree with clearcut
#clearcut(phylip=final.phylip.dist)
