# Directory Structure

There is a strict expected directory structure. It is depicted below. 

`subjects/`:
The folders in `subjects/` are created by  `recon-all`. You should not create them manually, or `recon-all` will give an error that it was previously run. 

`studies/`: 
You create all the folders in `studies/`.

1. There should be one folder for each of your studies (experiments)
2. Within `study_1/`:
- `analysis/` contains all your codes for running the analysis. This repository is my analysis directory. 
- `rawdata/` is a record of the files that come directly from the scanner. 
- The `run_01_unpack.sh` script converts and reorganizes the data from the `rawdata/` folder to `unpackdata/` and into either `3danat/` or `bold/` depending on whether it is EPI or MPRAGE data.

![FS_dir_design](/images/FS_dir_design.jpeg)

# Functions

`run_00_mksess_loc.sh` and `run_00_mksess_main.sh` 
- These call freesurfer functions that define how the analysis will be conducted. They only have to be one one for the entire project. 
- Example call:  `source run_00_mkses_main.sh s001 lh`
- Should be done on MARCC

`run_01_unpackdata.sh`
- Must be preformed locally because the rawdata has face and MARCC is not HIPAA compliant
- The script may need to be modified depending on the run orders

`run_02_deface.sh`
- Removes the face from the MPRAGE
- Inputs are the subject name and folder name of the anatomical run 
- Must be done locally for same reason as above
- FS `mri_deface` has been deprecated, so if there is an error, there is not good support to solve the problem. [pydeface ](https://github.com/poldracklab/pydeface) may be a good alternative although FSL is a dependency.
- Example call: `source run_02_deface.sh s001 002`

`run_03_reconall.sh`
- Performs the cortical reconstruction on the defaced MRPAGE
- Inputs are again the subject name and the folder name of the anatomical run
- Must be done on MARCC
- Takes approximately 16 hours
- Example call: `sbatch run_03_reconall.sh s001 002`

`run_04_preproc.sh`
- Runs the processing for all functional runs
- Input is the subject name
- Performed on MARCC
- Takes about an hour
- Example call: `sbatch run_04_preproc.sh s001`

`run_05_glm.sh`
- Finds the beta values for the specified analysis
- Must be called separately for all analyses (and hemispheres)
- Inputs are the subject name, analysis name, and `-run-wise` or nothing
- `run-wise` is called fro the maintask only
- Done on MARCC
- Takes about 15-30 minutes
- Example call: `sbatch run_05_glm.sh s001 maintask-surface-lh-sm0 -run-wise`
- Example call: `sbatch run_05_glm.sh s001 psts-surface-lh-sm5  `

`run_06_MNImain.sh` and `swurm_06_MNImain.sh`
- Converts the maintask beta values from native space to MNI space
- The swurm scrip submits many batch calls of `run_06_MNImain.sh`
- Inputs are the subject name and the hemisphere
- Must be called for both the left and right hemispheres
- Done on MARCC
- Takes about 1 minute
- Example call: `source swurm_06_MNImain.sh s001 lh`

`run_07_MNIloc.sh` and `swurm_06_MNIloc.sh`
- Same as above but with the localizer name
- Must be done for all localizers and hemispheres
- Done on MARCC
- Takes about 1 minute
- Example call: `source swurm_07_MNIloc.sh s001 lh FBO`

Prior to the next to steps:
`interact -X -t 2:00:00`
`module load matlab`
`matlab` -- A MATLAB GUI will open

`run_08_probROIs.m`
- Defines the ROIs using parcellations
- Input is the subject name
- Call in the MATLAB command line
- Example call: `run_08_probROIs.m('s001')`

`run_09_reorgdata.m`
- Selects the data within each ROI and saves it in a format for further analysis
- Input is the subject name
- Call in the MATLAB command line
- Example call: `run_09_reorgdata.m('s001')`
