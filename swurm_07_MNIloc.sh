subj=$1
hemi=$2
loc=$3

toppath=../unpackdata/${subj}/bold/${loc}-surface-${hemi}-sm5

for path in ${toppath}/*/ ; do
if [[ $path != *"res"* ]]; then
    sbatch run_09_MNIloc.sh ${subj} ${hemi} ${path}
fi
done
