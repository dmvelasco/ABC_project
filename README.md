### README

This repository is primarily scripts used for genome analysis of ABC funded almond genome resequencing.

All scripts were run (except as noted) using the UC Davis CAES cluster. 

Scripts include:
* bwa.sh
* merge.sh (not yet implemented)
* phase.sh
* popbam.sh (not yet implemented)
* sam.sh

##### bwa.sh
Arrayed read mapping using BWA-mem for multiple accessions declared in an array.

##### merge.sh
For merging BAM files to use with PopBAM.

##### phase.sh
Phasing BAM files with samtools for use in PopBAM.

##### popbam.sh
Getting population genetics data directly from BAM files using PopBAM.

##### sam.sh
Filler script to rename files from stdout to sam due to accidental oversight not directing stdout to file.
