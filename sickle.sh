#SBATCH -D /group/jrigrp2/Velasco/Almond_BGI/
#SBATCH -o /home/dmvelasc/Projects/Almond_BGI/slurm-log/sickle-stdout-%A_%a.txt
#SBATCH -e /home/dmvelasc/Projects/Almond_BGI/slurm-log/sickle-stderr-%A_%a.txt
#SBATCH -a 1-12
#SBATCH -J sickle
#SBATCH -p serial
#SBATCH -n 1
#SBATCH -c 4
set -e
set -u

# -n is --ntasks
# -c is --cpus-per-task
# -a is like qsub -t
# %A is array job ID
# %a is array job index
# %j is job allocation number

# Declare number variables
x=$SLURM_ARRAY_TASK_ID
i=$x-1

# Declare arrays (change depending on data organization)
declare -a accession=(DPRU0194 DPRU0579 DPRU0582 DPRU1467.9 DPRU1871.1 DPRU2327.16 DPRU2493.7 DPRU2578.2 FPS-Lovell UCD-fenzliana UCD-TNP USDA-arabica)

# Declare directories (also change depending on organization)
dir1="/home/dmvelasc/Software/scythe" # program directory
dir2="/group/jrigrp2/Velasco/Almond_BGI" # sequence directory prefix

## sickle for low quality trimming

module load sickle
sickle pe -f "$dir2"/scythe_"${accession["$i"]}"_1.fq.gz -r "$dir2"/scythe_"${accession["$i"]}"_2.fq.gz -t sanger -o "$dir2"/sickle_"${accession["$i"]}"_1.fq -p "$dir2"/sickle_"${accession["$i"]}"_2.fq -s "$dir2"/sickle_"${accession["$i"]}"_singles.fq

gzip -c "$dir2"/sickle_"${accession["$i"]}"_1.fq > "$dir2"/sickle_"${accession["$i"]}"_1.fq.gz
gzip -c "$dir2"/sickle_"${accession["$i"]}"_2.fq > "$dir2"/sickle_"${accession["$i"]}"_2.fq.gz
gzip -c "$dir2"/sickle_"${accession["$i"]}"_singles.fq > "$dir2"/sickle_"${accession["$i"]}"_singles.fq.gz
rm "$dir2"/sickle_"${accession["$i"]}"_1.fq "$dir2"/sickle_"${accession["$i"]}"_2.fq "$dir2"/sickle_"${accession["$i"]}"_singles.fq
