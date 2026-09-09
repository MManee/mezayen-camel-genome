# Mezayen Dromedary Camel Genome Assembly and Annotation Workflow

This repository contains the computational workflow, command-line parameters,
configuration files, software-version information, and reproducibility
documentation associated with the genome assembly and revised protein-coding
annotation of a male Mezayen dromedary camel (*Camelus dromedarius*) of the
Majaheem type.

## Associated genome resource

NCBI Assembly accession:

    GCA_037784275.1

Associated Figshare dataset:

    https://doi.org/10.6084/m9.figshare.33193326

## Scope of this repository

The repository documents the principal computational steps used for:

1. Long-read processing and genome assembly
2. Illumina-based consensus polishing
3. 10x Genomics scaffolding
4. Assembly quality assessment
5. Read-mapping and coverage assessment
6. K-mer-based quality evaluation
7. Haplotypic duplication assessment
8. Contamination screening
9. Comparative and synteny analyses
10. Protein-coding gene annotation
11. Functional annotation
12. Annotation quality assessment

## Repository structure

    assembly/
        Genome assembly, polishing, and scaffolding commands

    quality_control/
        Assembly QC, read mapping, k-mer analysis, contamination screening,
        and redundancy assessment

    annotation/
        Liftoff, BRAKER, EvidenceModeler, and functional-annotation workflows

    configs/
        Configuration files, evidence weights, and software-version information

    docs/
        Data-access information, workflow overview, and reproducibility notes

    reviewer_revision/
        Additional analyses and documentation generated during manuscript revision

## Data availability

Large sequencing datasets and genome sequence files are not duplicated in
this repository.

Publicly deposited genomic resources and associated annotation files should
be obtained from the corresponding NCBI and Figshare records.

## Reproducibility conventions

Commands in this repository use portable variables such as:

    PROJECT_DIR="/path/to/project"
    DATA_DIR="${PROJECT_DIR}/data"
    RESULTS_DIR="${PROJECT_DIR}/results"
    THREADS=32

Local server names, user-specific home directories, and institution-internal
filesystem paths have been removed from the public workflow.

Software versions and historically recorded command-line parameters are
documented wherever available.

## Annotation note

The revised protein-coding annotation integrates:

- Liftoff homology-transfer predictions
- AUGUSTUS predictions
- GeneMark.hmm3 predictions

using EvidenceModeler with the selected evidence-weighting scheme:

    Liftoff:AUGUSTUS:GeneMark.hmm3 = 5:2:2

No RNA-seq evidence from the sequenced individual was supplied to BRAKER.

## Citation

Please cite the associated manuscript and deposited genome resources when
using this workflow.

## Contact

Questions regarding the workflow should be directed to the corresponding
authors of the associated manuscript.
