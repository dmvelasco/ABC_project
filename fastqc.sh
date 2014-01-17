#!/bin/bash
#SBATCH -D /home/dmvelasc/Projects/Almond_BGI/Analysis/QC
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/samstat-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/samstat-stderr-%A_%a.txt
#SBATCH -a 1-3
#SBATCH -J fastqc
#SBATCH -p serial
#SBATCH -n 1
#SBATCH -c 1
set -e
set -u

# -a is like qsub -t
# %A is array job ID
# %a is array job index
# %j is job allocation number

# Declare number variables
x=$SLURM_ARRAY_TASK_ID
i=$x-1

# Declare arrays (these will need to change depending on sequence data organization)
#declare -a accession=(DPRU0194 DPRU0579 DPRU1467.9 DPRU2327.16 DPRU2493.7 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)
#declare -a id=(FCD2GPRACXX-SZAIPI032084-64 FCC2GP0ACXX-SZAIPI032110-94_L8 FCD2GPRACXX-SZAIPI032087-79 FCD2GPRACXX-SZAIPI032085-66 FCD2GPRACXX-SZAIPI032086-74 FCD2GPRACXX-SZAIPI032088-80 FCD2GPRACXX-SZAIPI032089-81 FCC2GP0ACXX-SZAIPI032108-96 FCC2GP0ACXX-SZAIPI032109-95)
declare -a accession=(DPRU0582 DPRU1871.1 DPRU2578.2)
declare -a id=(FCD2H8PACXX-SZAIPI034950-14 FCD2H8PACXX-SZAIPI034951-15 FCD2H8PACXX-SZAIPI034949-13)

# Declare arrays (these will need to change depending on sequence data organization)

# Declare directories (also change depending on organization)
dir1="/home/dmvelasc/Software/FastQC" # program directory
dir2="/group/jrigrp2/Velasco/Almond_BGI" # sequence directory prefix
dir3="/home/dmvelasc/Projects/Almond_BGI/Analysis" # BAM directory

# Begin FastQC script
"$dir1"/fastqc --noextract --outdir="$dir3"/QC "$dir2"/"${accession["$i"]}"/"${id["$i"]}"_1.fq.gz "$dir2"/"${accession["$i"]}"/"${id["$i"]}"_2.fq.gz
