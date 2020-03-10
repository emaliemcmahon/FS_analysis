subj=$1

allLocs=(biomotion psts)
#(FBO biomotion amodal psts)
allHemis=(lh rh)

for hemi in ${allHemis[@]}; do
for loc in ${allLocs[@]}; do

toppath=../unpackdata/${subj}/bold/${loc}-surface-${hemi}-sm5

for path in ${toppath}/*/ ; do
if [[ $path != *"res"* ]]; then
    sbatch run_07_MNIloc.sh ${subj} ${hemi} ${path}
fi
done
done
done
