#!/bin/bash
#SBATCH -D /home/dmvelasc/Projects/Almond_BGI/Analysis
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/phase-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/phase-stderr-%A_%a.txt
#SBATCH -J phase
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

# samtools phasing script

# Declare number variables
x=$SLURM_ARRAY_TASK_ID
i=$x-1

# Declare array
declare -a accession=(DPRU0194 DPRU0579 DPRU1467.9 DPRU2327.16 DPRU2493.7 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)

# Declare directories
dir1="/home/dmvelasc/Software/samtools" # program directory
dir2="/home/dmvelasc/Projects/Almond_BGI/Analysis/2013-10-27_3" # sequence directory prefix

# Begin samtools phase
"$dir1"/samtools phase -b "${accession["$i"]}" "$dir2"/"${accession["$i"]}".sort.bam
