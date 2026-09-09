# 10x Genomics Scaffolding with Scaff10X

## Evidence status

The retained Scaff10X output preserves run-specific internal scaffolding
parameters and the resulting AGP structure.

The exact historical Scaff10X release could not be independently verified
from the retained software tree and binary provenance.

Therefore, this document reports only run-specific parameters and results
that were directly recovered.

## 10x Genomics input

The retained scaffolding input contained:

    FASTQ files: 32
    Reads: 736,741,550
    Bases: 111,247,974,050 bp
    Mean read length: 151 bp

All 32 retained FASTQ files were listed in the historical Scaff10X
input file.

Raw input coverage corresponds to:

    37.08x relative to the 3-Gb planning genome size
    55.41x relative to the final 2.0076-Gb assembly

These are raw sequence-input coverage values and should not be interpreted
as molecule-aware linked-read coverage.

## Recovered Scaff10X internal parameters

The retained scaffolding log records the following internal `scaff_matrix`
parameters:

    -file 1
    -matrix 2000
    -link 8
    -uplink 50
    -longread 1

The original local executable path has been omitted from this public
repository.

The presence of `-longread 1` is reported as a historical parameter only.
It should not, by itself, be interpreted as independent validation of all
final scaffolding joins.

## Scaffolding contribution

Pre-scaffolding assembly:

    Sequence components: 323
    Assembly length: 2,007,639,609 bp

Post-scaffolding assembly:

    Scaffold objects: 278
    Assembly length: 2,007,644,109 bp

AGP reconstruction shows:

    Sequence components: 323
    Scaffold objects: 278
    Joins introduced: 45
    Gap records: 45
    Total gap bases: 4,500 bp
    Mean gap length: 100 bp
    Minimum gap length: 100 bp
    Maximum gap length: 100 bp

All introduced gaps were 100 bp.

The complete 4,500-bp increase between the pre- and post-scaffolding
assemblies is explained by the 45 introduced 100-bp gaps.

## Contig participation

Of the 323 input contigs:

    248 remained as single-contig scaffolds
    75 participated in multi-contig scaffolds

The 75 joined contigs were incorporated into:

    30 multi-contig scaffolds

Thus:

    75 - 30 = 45 joins

which matches the AGP gap count exactly.

## Independent PacBio join validation

Reviewer-driven long-read validation found:

    Strict continuous-spanning support: 39 / 45 joins (86.67%)
    Additional relaxed crossing support: 1 join
    Total with some continuous crossing evidence: 40 / 45 (88.89%)

Five joins were not independently validated by continuous PacBio crossing
and should not be described as proven correct.

## Historical Scaff10X version limitation

The manuscript previously stated Scaff10X v4.2.

However, the retained software provenance does not independently verify
that exact historical release.

Accordingly:

- Scaff10X v4.2 is not reported here as verified provenance
- the run-specific internal parameters above are treated as the primary
  reproducible evidence
- exact historical release information is intentionally left unresolved
