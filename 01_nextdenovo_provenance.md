# Initial PacBio Assembly with NextDenovo

## Evidence status

The complete historical NextDenovo `run.cfg`, exact software version, and
exact launch command were not independently recovered.

This document therefore reports only parameters and inputs directly recovered
from retained workflow records. Unverified settings are intentionally omitted.

## Recovered historical input

The initial de novo assembly used the PacBio CLR dataset represented by:

    pacbio_1.fastq

The retained `input.fofn` pointed to this dataset only.

No retained assembly-workflow evidence was recovered assigning `pacbio_2`
to the initial NextDenovo assembly.

## Recovered NextDenovo parameters

    read_type = clr
    input_fofn = ./input.fofn
    genome_size = 3g
    read_cutoff = 1k
    pa_correction = 5

These are recovered historical parameters, not a reconstruction of the
complete original configuration.

## Verified PacBio input accounting

Raw `pacbio_1`:

    Reads: 22,414,076
    Bases: 226,459,268,481 bp
    Mean read length: 10,103.4 bp
    Read N50: 13,390 bp

Applying the recovered 1-kb read-length cutoff:

    Reads retained: 21,751,541
    Bases retained: 226,119,206,574 bp
    Reads retained: 97.044%
    Bases retained: 99.850%
    Mean retained read length: 10,395.5 bp
    Read N50: 13,411 bp

Using the recovered `genome_size = 3g` planning parameter, the retained
PacBio input corresponds to approximately 75.37-fold theoretical coverage.

## Reviewer-audit reproduction command

The following command was used during manuscript revision to reproduce the
1-kb read-length threshold statistics. It is a reviewer-audit command and
should not be interpreted as the original NextDenovo launch command.

    seqkit seq -m 1000 pacbio_1.fastq.gz | seqkit stats -a -T

## Historical limitations

The following were not independently recovered and are therefore not reported
as historical facts:

- complete `run.cfg`
- exact NextDenovo software version
- exact NextDenovo launch command
- unrecovered scheduler or parallelization settings
- additional configuration parameters not listed above
- a separate historical read-trimming workflow

The absence of a retained separate trimming log should not be interpreted as
proof that no historical preprocessing occurred.
