#### Microbiome hypothesis testing with phyloseq ####

# install bioconductor package
#source("http://bioconductor.org/biocLite.R")
#biocLite('phyloseq')
# load package
library(phyloseq)
# install ggplot2
#install.packages("ggplot2")
#install.packages("VennDiagram")
#install.packages("gplots")
# load package
library(ggplot2)
library(VennDiagram)
library(gplots)

#### data import ####
# import biom (otu table and tax table)
otuAll <- import_biom("../analysis/final.opti_mcc.0.03.biom")
otuAll
otu <- import_biom("../analysis/final.opti_mcc.0.03.subsample.0.03.biom")
otu
# set taxonomic ranks
rank_names(otu)
colnames(tax_table(otu)) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus")
rank_names(otu)
# import map (metadata) file
map <- import_qiime_sample_data("../metadata_mapping_file.txt")
str(map)
# import tree file
#rep_tre <- read_tree("FILENAME")
#rep_tre
# combine otu/tax and map
comb <- merge_phyloseq(otu, map) #rep_tre)
str(comb)
comb

#### inspect combined otu/taxonomy/map data ####

# samples
sample_names(comb)
nsamples(comb)
sample_variables(comb) # field_lab, garden_worker, location, genus, species, colony
sample_sums(comb)
# taxa
get_taxa_unique(comb, "Kingdom")
get_taxa_unique(comb, "Phylum")
get_taxa_unique(comb, "Genus")
taxa_sums(comb)
taxa_sums(comb)[1:10] # ten most frequent

# extract most frequent taxa
taxa_names(comb)[1:20]
topTaxa <- names(sort(taxa_sums(comb), decreasing = TRUE)[1:20])
topComb <- prune_taxa(topTaxa, comb)
tax_table(topComb)

# look for outlier samples
plot_bar(topComb, fill="Phylum")
# sort according to field/lab
plot_bar(topComb, fill="Phylum", facet_grid = "field_lab")
# sort according to study
plot_bar(topComb, fill="Phylum", facet_grid = "Project")


# subset for only higher frequency reads
combTrim <- prune_samples(sample_sums(comb)>=10, comb)

#### tree plots and testing ####

# plot tree of only top taxa
#plot_tree(topComb, color = "Sample_Type", label.tips = "Phylum", ladderize = "left", justify = "left" , size = "Abundance")

#### richness plots and testing ####

# plot richness
plot_richness(comb, x = "Project", measures = c("Shannon", "Simpson")) +
  geom_boxplot()
plot_richness(comb, x = "field_lab", measures = c("Shannon", "Simpson")) +
  geom_boxplot()
plot_richness(comb, x = "genus", measures = c("Shannon", "Simpson")) +
  geom_boxplot()
plot_richness(comb, x = "species", measures = c("Shannon", "Simpson")) +
  geom_boxplot()
plot_richness(comb, x = "location", measures = c("Shannon", "Simpson")) +
  geom_boxplot()
plot_richness(comb, x = "garden_worker", measures = c("Shannon", "Simpson")) +
  geom_boxplot()

# calculate richness
rich <- estimate_richness(comb) # phyloseq
# add inverse simpson and order by row name
rich <- rich[order(row.names(rich)),]
# order map file by same
mapOrd <- map[order(map$InputFileName)]
# bind tables
richMeta <- cbind(rich, mapOrd)
# run anova with inverse Simpson
richInvSimp <- aov(InvSimpson ~ field_lab, richMeta)
summary(richInvSimp)
TukeyHSD(richInvSimp, "Sample_Type")
# run anova on Shannon
richShann <- aov(Shannon ~ field_lab, richMeta)
summary(richShann)
TukeyHSD(richShann)

#### network plots ####

# plot network (older method)
# mapDist <- make_network(combTrim, type = "samples", distance = "bray", max.dist=0.9, keep.isolates=TRUE)
# plot_network(mapDist, combTrim, color = "field_lab", shape = "field_lab", point_size = 5, hjust = 2)
#
# plot_network(mapDist, combTrim,
#              color = "field_lab", shape = "field_lab", label=NULL) +
#   geom_text(aes(label = State), size = 3.5, hjust = -0.5) +
#   theme(text = element_text(size = 14))

# plot network (newer method)
#plot_net(combTrim, color="field_lab", point_label = "Locality", maxdist = 0.85)

## ordination plots
# NMDS
# combTrim.ord <- ordinate(combTrim, "NMDS", "bray")
# plot_ordination(combTrim, combTrim.ord, type="samples", color="Sample_Type", shape="Locality") +
#   geom_polygon(aes(fill=Sample_Type)) +
#   geom_point(size=5)

# PCoA
#combTrim.ord2 <- ordinate(combTrim, "PCoA", "bray")
#plot_ordination(combTrim, combTrim.ord2, type="samples", color="Sample_Type", shape="Locality") +
#  geom_polygon(aes(fill=Sample_Type)) +
#  geom_point(size=5)

## heatmap
#plot_heatmap(comb.top, "NMDS", "bray", "field_lab", "Family")

#### Venn diagrams ####

# transpose OTU table
t_topComb <- t(otu_table(topComb))
# create a list of OTUs that occur in each sample
field_OTU <- colnames(t_topComb[map$field_lab == "field", apply(t_topComb[map$field_lab == "field",], MARGIN=2, function(x) any(x >0))])
lab_OTU <- colnames(t_topComb[map$field_lab == "lab", apply(t_topComb[map$field_lab == "lab",], MARGIN=2, function(x) any(x >0))])
# plot venn diagram
venn(list(field_OTU, lab_OTU))
