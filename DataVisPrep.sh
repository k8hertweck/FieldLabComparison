#sed is a stream editor that allows the user to make changes to files using the command line
#s/ command is used to substitute "." with "-"
#/g stands for "global", meaning to do this for the whole line
#replace "." with "-" in entire fasta file then replace "-" with "." in sequence headers
sed 's/\./\-/g' final.fasta | sed 's/\-1/\.1/g' | sed 's/\-2/\.2/g' | sed 's/\-3/\.3/g' | sed 's/\-4/\.4/g' | sed 's/\-5/\.5/g' | sed 's/\-6/\.6/g' | sed 's/\-7/\.7/g' | sed 's/\-8/\.8/g' | sed 's/\-9/\.9/g' > final.edited.fasta

#Navigate to the directory that has the Fasta2Phylip.pl script on your local computer.
#Execute the command below which uses a perl script to convert the fasta file to phylip format to be used in tree visualization
#usage: perl perlScript path\to\InputFastaFile path\to\OutputPhyFile
#input: final.edited.fasta
#output: final.edited.fasta.phy
perl Fasta2Phylip.pl mothurDataVisualizations/final.edited.fasta mothurDataVisualizations/final.edited.phy

#Navigate to the directory that contains the raxml executable file on your local directory
#RAxML program will convert the phylip formatted file into a tree file that can be visualized with phyloseq R package or FigTree.
# requires an aligned fasta format & a file in aligned phylip format
# the -f a specifies rapid Bootstrap analysis and search for best ­scoring ML tree in one program 
# the -# flag specifies number of bootstrap runs  
# the -n flag specifies job name (used in output files)
# the -m flag specifies binary model selection
# the -x flag specifies randomly selected number
# the -s flag specifies the location of the phylip formatted file
# the -p flag specifies randomly selected number
#generate #Maximum likelihood (ML) phylogenetic tree inference with RAxML


#In the terminal, navigate to the directory that holds the phylip formatted file
# requires an aligned fasta format & a file in aligned phylip format
# the -f a specifies rapid Bootstrap analysis and search for best ­scoring ML tree in one program 
# the -# flag specifies number of bootstrap runs  
# the -n flag specifies job name (used in output files)
# the -m flag specifies binary model selection
# the -x flag specifies randomly selected number
# the -s flag specifies the location of the phylip formatted file
# the -p flag specifies randomly selected number
# the -w flag specifies a working directory where the result files are saved
#First, run raxml to see if there are any duplicates so that they will be removed from the phylip file and renamed *.fasta.phy.reduced file 
raxml -f a -# 1000 -n mothur -m GTRGAMMA -x 123456 -s ../../../home/hertwecklab/Desktop/Andrea/Kellner-Ortiz_project/final.edited.fasta.phy.reduced -p 244556 -w ../../../home/hertwecklab/Desktop/Andrea/Kellner-Ortiz_project/results
