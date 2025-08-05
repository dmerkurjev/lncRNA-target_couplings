{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 paper_title:  Coordinated regulation by lncRNAs results in tight lncRNA–target couplings
journal: Proc Natl Acad Sci U S A\
publication_date: "2024-04-05"\
doi: 10.1073/pnas.2506321122\
series_accession: GSE263343\
bioproject: PRJNA1096299\
domain: rna_seq\
organism: Homo sapiens\
experiment_type: RNA seq\
platform: Illumina Illumina NovaSeq 6000\
ref_genome: Homo sapiens (human) genome assembly GRCh37 (hg19) \
read_type: paired_end\
sample_count: 4\
sra_runs_total: 8\
\
samples:\
  Young_1:\
    condition: minus_dox\
    sra_runs: [SRX7865899]\
  Young_2:\
    condition: plus_dox\
    sra_runs: [SRX7865900]\
  Senescent_1:\
    condition: minus_dox\
    sra_runs: [SRX7865901]\
  Senescent_2:\
    condition: plus_dox\
    sra_runs: [SRX7865902]\
\
paths:\
  fastq: fastq/\
  aligned: aligned/\
  counts: counts/\
  logs: logs/\
  qc: qc/\
  reference:\
    hisat2_index: STAR_index/hg38/genome\
    annotation_gtf: gencode.v48.annotation.gtf\
\
workflow:\
  threads: 16\
  aligner: STAR\
  quantifier: normalizedcounts\
notes: "Genome wide expression analysis of young vs senescent BJ fibroblasts"}
