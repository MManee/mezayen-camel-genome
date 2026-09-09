#!/usr/bin/env bash
set -euo pipefail

# BRAKER protein-supported gene prediction
#
# Historical workflow:
# BRAKER v3.0.8
# Protein-only EP mode (BRAKER2 workflow within BRAKER v3.0.8)
# No RNA-seq evidence was supplied.

THREADS="${THREADS:-48}"

PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
DATA_DIR="${DATA_DIR:-${PROJECT_DIR}/data}"
PROTEIN_DIR="${PROTEIN_DIR:-${PROJECT_DIR}/reference}"
OUT_DIR="${OUT_DIR:-${PROJECT_DIR}/results/braker}"

GENOME="${GENOME:-${DATA_DIR}/MazayanCamel.fasta.masked}"
PROTEINS="${PROTEINS:-${PROTEIN_DIR}/vertebrata_proteins.faa}"

BRAKER_EXE="${BRAKER_EXE:-braker.pl}"
SPECIES_MODEL="${SPECIES_MODEL:-camelus_dromedarius_mezayen}"

mkdir -p "${OUT_DIR}"

"${BRAKER_EXE}" \
    --genome="${GENOME}" \
    --prot_seq="${PROTEINS}" \
    --threads="${THREADS}" \
    --gff3 \
    --workingdir="${OUT_DIR}" \
    --species="${SPECIES_MODEL}"

echo "BRAKER completed."
echo "Working directory: ${OUT_DIR}"
