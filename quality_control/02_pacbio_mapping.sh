#!/usr/bin/env bash
set -euo pipefail

# Reviewer-driven PacBio mapping against the final genome assembly.
#
# minimap2 version used: 2.31-r1302
# purge_dups tools were used for coverage-profile summarization.
#
# This analysis was performed during manuscript revision and is not
# presented as the original historical assembly mapping workflow.

PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
DATA_DIR="${DATA_DIR:-${PROJECT_DIR}/data}"
RESULTS_DIR="${RESULTS_DIR:-${PROJECT_DIR}/results}"

REF="${REF:-${DATA_DIR}/MazayanCamel.fasta}"
PACBIO="${PACBIO:-${DATA_DIR}/pacbio_1.fastq.gz}"
OUT="${OUT:-${RESULTS_DIR}/pacbio_mapping}"

THREADS="${THREADS:-64}"

mkdir -p "${OUT}"
cd "${OUT}"

minimap2 \
    -x map-pb \
    -I 4G \
    -t "${THREADS}" \
    "${REF}" \
    "${PACBIO}" \
    2> minimap2_pacbio.log \
| gzip -1 \
> pacbio_1_vs_MazayanCamel.paf.gz

pbcstat pacbio_1_vs_MazayanCamel.paf.gz

calcuts PB.stat \
    > cutoffs \
    2> calcuts.log

if command -v hist_plot.py >/dev/null 2>&1; then
    hist_plot.py \
        -c cutoffs \
        PB.stat \
        PB.coverage.png
else
    echo "NOTE: hist_plot.py not found in PATH; coverage plot was not generated."
fi

echo "PacBio final-assembly mapping QC completed."
