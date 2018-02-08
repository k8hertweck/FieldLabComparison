## Create custom Silva alignment for use in Mothur

# usage: mothur mothur_SilvaRef.bat
# execute within project directory

# rename downloaded database
#system(cp Silva.seed_128 SilvaSeed.fasta)
#or using the silva reference files from the MiSeq SOP: silva.nr_128.align as seen below
#download silva reference file version 128
wget https://www.mothur.org/w/images/b/b4/Silva.nr_v128.tgz

#untar and gunzip reference file
tar -zxvf Silva.nr_v128.tgz

#move silva.nr_v128.align reference file  to silva directory
mv silva.nr_v128.align silva/

# aligns known sequence to complete database
# output: E.coliV1V3.align, E.coliV1V3.align.report, E.coliV1V3.flip.accnos file
align.seqs(fasta=silva/E.coliV1V3.fas, template=silva/silva.bacteria.fasta)

# identify start and stop of V1-V3 region of 16S rRNA 
# output: E.coliV1V3.summary
summary.seqs(fasta=silva/E.coliV1V3.align)

# trim the template to V1-V3
# output: silva.bacteria.pcr.fasta 
pcr.seqs(fasta=silva/silva.bacteria.fasta, start=1115, end=13881, keepdots=FALSE)
