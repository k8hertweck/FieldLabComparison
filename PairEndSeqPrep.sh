#Join paired end sequences for Seal data
#R1 fastq files has forward sequences
#R2 fastq file has reverse sequences

#activate qiime 1
source activate qiime1

join_paired_ends.py -m SeqPrep -f ../Seal_IlluminaData/Seal_BodyParts/SAM1-16_S3_L001_R1_001.fastq -r ../Seal_IlluminaData/Seal_BodyParts/SAM1-16_S3_L001_R2_001.fastq -o ../Seal_IlluminaData/Seal_BodyParts/JoinResults

extract_barcodes.py -f JoinResults/joinfile -c barcode_paired_stitched --attempt_read_reorientation --bc1_len 8 --bc2_len 8 --rev_comp_bc2 -m mapping_file.txt -o barcodeResults

split_libraries_fastq.py -i barcodeResults/fastqread -b $barcode -m mapping_file.txt -q $qual --barcode_type 8 -o $output