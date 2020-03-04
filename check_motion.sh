sid=$1

ml freesurfer
ml matlab
ml gnuplot
source SetUpFreesurfer.sh

plot-twf-sess -s ${sid} -df sessdir -fsd bold -mc
