subj=$1

topdir=$SUBJECTS_DIR/${subj}/

freeview -v \
${topdir}/mri/T1.mgz \
${topdir}/mri/wm.mgz \
${topdir}/mri/brainmask.mgz \
${topdir}/mri/aseg.mgz:colormap=lut:opacity=0.2 \
-f ${topdir}/surf/lh.white:edgecolor=blue \
${topdir}/surf/lh.pial:edgecolor=red \
${topdir}/surf/rh.white:edgecolor=blue \
${topdir}/surf/rh.pial:edgecolor=red
