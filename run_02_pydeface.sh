#NOT EXECUTABLE
#Example of how to use pydeface as an alternative.

cd ${path}
python
import pydeface.utils as pdu
pdu.deface_image('./T1.nii',forcecleanup=True,force=True)
