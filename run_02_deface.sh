subj=$1
anat_run=$2

anat_path=../unpackdata/${subj}/3danat/${anat_run}
fs_path=${FREESURFER_HOME}/subjects/fsaverage/mri

cd $anat_path
mri_deface T1.nii ${fs_path}/talairach_mixed_with_skull.gca ${fs_path}/face.gca T1_defaced.nii
