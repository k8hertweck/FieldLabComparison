# FieldLabComparison

Scripts for microbiome analysis of bacterial 16S sequences from ants.

**Dependencies:**
* [SRA Toolkit v2.8.1or higher](https://github.com/ncbi/sra-tools) for data download
* [MothuR](https://mothur.org/wiki/Download_mothur) for raw data cleaning and OTU assessment

**Workflow**
* `dataDownload.sh` download data from NCBI SRA using user-supplied list of accession numbers

**Analysis Design**
* MothuR analysis based on [454](https://www.mothur.org/wiki/454_SOP) and [MiSeq](https://www.mothur.org/wiki/MiSeq_SOP) tutorials
