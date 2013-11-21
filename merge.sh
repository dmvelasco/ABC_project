#!/bin/bash
#SBATCH -D /home/dmvelasc/Projects/Almond_BGI/Analysis
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/merge-stdout-%j.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/merge-stderr-%j.txt
#SBATCH -J merge
#SBATCH -p serial
##SBATCH -a 1-9
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

# samtools merge script

# Declare array
declare -a accession=(DPRU0194 DPRU0579 DPRU1467.9 DPRU2327.16 DPRU2493.7 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)

# Declare directories
dir1="/home/dmvelasc/Software/samtools" # program directory
dir2="/home/dmvelasc/Projects/Almond_BGI/Analysis" # sequence directory prefix

# Begin samtools merge
# "$dir1"/samtools merge -nur peach.bam "$dir2"/"${accession[5]}".0.bam "$dir2"/"${accession[5]}".1.bam "$dir2"/"${accession[4]}".0.bam "$dir2"/"${accession[4]}".1.bam

# Convert to SAM to check header
"$dir1"/samtools view -h -o peach.sam "$dir2"/peach.bam
