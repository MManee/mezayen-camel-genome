#!/usr/bin/env bash
set -euo pipefail

# Reviewer-driven Illumina mapping against the final genome assembly.
#
# BWA-MEM2 version used: 2.2.1
# mosdepth version used: 0.3.13
# Historical SAMtools version was not captured and is therefore not stated.

PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
DATA_DIR="${DATA_DIR:-${PROJECT_DIR}/data}"
RESULTS_DIR="${RESULTS_DIR:-${PROJECT_DIR}/results}"

REF="${REF:-${DATA_DIR}/MazayanCamel.fasta}"
ILLUMINA_DIR="${ILLUMINA_DIR:-${DATA_DIR}/illumina}"
OUT="${OUT:-${RESULTS_DIR}/illumina_mapping}"

BWA_THREADS="${BWA_THREADS:-64}"
SORT_THREADS="${SORT_THREADS:-16}"
MERGE_THREADS="${MERGE_THREADS:-32}"
MOSDEPTH_THREADS="${MOSDEPTH_THREADS:-32}"

mkdir -p "${OUT}"

for LANE in L001 L002 L003 L004; do
    R1="${ILLUMINA_DIR}/3_S1_${LANE}_R1_001.fastq.gz"
    R2="${ILLUMINA_DIR}/3_S1_${LANE}_R2_001.fastq.gz"

    bwa-mem2 mem \
        -t "${BWA_THREADS}" \
        "${REF}" \
        "${R1}" \
        "${R2}" \
    | samtools sort \
        -@ "${SORT_THREADS}" \
        -o "${OUT}/${LANE}.sorted.bam" \
        -
done

samtools merge \
    -@ "${MERGE_THREADS}" \
    -o "${OUT}/illumina.sorted.bam" \
    "${OUT}"/L00*.sorted.bam

samtools index \
    -@ "${SORT_THREADS}" \
    "${OUT}/illumina.sorted.bam"

samtools flagstat \
    "${OUT}/illumina.sorted.bam" \
    > "${OUT}/illumina.flagstat.txt"

samtools coverage \
    "${OUT}/illumina.sorted.bam" \
    > "${OUT}/illumina.coverage_per_scaffold.tsv"

mosdepth \
    --threads "${MOSDEPTH_THREADS}" \
    --by 100000 \
    "${OUT}/illumina" \
    "${OUT}/illumina.sorted.bam"

samtools coverage \
    -q 20 \
    "${OUT}/illumina.sorted.bam" \
    > "${OUT}/illumina.coverage_MAPQ20.tsv"

echo "Illumina final-assembly mapping QC completed."
