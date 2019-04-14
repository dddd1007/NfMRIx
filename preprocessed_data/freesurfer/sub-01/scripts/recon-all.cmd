

#---------------------------------
# New invocation of recon-all Sun Apr 14 06:07:59 UTC 2019 

 mri_convert /base/sub-01/anat/sub-01_T1w.nii.gz /out/freesurfer/sub-01/mri/orig/001.mgz 

#--------------------------------------------
#@# MotionCor Sun Apr 14 06:08:08 UTC 2019

 cp /out/freesurfer/sub-01/mri/orig/001.mgz /out/freesurfer/sub-01/mri/rawavg.mgz 


 mri_convert /out/freesurfer/sub-01/mri/rawavg.mgz /out/freesurfer/sub-01/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /out/freesurfer/sub-01/mri/transforms/talairach.xfm /out/freesurfer/sub-01/mri/orig.mgz /out/freesurfer/sub-01/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Sun Apr 14 06:08:18 UTC 2019

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 

#--------------------------------------------
#@# Talairach Failure Detection Sun Apr 14 06:10:05 UTC 2019

 talairach_afd -T 0.005 -xfm transforms/talairach.xfm 


 awk -f /opt/freesurfer/bin/extract_talairach_avi_QA.awk /out/freesurfer/sub-01/mri/transforms/talairach_avi.log 


 tal_QC_AZS /out/freesurfer/sub-01/mri/transforms/talairach_avi.log 

#--------------------------------------------
#@# Nu Intensity Correction Sun Apr 14 06:10:05 UTC 2019

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 

