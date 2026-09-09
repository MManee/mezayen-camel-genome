#!/usr/bin/env bash
set -euo pipefail

# Liftoff homology-transfer annotation
#
# Reference:
# Camelus dromedarius GCF_036321535.1 (mCamDro1.pat)
#
# Version note:
# The retained project environment reports Liftoff v1.6.3.
# The original pipeline did not record the Liftoff version at execution time.

THREADS="${THREADS:-$(nproc)}"

PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
DATA_DIR="${DATA_DIR:-${PROJECT_DIR}/data}"
REF_DIR="${REF_DIR:-${PROJECT_DIR}/reference}"
OUT_DIR="${OUT_DIR:-${PROJECT_DIR}/results/liftoff}"

TARGET_GENOME="${TARGET_GENOME:-${DATA_DIR}/MazayanCamel.fasta.masked}"
REFERENCE_GENOME="${REFERENCE_GENOME:-${REF_DIR}/GCF_036321535.1_mCamDro1.pat_genomic.fna}"
REFERENCE_GFF="${REFERENCE_GFF:-${REF_DIR}/GCF_036321535.1_mCamDro1.pat_genomic.gff}"

mkdir -p "${OUT_DIR}"

liftoff \
    -g "${REFERENCE_GFF}" \
    -o "${OUT_DIR}/liftoff_output.gff3" \
    -u "${OUT_DIR}/liftoff_unmapped.txt" \
    -exclude_partial \
    -p "${THREADS}" \
    "${TARGET_GENOME}" \
    "${REFERENCE_GENOME}"

echo "Liftoff completed."
echo "Output: ${OUT_DIR}/liftoff_output.gff3"
echo "Unmapped features: ${OUT_DIR}/liftoff_unmapped.txt"
