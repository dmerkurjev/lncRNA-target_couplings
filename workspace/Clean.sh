#!/bin/bash

# RNA-seq mini-pipeline: QC → alignment → counting

# -------------------- Setup --------------------


# Define project structure relative to current location
PROJECT_DIR="./data_pre_processing"
mkdir -p "${PROJECT_DIR}"/{raw,fastq,aligned,counts,logs,qc,STAR_index}


cd "${PROJECT_DIR}/raw"


# Group SRA run IDs by biological sample (4 runs each)
youngminusd=(SRX7865899)   # SRX7865899
youngplusd=(SRX7865900)   # SRX7865900
senescentminusd=(SRX7865901)    # SRX7865901
senescentplusd=(SRX7865902)    # SRX7865902

# -------------------- Download & Convert --------------------

# Download .sra files
for r in "${youngminusd[@]}" "${youngplusd[@]}" "${senescentminusd[@]}" "${senescentplud[@]}"; do
  prefetch "$r"
done

# Convert to gzipped FASTQ
for r in "${youngminusd[@]}" "${youngplusd[@]}" "${senescentminusd[@]}" "${senescentplud[@]}"; do
  fasterq-dump -e 16 -p -O . "$r"
  gzip -f "${r}.fastq"
done

# Concatenate per-sample FASTQs
cat "${youngminusd[@]/%/.fastq.gz}"  > ym.fastq.gz
cat "${youngplusd[@]/%/.fastq.gz}"  > yp.fastq.gz
cat "${senescentminusd[@]/%/.fastq.gz}" > sm.fastq.gz
cat "${senescentplusd[@]/%/.fastq.gz}" > sp.fastq.gz

# Move to fastq/ folder
mv Hyp*.fastq.gz Norm*.fastq.gz ../fastq/

# -------------------- QC --------------------

cd ../fastq
fastqc ym.fastq.gz yp.gz sm.fastq.gz sp.fastq.gz \
  -o ../qc --threads 16

# -------------------- Alignment (STAR) --------------------

cd ../STAR_index
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_29/GRCh38.primary_assembly.genome.fa.gz
unzip GRCh38.primary_assembly.genome.fa.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_29/gencode.v29.annotation.gtf.gz
unzip gencode.v29.annotation.gtf.gz

module load star
GENOMEDIR="./RNAseq/genome/"
mdkir -p $GENOMEDIR/STAR
STAR --runThreadN 23 --runMode genomeGenerate --genomeDir $GENOMEDIR/STAR --genomeFastaFiles $GENOMEDIR/GRCh38.primary_assembly.genome.fa --sjdbGTFfile $GENOMEDIR/gencode.v29.primary_assembly.annotation.gtf
cd ../trimmed
STAR --genomeDir indexes/chr10 \
      --readFilesIn ym.fastq.gz yp.fastq.gz sm.fastq.gz sp.fastq.gz \
      --readFilesCommand zcat \
      --outSAMtype BAM SortedByCoordinate \
      --quantMode GeneCounts \
      --outFileNamePrefix alignments/

# -------------------- Quantification (featureCounts) --------------------

cd ..
curl -L -o gencode.v48.annotation.gtf.gz \
  https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_48/gencode.v48.annotation.gtf.gz
gunzip -f gencode.v48.annotation.gtf.gz

featureCounts -T 16 -t exon -g gene_name \
  -a gencode.v48.annotation.gtf \
  -o counts/raw_counts_gene_sym.txt aligned/*.bam \
  &> logs/featureCounts_gene_sym.log

# Format counts matrix
{ printf "GeneSymbol\t"; head -n 2 counts/raw_counts_gene_sym.txt | tail -n 1 | cut -f7-; } > counts/final_counts_symbols.tsv
tail -n +3 counts/raw_counts_gene_sym.txt | \
  awk -v OFS="\t" '{ out=$1; for(i=7;i<=NF;i++) out=out OFS $i; print out }' >> counts/final_counts_symbols.tsv

sed -i '' '1 s|aligned/||g; 1 s|\.bam||g' counts/final_counts_symbols.tsv

# Done
echo "Pipeline complete. Output saved in: ${PROJECT_DIR}/counts/final_counts_symbols.tsv"
