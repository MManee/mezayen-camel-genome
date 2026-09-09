# Illumina-Based Consensus Polishing

## Evidence status

The historical Illumina alignment step is recoverable from the retained BAM
header.

The exact historical Pilon command line, run-specific Pilon options, and
number of polishing rounds were not independently recovered.

One retained Pilon output and its associated change log were identified.

## Pre-polishing assembly

Retained pre-Pilon assembly:

    c1.fa

Verified statistics:

    Sequences: 323
    Assembly length: 2,007,914,020 bp
    N50: 40,039,755 bp
    GC: 41.45%

## Historical Illumina alignment

The retained polishing BAM records HISAT2 v2.2.1.

The historical BAM header records the following alignment parameters:

    hisat2-align-s --wrapper basic-0 \
        -x ./Ref/index \
        --no-discordant \
        --no-mixed \
        --sensitive \
        -p 64 \
        --mm \
        --passthrough \
        -1 ../../Illumina/S1_R1.fastq \
        -2 ../../Illumina/S1_R2.fastq

The relative input paths above are preserved from the BAM-header command.
They do not refer to the public repository layout.

## Retained polishing-read evidence

The retained polishing BAM contains lane-1 Illumina read identifiers.

Corresponding retained lane-1 raw data:

    Raw reads: 253,656,416
    Raw bases: 38,302,118,816 bp
    Read length: 151 bp

Retained BAM statistics:

    Primary mapped reads: 222,024,848
    CIGAR-mapped bases: 33,119,678,304 bp

The retained BAM represents mapped reads and should not be used to claim
a 100% raw-read mapping rate.

Effective mapped polishing depth was calculated as:

    33,119,678,304 / 2,007,914,020 = 16.49x

This value represents effective CIGAR-mapped depth against the pre-Pilon
assembly and is distinct from total Illumina raw coverage.

## Post-polishing assembly

Retained post-Pilon assembly:

    GoldenBoy.fasta

Verified statistics:

    Sequences: 323
    Assembly length: 2,007,639,609 bp
    N50: 40,037,053 bp
    GC: 41.45%

Observed pre/post length difference:

    -274,411 bp

## Retained Pilon change log

The retained file:

    GoldenBoy.changes

contains:

    Total change records: 247,311
    Insertions: 40,985
    Deletions: 96,499
    Substitutions/replacements: 109,827

The net sequence-length change derived from the retained change records is
-274,411 bp, exactly matching the difference between the retained pre- and
post-Pilon FASTA lengths.

This supports assignment of the retained change log to this polishing
transition.

## Historical Pilon version and command limitations

A currently retained Pilon installation reports version 1.24-3 and predates
the retained GoldenBoy output.

However, this does not independently establish the exact Pilon version used
for the historical run.

Therefore, the following are intentionally not reported as verified facts:

- exact historical Pilon executable version
- exact Pilon command line
- run-specific Pilon options
- exact number of Pilon iterations

One retained Pilon output was identified, and no retained evidence of
additional polishing rounds was recovered.
