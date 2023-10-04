#!/bin/bash
#SBATCH -p cclake-himem
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:10:00
#SBATCH -J matlab-plot_as
#SBATCH -o logs/matlab_plot_as.out
#SBATCH -e logs/matlab_plot_as.err

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
module load matlab

cd "/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts/"
matlab -nodisplay -r "plot_as(); quit"