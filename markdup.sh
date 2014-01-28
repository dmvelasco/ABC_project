#!/bin/bash
#SBATCH -D /home/dmvelasc/Projects/Almond_BGI
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/markdup-stdout-%A-%a.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/markdup-stderr-%A-%a.txt
#SBATCH -J markdup
#SBATCH -p serial
#SBATCH -a 1-12
#SBATCH -n 1
#SBATCH -c 4
set -e
set -u

# %A is array job ID
# %a is array job index
# %j is job allocation number

# Declare number variables
x=$SLURM_ARRAY_TASK_ID
i=$x-1

# Declare arrays (these will need to change depending on sequence data organization)
declare -a accession=(DPRU0194 DPRU0579 DPRU0582 DPRU1467.9 DPRU1871.1 DPRU2327.16 DPRU2493.7 DPRU2578.2 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)

# Declare directories
dir1="/home/dmvelasc/Software/samtools" # SAMtools program directory
dir2="/home/dmvelasc/Projects/Almond_BGI/Analysis/SAM_2014-01-17" # SAM directory prefix

#### SAMTOOLS ####
# convert SAM to BAM
# -b output in BAM format
# -h output with headers
# -u output uncompressed (better for piping)
# -S input is SAM format

# convert SAM to BAM
#"$dir1"/samtools view -bhuS "$dir2"/"${accession["$i"]}".sam -o "$dir2"/"${accession["$i"]}".bam

# sort BAM file
#"$dir1"/samtools sort "$dir2"/"${accession["$i"]}".bam "$dir2"/"${accession["$i"]}".sorted

# convert back to uncompressed BAM
#"$dir1"/samtools view -bhu "$dir2"/"${accession["$i"]}".sorted.bam -o "$dir2"/"${accession["$i"]}".sort.bam


#### PICARDTOOLS ####
module load picardtools
# picard tools 1.100, modified 2013-10-07; current version is 1.106, modified 2014-01-13

java -jar /share/apps/picardtools-1.100/MarkDuplicates.jar INPUT="$dir2"/"${accession["$i"]}".sort.bam OUTPUT="$dir2"/"${accession["$i"]}"_uniquereads.bam METRICS_FILE="$dir2"/MarkDup_metrics_"${accession["$i"]}" REMOVE_DUPLICATES=true ASSUME_SORTED=true
