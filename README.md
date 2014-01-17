### README

This repository contains scripts used for genome analysis of ABC funded almond genome resequencing.

All scripts were run using the UC Davis CAES cluster (except as noted).

Scripts include:
* angsd.sh (not yet created)
* bwa.sh
* fastqc.sh
* merge.sh (not yet implemented)
* phase.sh
* popbam.sh (not yet implemented)
* sam.sh
* samstat.sh
* scythe.sh
* sickle.sh

##### bwa.sh
Arrayed read mapping using BWA-mem for multiple accessions declared in an array.

##### fastqc.sh
Quality control of fastq files using FastQC, a java program that produces zipped html output.

##### merge.sh
For merging BAM files to use with PopBAM.

##### phase.sh
Phasing BAM files with samtools for use in PopBAM.

##### popbam.sh
Getting population genetics data directly from BAM files using PopBAM.

##### sam.sh
Filler script to rename files from stdout to sam due to accidental oversight not directing stdout to file.

##### samstat.sh
Evaluate SAM and or BAM files. In this case original BWA-mem read mapping and samtools phased BAM files,
including chimeric reads. (It can evaluate FASTA and FASTQ, but not if they are gzipped - produces segmentation fault - use FastQC.)

##### scythe.sh
Trim adapter sequence from FASTQ reads. (Need to include lines to gzip output files and remove non-gzipped output.)

##### sickle.sh
Trim low quality bases from adapter-trimmed FASTQ reads, gzip output files, and remove non-gzipped output.
