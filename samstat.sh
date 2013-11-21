#!/bin/bash
#SBATCH -D /home/dmvelasc/Data/Velasco_BGI/Analysis/Stat
##SBATCH -o /home/dmvelasc/Data/Velasco_BGI/slurm-log/sam-stdout-%A_%a.txt
##SBATCH -e /home/dmvelasc/Data/Velasco_BGI/slurm-log/sam-stderr-%A_%a.txt
#SBATCH -o /home/dmvelasc/Data/Velasco_BGI/slurm-log/sam-stdout-%j.txt
#SBATCH -e /home/dmvelasc/Data/Velasco_BGI/slurm-log/sam-stderr-%j.txt
#SBATCH -J sam
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

# Declare number variables
#x=$SLURM_ARRAY_TASK_ID
#i=$x-1
#j=$x

# Declare arrays (these will need to change depending on sequence data organization)
declare -a accession=(DPRU0194 DPRU0579 DPRU1467.9 DPRU2327.16 DPRU2493.7 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)
declare -a id=(FCD2GPRACXX-SZAIPI032084-64 FCC2GP0ACXX-SZAIPI032110-94_L8 FCD2GPRACXX-SZAIPI032087-79 FCD2GPRACXX-SZAIPI032085-66 FCD2GPRACXX-SZAIPI032086-74 FCD2GPRACXX-SZAIPI032088-80 FCD2GPRACXX-SZAIPI032089-81 FCC2GP0ACXX-SZAIPI032108-96 FCC2GP0ACXX-SZAIPI032109-95)

# Declare arrays (these will need to change depending on sequence data organization)

# Declare directories
dir1="/home/dmvelasc/Software/samstat/src" # program directory
dir2="/home/dmvelasc/Projects/Almond_BGI/Data" # sequence directory prefix
dir3="/home/dmvelasc/Projects/Almond_BGI/Analysis"

# Begin samstat script
"$dir1"/samstat -s DPRU0194 "$dir2"/"${accession[0]}"/"${id[0]}"_1.fq.gz "$dir2"/"${accession[0]}"/"${id[0]}"_2.fq.gz "$dir3"/SAM/"${accession[0]}".sam "$dir3"/Phase/"${accession[0]}".0.bam "$dir3"/Phase/"${accession[0]}".1.bam "$dir3"/Phase/"${accession[0]}".chimera.bam
