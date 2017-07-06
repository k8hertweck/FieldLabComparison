## Create custom Silva alignment for use in Mothur

# usage: mothur mothur_SilvaRef.bat
# execute within project directory

# rename downloaded database
#system(cp Silva.seed_128 SilvaSeed.fasta)
#or using the silva reference files from the MiSeq SOP: silva.bacteria.fasta 

# aligns known sequence to complete database
#input: E.coliV1-V3.fasta, silva.bacteria.fasta 
#output: E.coliV1-V3.align, E.coliV1-V3.align.report, E.coliV1-V3.flip.accnos file
align.seqs(fasta=silva/E.coliV1-V3.fasta, template=silva/silva.bacteria.fasta)

# identify start and stop of V1-V3 region of 16S rRNA 
#input: E.coliV1-V3.align
#output: E.coliV1-V3.summary
summary.seqs(fasta=silva/E.coliV1-V3.align)

# trim the template to V1-V3
#input: silva.bacteria.fasta
#output: silva.bacteria.pcr.fasta 
pcr.seqs(fasta=silva/silva.bacteria.fasta, start=1115, end=13881, keepdots=FALSE)
