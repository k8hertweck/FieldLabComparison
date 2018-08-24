#### Microbiome hypothesis testing with phyloseq ####

# install bioconductor package
#source("http://bioconductor.org/biocLite.R")
#biocLite('phyloseq')
# load package
library(phyloseq)
# install ggplot2
#install.packages("ggplot2")
# load package
library(ggplot2)

#### data import ####
# import biom (otu table and tax table)
biom <- import_biom("final.opti_mcc.0.03.biom")
biom
# the code below corrects this issue with taxonomic ranks
# view names
rank_names(biom)
# correct taxonomy
colnames(tax_table(biom)) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus")
rank_names(biom) 
# import map (metadata) file
map <- import_qiime_sample_data("../metadata_mapping_file.txt")
str(map)
# import tree file
rep_tre <- read_tree("tree.nwk")
rep_tre
# combine otu/tax and map
comb <- merge_phyloseq(biom, map) #, rep_tre)
str(comb)
comb

#### inspect combined otu/taxonomy/map data ####
## samples
# show sample names
sample_names(comb)
# count number of samples
nsamples(comb)
# show variables (metadata) for samples
sample_variables(comb)
## taxa
# show unique phyla in dataset
get_taxa_unique(comb, "Phylum")
# show total counts for each taxon in dataset
taxa_sums(comb)
# show only top 10 most frequent taxa
taxa_sums(comb)[1:10]
# examine total counts for each sample 
sample_sums(comb)

# rarefy samples to even depth 
comb.rar <- rarefy_even_depth(comb)
# this object can be used in place of comb anywhere below

#### summary plots and statistical testing
## richness
# plot richness calculated across several metrics
plot_richness(comb)
# plot richness by body site
plot_richness(comb, x = "BodySite")
# plot richness by subject
plot_richness(comb, x = "Subject")
# plot richness by reported antibiotic usage
(p <- plot_richness(comb, x = "ReportedAntibioticUsage"))
p + geom_boxplot(data = p$data, 
                 aes(x = ReportedAntibioticUsage), alpha = 0.1)
# the plot above displays both the boxplots and all data points

## phylogenetic tree
# extract only data from two families
comb.sub <- subset_taxa(comb, Family == "Bacteroidaceae" | Family == "[Paraprevotellaceae]")
# plot tree
plot_tree(comb.sub, color = "ReportedAntibioticUsage", # color by antibiotic usage
          shape = "Genus", label.tips = "Species", # specify shape and labels for tips
          size = "abundance", plot.margin = 0.5, # size points by abundance
          ladderize = TRUE) # order appearance of tips

## abundance bar plots
# identify 10 most abundant taxa
top.taxa <- names(sort(taxa_sums(comb), TRUE)[1:10])
# extract most abundant taxa
comb.top <- prune_taxa(top.taxa, comb)
# plot abundance
plot_bar(comb.top, "BodySite", fill = "ReportedAntibioticUsage", facet_grid = ~Genus)

## ordination plot
# NMDS plot
plot_ordination(comb, ordinate(comb, "MDS"), color = "BodySite") +
  geom_point(size = 3)

## network plot
# calculate distance
comb.net <- make_network(comb, type = "samples", distance = "bray", max.dist = 0.85)
# plot network
plot_network(comb.net, comb, color = "BodySite", shape = "ReportedAntibioticUsage", 
             line_weight = 0.4, label = NULL)

## heatmap
plot_heatmap(comb.top, "NMDS", "bray", "BodySite", "Family")