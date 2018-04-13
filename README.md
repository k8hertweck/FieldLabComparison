# FieldLabComparison

Scripts for microbiome analysis of bacterial 16S sequences from ants.

**Data:** 
* SRA accessions:
	* PRJNA170251 (Mycocepurus): metadata in SRA correct, `data/SraRunTableSRP018247.txt`
	* PRJNA170250 (Trachymyrmex/Cyphomyrmex): metadata in SRA is not correct, revised metadata in `data/SraRunTableSRP018246corrected.txt` 
* Silva database:
	* Use [Full length sequences and taxonomy references](https://www.mothur.org/wiki/Silva_reference_files) for version 128, which includes taxonomy file. The `silva.nr_v128.tax` file and `silva.nr_v128.align` file need to be moved to the `silva/`. Another option is to use the `silva.bacteria.fasta` which is a silva reference file from the MiSeq SOP. The `silva.bacteria.fasta` file can be trimmed to the V1-V3 region using the align.seqs() and the `E.coliV1V3.fas` file.

**Dependencies:**
* [SRA Toolkit v2.8.1or higher](https://github.com/ncbi/sra-tools) for data download
* [seq_crumbs](https://bioinf.comav.upv.es/seq_crumbs/) only if using `dataCheck.sh` 
* [MothuR](https://mothur.org/wiki/Download_mothur) for raw data cleaning and OTU assessment

**Analysis Design**
* MothuR analysis based on [454](https://www.mothur.org/wiki/454_SOP) and [MiSeq](https://www.mothur.org/wiki/MiSeq_SOP) tutorials to create OTU table
* Visualization and hypothesis testing in R

**Mothur Workflow**

*For handling 454 data*
* `dataDownload.sh` download data from NCBI SRA (takes several minutes depending on internet connectivity
	* `data/dataCheck.sh` check SRA data against archived sequence files, do not need to run again
* `mothur_SilvaRef.bat` create custom Silva alignment for reference (takes ~10 minutes)
* `mothur_prep.sh` split, trim, and aggregate sequence files (takes several minutes)
* `mothur_otu.bat` processes combined sequences and outputs OTU table

**QIIME Workflow**

*For handling 454 data*
* `dataDownload.sh` download data (as fastq files) from NCBI SRA 
	* `data/dataCheck.sh` check SRA data against archived sequence files, do not need to run again
* `qiime_workflow.sh` uses 3 scripts to take fastq files and obtain an OTU table biom file	
	* `convert_fastaqual_fastq.py` converts fastq to fasta & qual files in qiime
	* `add_qiime_labels.py` combines all fasta files into one fasta file in qiime
		* `metadata_mapping_file.txt` contains data that assist in combining all fasta files into one fasta file in qiime
	* `pick_de_novo_otus.py` a series of 7 scripts that outputs OTU table biom file
		* `qiime_parameters.txt` changes default settings of python script
		
*For handling Illumina data*
* `PairEndSeqPrep.sh` uses 3 scripts to analyze the fastq files and obtain an OTU table biom file	
	* `join_paired_ends.py` joins paired-end Illumina reads
	* `extract_barcodes.py` formats fastq sequence and barcode data to be input data for the next script
		* `mapping_file.txt` contains data that assist in preparing the files as input for the next script
	* `split_libraries_fastq.py` splits libraries according to barcodes specified in mapping file
		* `mapping_file.txt` contains barcode data needed to split libraries in qiime
* `qiime_workflow.sh` uses 3 scripts to take fastq files and obtain an OTU table biom file	
	* `convert_fastaqual_fastq.py` converts fastq to fasta & qual files in qiime
	* `add_qiime_labels.py` combines all fasta files into one fasta file in qiime
		* `metadata_mapping_file.txt` contains data that assist in combining all fasta files into one fasta file in qiime
	* `pick_de_novo_otus.py` a series of 7 scripts that outputs OTU table biom file
		* `qiime_parameters.txt` changes default settings of python script
