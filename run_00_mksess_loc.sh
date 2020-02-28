#!/bin/bash -l
#SBATCH
#SBATCH --job-name=mksess_main
#SBATCH --time=2:0:0
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --mail-type=end

hemi=$1
loc=$2
nconds=$4
dur=$3

ml freesurfer
ml matlab
source SetUpFreeSurfer.sh

mkanalysis-sess -a ${loc}-surface-${hemi}-sm5 \
-surface self ${hemi} \
-fsd bold -fwhm 5 \
-event-related \
-paradigm ${loc}.para \
-nconditions ${nconds} \
-refeventdur ${dur} \
-TR 2 \
-nskip 2 \
-polyfit 1 -spmhrf 0 \
-runlistfile ${loc}.rlf \
-mcextreg -per-run -force

if [ ${loc} == FBO ]
then

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast face_object -a 1 -c 3 

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast object_face -a 3 -c 1 

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast body_object -a 2 -c 3 

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast fixation -a 1 -a 2 -a 3

fi 

if [ ${loc} == biomotion ]
then

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast bio_scrambled -a 1 -c 3

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast bio_translation -a 1 -c 4

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast motion_static -a 1 -a 3 -a 4 -c 2 

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast fixation -a 1 -a 2 -a 3 -a 4 

fi

if [ ${loc} == psts ]
then

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast interaction -a 1 -c 2 

mkcontrast-sess -analysis ${loc}-surface-${hemi}-sm5 \
-contrast fixation -a 1 -a 2

fi
