# To download the data:

# Create environment
conda create -n lncRNA-target_couplings -c bioconda -c conda-forge \
  sra-tools fastqc multiqc hisat2 samtools trimmomatic subread -y
conda activate lncRNA-target_couplings

# Folder setup
mkdir -p ~/0_lncRNA-target_couplings/{data,fastq,trimmed,aligned,counts,logs,qc}
cd ~/0_lncRNA-target_couplings/data

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR028/28555/SRR28555713/SRR28555713.lite.1 # SRX24155225: siRNA_ECC-1_NT_Rep1_L1

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR028/28555/SRR28555712/SRR28555712.lite.1 # SRX24155226: siRNA_ECC-1_NT_Rep1_L2

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR028/28555/SRR28555699/SRR28555699.lite.1 # SRX24155239: siRNA_NCI-H460_NT_Rep1_L1

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR028/28555/SRR28555697/SRR28555697.lite.1 # SRX24155240: siRNA_NCI-H460_NT_Rep1_L2

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR028/28555/SRR28555684/SRR28555684.lite.1 # SRX24155254: siRNA_PC-3_NT_Rep1_L1

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR028/28555/SRR28555683/SRR28555683.lite.1 # SRX24155255: siRNA_PC-3_NT_Rep1_L2

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR028/28555/SRR28555757/SRR28555757.lite.1 # SRX24155181: siRNA_PC-3_siDICER1_Rep1_L1

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR028/28555/SRR28555756/SRR28555756.lite.1 # SRX24155182: siRNA_PC-3_siDICER1_Rep1_L2

for r in "${SRR[@]}"; do
  fasterq-dump -e 16 -p -O . "$r"
  gzip -f "${r}.fastq"
done

