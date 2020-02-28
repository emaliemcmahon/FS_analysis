subj=$1
hemi=$2

toppath=../unpackdata/${subj}/bold/maintask-surface-${hemi}-sm0

for path in ${toppath}/*/ ; do
    sbatch run_08_MNImain.sh ${subj} ${hemi} ${path}
done
