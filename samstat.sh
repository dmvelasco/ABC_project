#!/bin/bash
#SBATCH -D /home/dmvelasc/Projects/Almond_BGI/Analysis/Stat
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/samstat-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/samstat-stderr-%A_%a.txt
#SBATCH -a 1-12
#SBATCH -J samstat
#SBATCH -p serial
#SBATCH -n 1
#SBATCH -c 1
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

# Declare directories (also depends on organization)
dir1="/home/dmvelasc/Software/samstat/src" # program directory
dir2="/home/dmvelasc/Projects/Almond_BGI/Analysis" # BAM directory

# Begin samstat script
"$dir1"/samstat "$dir2"/SAM_2014-01-09/"${accession["$i"]}".sam
