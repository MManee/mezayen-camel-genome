# Initial PacBio Assembly with NextDenovo

## Evidence status

The complete historical NextDenovo `run.cfg` and exact launch command were
not independently recovered.

This document therefore reports only parameters and input information that
were recovered from retained workflow records. Unverified settings are not
reconstructed.

## Recovered historical input

The initial de novo assembly used the PacBio CLR dataset:

    pacbio_1.fastq

The retained historical `input.fofn` pointed to this dataset only.

No retained assembly-workflow evidence was found assigning `pacbio_2` to
the initial NextDenovo assembly.

## Recovered NextDenovo parameters

    read_type = clr
    input_fofn = ./input.fofn
    genome_size = 3g
    read_cutoff = 1k
    pa_correction = 5

A machine-readable copy of these recovered parameters is provided in:

    configs/nextdenovo_recovered_parameters.txt

## PacBio input accounting

The retained `pacbio_1` dataset contained:

- 22,414,076 reads
- 226,459,268,481 bp
- mean read length: approximately 10.10 kb
- read N50: 13,390 bp

Applying the recovered 1-kb NextDenovo read-length threshold retained:

- 21,751,541 reads
- 226,119,206,574 bp
- 97.04% of reads
- 99.85% of bases
- mean retained read length: approximately 10.40 kb
- retained read N50: 13,411 bp

Relative to the recovered 3-Gb NextDenovo genome-size parameter, the
retained input corresponds to approximately 75.37x theoretical coverage.

## Important limitations

The following historical settings were not independently recovered and are
therefore intentionally not supplied as factual run parameters:

- job_type
- task
- parallel_jobs
- rewrite
- deltmp
- complete scheduler configuration
- exact historical NextDenovo launch command
- exact historical NextDenovo software version

No separate PacBio trimming or quality-filtering workflow was recovered.
The only explicit read-length filtering setting recovered for the initial
assembly was:

    read_cutoff = 1k

Absence of a retained preprocessing log should not be interpreted as proof
that no other historical preprocessing occurred.

## Reproducibility note

This file documents recoverable historical provenance rather than presenting
a reconstructed full NextDenovo configuration. Parameters not supported by
retained evidence have intentionally been omitted.
