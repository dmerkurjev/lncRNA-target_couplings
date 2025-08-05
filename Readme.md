Senescence RNA-seq — Preprocessing & Analysis

This repository contains an end-to-end workflow for RNA-seq analysis of early passage and senescent BJ fibroblasts in the absence or continued presence of doxycycline (20nm).
It includes two main components:

Preprocessing (preprocess.sh)
Downloads SRA runs, builds 4 sample FASTQs, performs QC, alignment, and outputs gene transcription level.

Analysis (lncRNAseq_analysis.Rmd)
Performs differential expression analysis using edgeR, generates PCA and volcano plots, and visualizes gene expression levels.

Data

SRA BioProject: PRJNA610861 
BJ fibroblasts transduced with doxycycline inducible empty vector control retroviruses were grown in the absence
or continued presence of doxycycline (20nm), and young-quiescent or senescent cells were collected for RNA-seq. 
Senescent and young doxycycline treated samples were compared for changes in genes expression, and senescent and 
young doxycycline untreated samples were compared separately.

Sample 1: SRX24155225 (Lane 1)
cell line: ECC_1
treatment: siRNA

Sample 2: SRX24155226 (Lane 2)
cell line: ECC_1
treatment: siRNA

Sample 3: SRX24155239 (Lane 1)
cell line: NCI-H460
treatment: siRNA

Sample 4: SRX24155240 (Lane 2)
cell line: NCI-H460
treatment: siRNA

Sample 5: SRX24155254 (Lane 1)
cell line: PC-3
treatment: siRNA

Sample 6: SRX24155255 (Lane 2)
cell line: PC-3
treatment: siRNA

Sample 7: SRX24155181 (Lane 1)
cell line: PC-3
treatment: siRNA

Sample 8: SRX24155182 (Lane 2)
cell line: PC-3
treatment: siRNA

Reference files:

Transcript annotation: gencode.v16.annotation.gtf
Alignment index: hg19
Related publication:
PMID: 1096299

Directory Output

The preprocessing script creates a structured working directory data_pre_processing/ containing:

raw/      # downloaded and processed SRA FASTQs  
fastq/    # concatenated FASTQs (one per sample)  
aligned/  # STAR-aligned BAMs  
counts/   # gene-level count matrix  
logs/     # logs from trimming, alignment, counting  
qc/       # FastQC output 
