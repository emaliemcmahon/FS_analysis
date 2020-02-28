cd  /Users/emcmaho7/Desktop/mri_data/studies/cont_actions/rawdata/s001

dcm2niix *mprage*.par
mkdir -p ../../unpackdata/s001/3danat/002
mv *.nii ../../unpackdata/s001/3danat/002/T1.nii
mv *.json ../../unpackdata/s001/3danat/002/T1.json

for irun in {3..20};
do
dcm2niix *_${irun}_1.par

irun=$(printf "%03d" $irun)
mkdir -p ../../unpackdata/s001/bold/${irun}
mv *.nii ../../unpackdata/s001/bold/${irun}/f.nii
mv *.json ../../unpackdata/s001/bold/${irun}/f.json
done

cd ../../analysis/
