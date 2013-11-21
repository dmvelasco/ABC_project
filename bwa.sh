#!/bin/bash
#SBATCH -D /home/dmvelasc/Data/Velasco_BGI
#SBATCH -o /home/dmvelasc/Data/Velasco_BGI/slurm-log/map-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Data/Velasco_BGI/slurm-log/map-stderr-%A_%a.txt
#SBATCH -J map
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

# bwa script code

# Declare number variables
x=$SLURM_ARRAY_TASK_ID
i=$x-1

# Declare arrays (these will need to change depending on sequence data organization)
declare -a accession=(DPRU0194 DPRU0579 DPRU1467.9 DPRU2327.16 DPRU2493.7 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)
declare -a id=(FCD2GPRACXX-SZAIPI032084-64 FCC2GP0ACXX-SZAIPI032110-94_L8 FCD2GPRACXX-SZAIPI032087-79 FCD2GPRACXX-SZAIPI032085-66 FCD2GPRACXX-SZAIPI032086-74 FCD2GPRACXX-SZAIPI032088-80 FCD2GPRACXX-SZAIPI032089-81 FCC2GP0ACXX-SZAIPI032108-96 FCC2GP0ACXX-SZAIPI032109-95)

# Declare directories
dir1="/home/dmvelasc/Software/bwa" # program directory
dir2="/home/dmvelasc/Data/references/bwa-peach" # reference directory
dir3="/home/dmvelasc/Data/Velasco_BGI" # sequence directory prefix

# Begin BWA script
"$dir1"/bwa mem -t 4 "$dir2"/peach "$dir3"/"${accession["$i"]}"/"${id["$i"]}"_1.fq.gz "$dir3"/"${accession["$i"]}"/"${id["$i"]}"_2.fq.gz > "$dir3"/"${accession["$i"]}".sam

