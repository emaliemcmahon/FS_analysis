#!/bin/bash -l
#SBATCH
#SBATCH --job-name=convert2mni
#SBATCH --time=4:00:00
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --mail-type=end


ml freesurfer
ml matlab
source SetUpFreeSurfer.sh

subj=$1
hemi=$2
path=$3

mri_surf2surf --srcsubject ${subj} \
            --sval ${path}/sig.nii.gz \
            --trgsubject fsaverage \
            --tval ${path}/sig_mni.nii.gz \
            --hemi ${hemi}
