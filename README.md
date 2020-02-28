# Notes on analyzing the fMRI data

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
