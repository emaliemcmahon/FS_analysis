sid=$1
anat=$2

cd  /Users/emcmaho7/Desktop/mri_data/studies/cont_actions/rawdata/${sid}

dcm2niix *mprage*.par
mkdir -p ../../unpackdata/${sid}/3danat/00${anat}
mv *.nii ../../unpackdata/${sid}/3danat/00${anat}/T1.nii
mv *.json ../../unpackdata/${sid}/3danat/00${anat}/T1.json

for irun in {4..20};
do
dcm2niix *_${irun}_1.par

irun=$(printf "%03d" $irun)
mkdir -p ../../unpackdata/${sid}/bold/${irun}
mv *.nii ../../unpackdata/${sid}/bold/${irun}/f.nii
mv *.json ../../unpackdata/${sid}/bold/${irun}/f.json
done

cd ../../FS_analysis/
