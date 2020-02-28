subj=$1
hemi=$2
loc=$3
contrast=$4

funcdir=$FUNCTIONALS_DIR/${subj}/bold


tksurferfv fsaverage ${hemi} inflated \
-overlay ${funcdir}/${loc}-surface-${hemi}-sm5/${contrast}/mask_mni.nii.gz
