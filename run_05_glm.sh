#!/bin/bash -l
#SBATCH
#SBATCH --job-name=glm
#SBATCH --time=2:0:0
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --mail-type=end

sid=$1
a_name=$2
#name set in mkanalysis-sess
wise=$3
#either -run-wise or nothing (default is sess-wise)

ml freesurfer
ml matlab
source SetUpFreeSurfer.sh

selxavg3-sess -s ${sid} -df sessdir \
-analysis ${a_name} \
-svres ${wise}

mv *.out ./slurm_out/
