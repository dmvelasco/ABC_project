#!/bin/bash
#SBATCH -D /home/dmvelasc/Projects/Almond_BGI/Analysis/Stat
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/samstat-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/samstat-stderr-%A_%a.txt
#SBATCH -a 1-9
#SBATCH -J samstat
#SBATCH -p hi
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
declare -a accession=(DPRU0194 DPRU0579 DPRU1467.9 DPRU2327.16 DPRU2493.7 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)
declare -a id=(FCD2GPRACXX-SZAIPI032084-64 FCC2GP0ACXX-SZAIPI032110-94_L8 FCD2GPRACXX-SZAIPI032087-79 FCD2GPRACXX-SZAIPI032085-66 FCD2GPRACXX-SZAIPI032086-74 FCD2GPRACXX-SZAIPI032088-80 FCD2GPRACXX-SZAIPI032089-81 FCC2GP0ACXX-SZAIPI032108-96 FCC2GP0ACXX-SZAIPI032109-95)

# Declare arrays (these will need to change depending on sequence data organization)

# Declare directories (also change depending on organization)
dir1="/home/dmvelasc/Software/samstat/src" # program directory
dir2="/home/dmvelasc/Projects/Almond_BGI/Data" # sequence directory prefix
dir3="/home/dmvelasc/Projects/Almond_BGI/Analysis" # BAM directory

# Begin samstat script
"$dir1"/samstat "$dir3"/SAM/"${accession["$i"]}".sam
