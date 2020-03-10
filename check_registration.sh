sid=$1

tkregisterfv --mov $FUNCTIONALS_DIR/${sid}/bold/template.nii.gz --reg $FUNCTIONALS_DIR/${sid}/bold/register.dof6.lta --surf $SUBJECTS_DIR/${sid}/surf/lh.orig --surf $SUBJECTS_DIR/${sid}/surf/rh.orig
