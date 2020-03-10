subj=$1

allHemis=(lh rh)

for hemi in ${allHemis[@]}; do

toppath=../unpackdata/${subj}/bold/maintask-surface-${hemi}-sm0

for path in ${toppath}/*/ ; do
    sbatch run_06_MNImain.sh ${subj} ${hemi} ${path}
done
done
