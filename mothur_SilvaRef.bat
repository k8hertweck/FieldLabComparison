###Need to discuss project directory organization for Silva reference files
#download version 128 full length silva reference sequences and seed silva reference file and rename files
system(cp Silva.nr_128 FullLengthSilva.fasta)
system(cp Silva.seed_128 SilvaSeed.fasta)
#or using the silva reference files from the MiSeq SOP: Silva.bacteria.fasta 

##Using E.coli sequence to determine start and end positions for template
#to align template with the V1-V3 region of 16S rRNA

#input: E.coliV1-V3.fasta, silva.bacteria.fasta 
#output: E.coliV1-V3.align, E.coliV1-V3.align.report, E.coliV1-V3.flip.accnos file
align.seqs(fasta=~/Desktop/FieldLabComparison/E.coliV1-V3.fasta, template=~/Desktop/Silva.bacteria/silva.bacteria.fasta)

#to see where the the V1-V3 region of 16S rRNA starts and ends on the template
#input: E.coliV1-V3.align
#output: E.coliV1-V3.summary
summary.seqs(fasta=~/Desktop/FieldLabComparison/E.coliV1-V3.align)

#trim the template
#input: silva.bacteria.fasta
#output: silva.bacteria.pcr.fasta 
pcr.seqs(fasta=~/Desktop/Silva.bacteria/silva.bacteria.fasta, start=1115, end=13881, keepdots=FALSE)
