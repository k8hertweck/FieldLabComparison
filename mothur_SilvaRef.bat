## Create custom Silva alignment for use in Mothur 
# replaces silva.bacteria.fasta from MiSeq SOP

# usage: mothur mothur_SilvaRef.bat
# execute within project directory

# aligns known sequence to complete database
# move silva.nr_128.align to the silva directory
# output: E.coliV1V3.align and E.coliV1V3.align.report
align.seqs(fasta=silva/E.coliV1V3.fas, template=silva/silva.nr_v128.align)

# identify start and stop of V1-V3 region of 16S rRNA 
# output: E.coliV1V3.summary
summary.seqs(fasta=silva/E.coliV1V3.align)

# trim the template to V1-V3
# output: silva.nr_v128.pcr.align 
pcr.seqs(fasta=silva/silva.nr_v128.align, start=1115, end=13881, keepdots=FALSE)
