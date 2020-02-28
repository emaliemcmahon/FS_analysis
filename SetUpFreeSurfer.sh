#!/bin/bash -p

#
# SetUpFreeSurfer.sh
#

# This is a sample SetUpFreeSurfer.csh file. 
# Edit as needed for your specific setup.  
# The defaults should work with most installations.

# Set this to the location of the freesurfer installation.
if [ -z $FREESURFER_HOME ];
then
    export FREESURFER_HOME=/software/apps/freesurfer/6.0.0/;
fi    
 
# Set this to your subjects/ dir, usually freesurfer/subjects/
if [ -z $FUNCTIONALS_DIR ];
then  
	export FUNCTIONALS_DIR=/scratch/groups/lisik3/mcmahoneg/mri_data_anlys/studies
fi

# Set this to your functional sessions dir, usually freesurfer/sessions/

if [ -z $SUBJECTS_DIR ];
then  
	export SUBJECTS_DIR=/scratch/groups/lisik3/mcmahoneg/mri_data_anlys/subjects
fi

# Specify the location of the MINC tools.
# Necessary only if the script $FREESURFER_HOME/FreeSurferEnv.csh
# does not find the tools (and issues warnings pertaining to
# the following two environment variables, which have example
# locations that might need user-specific modification):
#setenv MINC_BIN_DIR /Applications/freesurfer/mni/bin
#setenv MINC_LIB_DIR /Applications/freesurfer/mni/lib
# ... or just disable the MINC toolkit (although some Freesurfer
# utilities will fail!) 
#setenv NO_MINC

# Enable or disable fsfast (enabled by default)
#setenv NO_FSFAST

# Call configuration script:
source $FREESURFER_HOME/FreeSurferEnv.sh
