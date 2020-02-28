#!/bin/bash -l

#SBATCH
#SBATCH --job-name=reconall_adapt_pilot
#SBATCH --time=30:0:0
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=emcmaho7@jhu.edu

subj=$1
anat_run=$2

top_dir=/scratch/groups/lisik3/mcmahoneg/mri_data_anlys
subj_dir=${top_dir}/subjects
study_dir=${top_dir}/studies/cont_actions
script_dir=${study_dir}/analysis
anat_path=${study_dir}/unpackdata/${subj}/3danat/${anat_run}

cd $script_dir
module load freesurfer
#FREESURFER_HOME="/software/apps/freesurfer/6.0.0/"
source SetUpFreeSurfer.sh

cd $subj_dir
recon-all -s ${subj} -i ${anat_path}/T1_defaced.nii -all -qcache
	
cd $script_dir
mv slurm-* slurm_out/
