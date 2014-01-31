#!/bin/bash
#SBATCH -D /home/dmvelasc/Projects/Almond_BGI
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/map2snp-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/map2snp-stderr-%A_%a.txt
#SBATCH -J map2snp
#SBATCH -p serial
#SBATCH -a 1-12
#SBATCH -n 1
#SBATCH -c 6
set -e
set -u


# %A is array job ID
# %a is array job index
# %j is job allocation number

# bwa script code

# Declare number variables
x=$SLURM_ARRAY_TASK_ID
i=$x-1

# Declare arrays (these will need to change depending on sequence data organization)
declare -a accession=(DPRU0194 DPRU0579 DPRU0582 DPRU1467.9 DPRU1871.1 DPRU2327.16 DPRU2493.7 DPRU2578.2 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)

# Declare directories
dir1="/home/dmvelasc/Software/bwa" # BWA program directory
dir2="/home/dmvelasc/Data/references/bwa-peach-scf" # reference directory
dir3="/group/jrigrp2/Velasco/Almond_BGI" # sequence directory prefix
dir4="/home/dmvelasc/Projects/Almond_BGI/Analysis/SAM_2014-01-17" # output directory
dir5="/home/dmvelasc//Data/references/persica-SCF" # FASTA reference directory
dir6="/home/dmvelasc/Software/samtools" # SAMtools program directory
dir7="/home/dmvelasc/Software/vcftools_0.1.11/bin" # VCFtools program directory

# Begin BWA script
# bwa is a module on FARM, but not using because may be a different version than previously used; would like results to be comparable
"$dir1"/bwa/bwa mem -t 6 -k 10 -r 2.85 "$dir2"/persica_scf "$dir3"/sickle_"${accession["$i"]}"_1.fq.gz "$dir3"/sickle_"${accession["$i"]}"_2.fq.gz > "$dir4"/"${accession["$i"]}"_scf.sam

# -P PE mode use Smith-Waterman to rescue hits
# -R read group header line '@RG\tID:\tSM:\tPO:"${type["$i"]}"'


# filter SAM and convert to BAM
"$dir6"/samtools view -Sh -F 4 -q 10 "$dir4"/"${accession["$i"]}"_scf.sam | "$dir6"/samtools view -bhuS - > "$dir4"/"${accession["$i"]}"_scf.bam
rm "$dir4"/"${accession["$i"]}".sam

# sort BAM file
"$dir6"/samtools sort "$dir4"/"${accession["$i"]}"_scf.bam "$dir4"/"${accession["$i"]}"_scf.sorted
rm "$dir4"/"${accession["$i"]}"_scf.bam

# convert back to uncompressed BAM
"$dir6"/samtools view -bhu "$dir4"/"${accession["$i"]}"_scf.sorted.bam -o "$dir3"/"${accession["$i"]}"_scf.sort.bam
rm "$dir4"/"${accession["$i"]}"_scf.sorted.bam

# Pileup, call variants, filter variants

# pileup of sorted, uncompressed BAM to BCF
"$dir6"/samtools mpileup -DBSRu -f "$dir5"/Prunus_persica_v1.0_scaffolds.fa "$dir4"/"${accession["$i"]}"_scr.sort.bam | "$dir6"/bcftools/bcftools view -Abvcg - > "$dir4"/"${accession["$i"]}".raw.bcf

# BCF filtered to VCF and max depth filtered to 50X, additional filtering in VCFtools step (####changed to 100X 2013-10-27#####)
"$dir6"/bcftools/bcftools view "$dir4"/"${accession["$i"]}".raw.bcf | "$dir6"/bcftools/vcfutils.pl varFilter -D 100 > "$dir4"/"${accession["$i"]}".flt.vcf

#filter VCF (approximate average depth is 30-35X)
"$dir7"/vcftools --vcf "$dir4"/"${accession["$i"]}".flt.vcf --remove-indels --minQ 20 --min-meanDP 10  --max-meanDP 100 --thin 11 --recode --filtered-sites --out "$dir4"/"${accession["$i"]}".final
