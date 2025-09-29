#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=5	# number of processors per task
#SBATCH -J "cum-waveforms"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o cum-waveforms-slurm.%N.%j.out # STDOUT
#SBATCH -e cum-waveforms-slurm.%N.%j.err # STDERR

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
wfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*', '*mountains*'], objtype=pyh.Waveform); \
wfall.save();"


aws sns publish --topic-arn rn:aws:sns:ap-southeast-1:253490772629:awsnotify --message "generate cumulative-waveforms done"
