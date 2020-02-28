#!/bin/bash -l
#SBATCH
#SBATCH --job-name=mksess_main
#SBATCH --time=2:0:0
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --mail-type=end

hemi=$1

ml freesurfer
ml matlab
source SetUpFreeSurfer.sh

mkanalysis-sess -a maintask-surface-${hemi}-sm0 \
-surface self ${hemi} \
-fsd bold -fwhm 0 \
-event-related \
-paradigm maintask.para \
-nconditions 4 \
-refeventdur 4 \
-TR 2 \
-nskip 2 \
-polyfit 1 -spmhrf 0 \
-runlistfile maintask.rlf \
-mcextreg -per-session -force

mkcontrast-sess -analysis maintask-surface-${hemi}-sm0 \
-contrast fixation -a 1 -a 2 -a 3 -a 4 -c 0
