#!/usr/bin/env bash
set -euo pipefail

# EvidenceModeler consensus annotation
#
# EvidenceModeler version used in the retained environment: 2.1.0
#
# Selected evidence weighting:
# Liftoff:AUGUSTUS:GeneMark.hmm3 = 5:2:2

PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
DATA_DIR="${DATA_DIR:-${PROJECT_DIR}/data}"
RESULTS_DIR="${RESULTS_DIR:-${PROJECT_DIR}/results}"
CONFIG_DIR="${CONFIG_DIR:-${PROJECT_DIR}/configs}"
OUT_DIR="${OUT_DIR:-${RESULTS_DIR}/evm_5_2_2}"

GENOME="${GENOME:-${DATA_DIR}/MazayanCamel.fasta.masked}"
GENE_PREDICTIONS="${GENE_PREDICTIONS:-${RESULTS_DIR}/annotation/combined_predictions.corrected.gff3}"
WEIGHTS="${WEIGHTS:-${CONFIG_DIR}/EVM_weights_5_2_2.txt}"

SEGMENT_SIZE="${SEGMENT_SIZE:-5000000}"
OVERLAP_SIZE="${OVERLAP_SIZE:-500000}"
MIN_INTRON_LENGTH="${MIN_INTRON_LENGTH:-20}"
TERMINAL_INTERGENIC_SEARCH="${TERMINAL_INTERGENIC_SEARCH:-10000}"
EVM_CPUS="${EVM_CPUS:-180}"

PARTITION_EVM="${PARTITION_EVM:-partition_EVM_inputs.pl}"
WRITE_EVM="${WRITE_EVM:-write_EVM_commands.pl}"
PARAFLY="${PARAFLY:-ParaFly}"
RECOMBINE_EVM="${RECOMBINE_EVM:-recombine_EVM_partial_outputs.pl}"
CONVERT_EVM="${CONVERT_EVM:-convert_EVM_outputs_to_GFF3.pl}"
GFF3_TO_PROTEINS="${GFF3_TO_PROTEINS:-gff3_file_to_proteins.pl}"

mkdir -p "${OUT_DIR}"
cd "${OUT_DIR}"

PARTITIONS="camel_corrected_5_2_2.partitions"
LISTING="camel_corrected_5_2_2.partitions.listing"
COMMANDS="camel_corrected_5_2_2.partitions.evm_cmds"
FAILED="camel_corrected_5_2_2.failed_cmds"
FINAL_GFF="camel_corrected_5_2_2.EVM.gff3"
FINAL_PEP="camel_corrected_5_2_2.EVM.pep"
FINAL_CDS="camel_corrected_5_2_2.EVM.cds"

echo "Step 1: Partitioning EVM inputs"

"${PARTITION_EVM}" \
    --partition_dir "${PARTITIONS}" \
    --genome "${GENOME}" \
    --gene_predictions "${GENE_PREDICTIONS}" \
    --segmentSize "${SEGMENT_SIZE}" \
    --overlapSize "${OVERLAP_SIZE}" \
    --partition_listing "${LISTING}"

echo "Step 2: Writing EVM commands"

"${WRITE_EVM}" \
    --genome "${GENOME}" \
    --weights "${WEIGHTS}" \
    --gene_predictions "${GENE_PREDICTIONS}" \
    --min_intron_length "${MIN_INTRON_LENGTH}" \
    --terminal_intergenic_re_search "${TERMINAL_INTERGENIC_SEARCH}" \
    --output_file_name evm.out \
    --partitions "${LISTING}" \
    > "${COMMANDS}"

echo "Step 3: Running EVM partitions"

"${PARAFLY}" \
    -c "${COMMANDS}" \
    -CPU "${EVM_CPUS}" \
    -vv \
    -max_retry 1 \
    -failed_cmds "${FAILED}" \
    -shuffle

echo "Step 4: Recombining EVM outputs"

"${RECOMBINE_EVM}" \
    --partitions "${LISTING}" \
    --output_file_name evm.out

echo "Step 5: Converting EVM output to GFF3"

"${CONVERT_EVM}" \
    --partitions "${LISTING}" \
    --output evm.out \
    --genome "${GENOME}"

echo "Step 6: Concatenating partition GFF3 files"

find "./${PARTITIONS}" \
    -regex ".*evm.out.gff3" \
    -exec cat {} \; \
    > "${FINAL_GFF}"

echo "Step 7: Generating protein FASTA"

"${GFF3_TO_PROTEINS}" \
    "${FINAL_GFF}" \
    "${GENOME}" \
    prot \
    > "${FINAL_PEP}"

echo "Step 8: Generating CDS FASTA"

"${GFF3_TO_PROTEINS}" \
    "${FINAL_GFF}" \
    "${GENOME}" \
    CDS \
    > "${FINAL_CDS}"

echo "EVM 5:2:2 workflow completed."
echo "GFF3: ${OUT_DIR}/${FINAL_GFF}"
echo "Proteins: ${OUT_DIR}/${FINAL_PEP}"
echo "CDS: ${OUT_DIR}/${FINAL_CDS}"
