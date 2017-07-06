# FieldLabComparison

Scripts for microbiome analysis of bacterial 16S sequences from ants.

* data: PRJNA170251 (Mycocepurus) and PRJNA170250 (Trachymyrmex/Cyphomyrmex)
	* download metadata sheets for each from SRA, put in `data/`

**Dependencies:**
* [SRA Toolkit v2.8.1or higher](https://github.com/ncbi/sra-tools) for data download
* [MothuR](https://mothur.org/wiki/Download_mothur) for raw data cleaning and OTU assessment

**Analysis Design**
* MothuR analysis based on [454](https://www.mothur.org/wiki/454_SOP) and [MiSeq](https://www.mothur.org/wiki/MiSeq_SOP) tutorials to create OTU table
* Visualization and hypothesis testing in R

**Workflow**
* `dataDownload.sh` download data from NCBI SRA using user-supplied list of accession numbers
* `dataCheck.sh`
* `mothur_SilvaRef.bat` create custom Silva alignment for reference
