#!/bin/bash
#SBATCH -D /home/dmvelasc/Projects/Almond_BGI
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/map-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/map-stderr-%A_%a.txt
#SBATCH -J map
#SBATCH -p serial
#SBATCH -a 1-12
#SBATCH -n 4
#SBATCH -c 4
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
declare -a id=(FCD2GPRACXX-SZAIPI032084-64 FCC2GP0ACXX-SZAIPI032110-94_L8 FCD2H8PACXX-SZAIPI034950-14 FCD2GPRACXX-SZAIPI032087-79 FCD2H8PACXX-SZAIPI034951-15 FCD2GPRACXX-SZAIPI032085-66 FCD2GPRACXX-SZAIPI032086-74 FCD2H8PACXX-SZAIPI034949-13 FCD2GPRACXX-SZAIPI032088-80 FCD2GPRACXX-SZAIPI032089-81 FCC2GP0ACXX-SZAIPI032108-96 FCC2GP0ACXX-SZAIPI032109-95)

# Declare directories
dir1="/home/dmvelasc/Software/bwa" # program directory
dir2="/home/dmvelasc/Data/references/bwa-peach" # reference directory
dir3="/group/jrigrp2/Velasco/Almond_BGI" # sequence directory prefix
dir4="/home/dmvelasc/Projects/Almond_BGI/Analysis/SAM_2014-01-09" #output directory

# Begin BWA script
"$dir1"/bwa mem -t 4 -k 10 -r 2.85 "$dir2"/peach "$dir3"/"${accession["$i"]}"/"${id["$i"]}"_1.fq.gz "$dir3"/"${accession["$i"]}"/"${id["$i"]}"_2.fq.gz > "$dir4"/"${accession["$i"]}".sam

# other possible options to use
# declare -a type=(ALM PLM ALM ALM ALM ALM PCH ALM PCH ALM ALM ALM)
# -P PE mode use Smith-Waterman to rescue hits
# -R read group header line '@RG\tID:\tSM:\tPO:"${type["$i"]}"'
