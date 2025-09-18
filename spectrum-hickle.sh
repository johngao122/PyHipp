#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=5	# number of processors per task
#SBATCH -J "spectrum-hickle"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o spectrum-hickle-slurm.%N.%j.out # STDOUT
#SBATCH -e spectrum-hickle-slurm.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE


python -u -c "import PyHipp as pyh; \
pyh.FreqSpectrum(saveLevel=1,redoLevel=1);"

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:253490772629:awsnotify --message "spectrum-hickle done"

