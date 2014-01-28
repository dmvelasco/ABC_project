#!/bin/bash
#SBATCH -D /home/dmvelasc/Projects/Almond_BGI/Analysis/SAM_2014-01-17
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/pileup-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/pileup-stderr-%A_%a.txt
#SBATCH -J pileup
#SBATCH -p serial
#SBATCH -a 1-12
#SBATCH -n 1
#SBATCH -c 6
set -e
set -u


# %A is array job ID
# %a is array job index
# %j is job allocation number

# Declare number variables
x=$SLURM_ARRAY_TASK_ID
i=$x-1

# Declare arrays (change according to data organization)
declare -a accession=(DPRU0194 DPRU0579 DPRU0582 DPRU1467.9 DPRU1871.1 DPRU2327.16 DPRU2493.7 DPRU2578.2 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)

# Declare directories
dir1="/home/dmvelasc/Software/samtools" # SAMtools program directory
dir2="/home/dmvelasc/Data/references/persica-REF" # reference directory
dir3="/home/dmvelasc/Projects/Almond_BGI/Analysis/SAM_2014-01-17" # SAM directory prefix
dir4="/home/dmvelasc/Software/vcftools_0.1.11/bin" # VCFtools program directory
dir5="/home/dmvelasc/Script" # script directory


##### Pileup, call variants, filter variants #####

# pileup of sorted, uncompressed BAM to BCF
"$dir1"/samtools mpileup -DBSRu -f "$dir2"/Prunus_persica_v1.0_chr.fa "$dir3"/"${accession["$i"]}"_uniquereads.bam | "$dir1"/bcftools/bcftools view -Abvcg - > "$dir3"/"${accession["$i"]}".raw.bcf

# BCF filtered to VCF and max depth filtered to 50X, additional filtering in VCFtools step (####changed to 100X 2013-10-27#####)
"$dir1"/bcftools/bcftools view "$dir3"/"${accession["$i"]}".raw.bcf | "$dir1"/bcftools/vcfutils.pl varFilter -D 100 > "$dir3"/"${accession["$i"]}".flt.vcf

#filter VCF (approximate average depth is 30X)
"$dir4"/vcftools --vcf "$dir3"/"${accession["$i"]}".flt.vcf --remove-indels --minQ 20 --min-meanDP 10  --max-meanDP 100 --thin 11 --recode --filtered-sites --out "$dir3"/"${accession["$i"]}".final
