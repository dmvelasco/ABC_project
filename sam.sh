#!/bin/bash
#SBATCH -D /home/dmvelasc/Data/Velasco_BGI
#SBATCH -o /home/dmvelasc/Data/Velasco_BGI/slurm-log/sam-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Data/Velasco_BGI/slurm-log/sam-stderr-%A_%a.txt
#SBATCH -J sam
#SBATCH -p serial
#SBATCH -a 1-6
#SBATCH -n 1
#SBATCH -c 1
set -e
set -u


# -D is like qsub -cwd
# -o is like qsub -o
# -e is like qsub -e
# -J is like qsub -j
# %A is array job ID
# %a is array job index
# %j is job allocation number

# bwa script code

# Declare number variables
x=$SLURM_ARRAY_TASK_ID
i=$(( x + 3 ))

# Declare arrays (these will need to change depending on sequence data organization)

# Declare directories
dir1="/home/dmvelasc/Software/bwa" # program directory
dir2="/home/dmvelasc/Data/references/bwa-peach" # reference directory
dir3="/home/dmvelasc/Data/Velasco_BGI" # sequence directory prefix

# Begin BWA script
cp "$dir3"/slurm-log/map-stdout-8043_"$i".txt aln"$i".sam
