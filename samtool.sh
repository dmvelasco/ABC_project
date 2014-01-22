#!/bin/bash
#SBATCH -D /home/dmvelasc/Data/Velasco_BGI
#SBATCH -o /home/dmvelasc/Data/Velasco_BGI/slurm-log/sam-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Data/Velasco_BGI/slurm-log/sam-stderr-%A_%a.txt
#SBATCH -J sam
#SBATCH -p serial
#SBATCH -a 1-9
#SBATCH -n 4
#SBATCH -c 4
set -e
set -u


# -D is like qsub -cwd
# -o is like qsub -o
# -e is like qsub -e
# -J is like qsub -j
# %A is array job ID
# %a is array job index
# %j is job allocation number

# convert SAM to BAM and sort

# Declare directories
dir1="/home/dmvelasc/Software/samtools" # SAMtools program directory
dir2="/home/dmvelasc/Data/references" # reference directory
dir3="/home/dmvelasc/Data/Velasco_BGI" # sequence directory prefix
dir4="/home/dmvelasc/Software/vcftools_0.1.11/bin" # VCFtools program directory
dir5="/home/dmvelasc/Script"

# Declare arrays (these will need to change depending on sequence data organization)
declare -a accession=(DPRU0194 DPRU0579 DPRU1467.9 DPRU2327.16 DPRU2493.7 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)

# Declare number variables
x=$SLURM_ARRAY_TASK_ID
i=$(( x-1 ))

# convert SAM to BAM
# -b output in BAM format
# -h output with headers
# -u output uncompressed (better for piping)
# -S input is SAM format

# filter SAM and convert to BAM (changed to below for 2013-10-27 9:10)
#"$dir1"/samtools view -Sh -F 4 -q 10 "$dir3"/"${accession["$i"]}".sam | "$dir5"/filter.py | "$dir1"/samtools view -bhuS - > "$dir3"/"${accession["$i"]}".bam

# filter SAM and convert to BAM
"$dir1"/samtools view -Sh -F 4 -q 10 "$dir3"/"${accession["$i"]}".sam | "$dir1"/samtools view -bhuS - > "$dir3"/"${accession["$i"]}".bam

# "$dir1"/samtools view -bhuS "$dir3"/"${accession["$i"]}".sam -o "$dir3"/"${accession["$i"]}".bam

# sort BAM file
"$dir1"/samtools sort "$dir3"/"${accession["$i"]}".bam "$dir3"/"${accession["$i"]}".sorted

# convert back to uncompressed BAM
"$dir1"/samtools view -bhu "$dir3"/"${accession["$i"]}".sorted.bam -o "$dir3"/"${accession["$i"]}".sort.bam

# Pileup, call variants, filter variants

# pileup of sorted, uncompressed BAM to BCF
"$dir1"/samtools mpileup -DBSRu -f "$dir2"/Prunus_persica_v1.0_chr.fa "$dir3"/"${accession["$i"]}".sort.bam | "$dir1"/bcftools/bcftools view -Abvcg - > "$dir3"/"${accession["$i"]}".raw.bcf

# BCF filtered to VCF and max depth filtered to 50X, additional filtering in VCFtools step (####changed to 100X 2013-10-27#####)
"$dir1"/bcftools/bcftools view "$dir3"/"${accession["$i"]}".raw.bcf | "$dir1"/bcftools/vcfutils.pl varFilter -D 100 > "$dir3"/"${accession["$i"]}".flt.vcf

#filter VCF (approximate average depth is 35X)
"$dir4"/vcftools --vcf "$dir3"/"${accession["$i"]}".flt.vcf --remove-indels --minQ 20 --min-meanDP 10  --max-meanDP 100 --thin 11 --recode --filtered-sites --out "$dir3"/"${accession["$i"]}".final
