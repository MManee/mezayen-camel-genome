#!/usr/bin/env bash
set -euo pipefail

# Reviewer-driven haplotypic-duplication screening
#
# Verified software:
# purge_dups v1.2.6
# minimap2 v2.31-r1302
#
# This workflow was used during manuscript revision to screen the final
# assembly for residual haplotypic duplication. Calls were treated as
# screening results and were independently validated before interpretation.
#
# No sequence was automatically removed as part of this analytical stage.

THREADS="${THREADS:-64}"

PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
DATA_DIR="${DATA_DIR:-${PROJECT_DIR}/data}"
OUT_DIR="${OUT_DIR:-${PROJECT_DIR}/results/purge_dups}"

REF="${REF:-${DATA_DIR}/MazayanCamel.fasta}"
PACBIO="${PACBIO:-${DATA_DIR}/pacbio_1.fastq.gz}"

mkdir -p "${OUT_DIR}"
cd "${OUT_DIR}"

# 1. PacBio mapping for depth statistics

minimap2 \
    -x map-pb \
    -I 4G \
    -t "${THREADS}" \
    "${REF}" \
    "${PACBIO}" \
| gzip -1 \
> pacbio_1_vs_MazayanCamel.paf.gz

# 2. Generate base-coverage statistics

pbcstat pacbio_1_vs_MazayanCamel.paf.gz

# 3. Infer empirical coverage cutoffs

calcuts PB.stat \
    > cutoffs \
    2> calcuts.log

# 4. Split the assembly for self-alignment

split_fa "${REF}" \
    > MazayanCamel.split.fa

# 5. Assembly self-alignment

minimap2 \
    -x asm5 \
    -DP \
    -I 4G \
    -t "${THREADS}" \
    MazayanCamel.split.fa \
    MazayanCamel.split.fa \
| gzip -1 \
> MazayanCamel.split.self.paf.gz

# 6. Duplication classification

purge_dups \
    -2 \
    -T cutoffs \
    -c PB.base.cov \
    MazayanCamel.split.self.paf.gz \
    > dups.bed \
    2> purge_dups.log

echo "purge_dups screening completed."
echo "Coverage cutoffs:"
cat cutoffs
