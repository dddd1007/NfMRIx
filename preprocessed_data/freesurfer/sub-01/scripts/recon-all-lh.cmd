

#---------------------------------
# New invocation of recon-all Tue Apr 30 05:30:54 UTC 2019 
#--------------------------------------------
#@# Tessellate lh Tue Apr 30 05:30:55 UTC 2019

 mri_pretess ../mri/filled.mgz 255 ../mri/norm.mgz ../mri/filled-pretess255.mgz 


 mri_tessellate ../mri/filled-pretess255.mgz 255 ../surf/lh.orig.nofix 


 rm -f ../mri/filled-pretess255.mgz 


 mris_extract_main_component ../surf/lh.orig.nofix ../surf/lh.orig.nofix 

#--------------------------------------------
#@# Smooth1 lh Tue Apr 30 05:30:59 UTC 2019

 mris_smooth -nw -seed 1234 ../surf/lh.orig.nofix ../surf/lh.smoothwm.nofix 

#--------------------------------------------
#@# Inflation1 lh Tue Apr 30 05:31:03 UTC 2019

 mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix 

#--------------------------------------------
#@# QSphere lh Tue Apr 30 05:31:17 UTC 2019

 mris_sphere -q -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix 

#--------------------------------------------
#@# Fix Topology Copy lh Tue Apr 30 05:32:40 UTC 2019

 cp ../surf/lh.orig.nofix ../surf/lh.orig 


 cp ../surf/lh.inflated.nofix ../surf/lh.inflated 

#@# Fix Topology lh Tue Apr 30 05:32:40 UTC 2019

 mris_fix_topology -rusage /out/freesurfer/sub-01/touch/rusage.mris_fix_topology.lh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub-01 lh 


 mris_euler_number ../surf/lh.orig 


 mris_remove_intersection ../surf/lh.orig ../surf/lh.orig 


 rm ../surf/lh.inflated 

#--------------------------------------------
#@# Make White Surf lh Tue Apr 30 05:50:32 UTC 2019

 mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub-01 lh 

#--------------------------------------------
#@# Smooth2 lh Tue Apr 30 05:54:08 UTC 2019

 mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm 

#--------------------------------------------
#@# Inflation2 lh Tue Apr 30 05:54:13 UTC 2019

 mris_inflate -rusage /out/freesurfer/sub-01/touch/rusage.mris_inflate.lh.dat ../surf/lh.smoothwm ../surf/lh.inflated 

#--------------------------------------------
#@# Curv .H and .K lh Tue Apr 30 05:54:26 UTC 2019

 mris_curvature -w lh.white.preaparc 


 mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated 


#-----------------------------------------
#@# Curvature Stats lh Tue Apr 30 05:55:26 UTC 2019

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm sub-01 lh curv sulc 

#--------------------------------------------
#@# Sphere lh Tue Apr 30 05:55:29 UTC 2019

 mris_sphere -rusage /out/freesurfer/sub-01/touch/rusage.mris_sphere.lh.dat -seed 1234 ../surf/lh.inflated ../surf/lh.sphere 

#--------------------------------------------
#@# Surf Reg lh Tue Apr 30 06:06:44 UTC 2019

 mris_register -curv -rusage /out/freesurfer/sub-01/touch/rusage.mris_register.lh.dat ../surf/lh.sphere /opt/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/lh.sphere.reg 

#--------------------------------------------
#@# Jacobian white lh Tue Apr 30 06:30:20 UTC 2019

 mris_jacobian ../surf/lh.white.preaparc ../surf/lh.sphere.reg ../surf/lh.jacobian_white 

#--------------------------------------------
#@# AvgCurv lh Tue Apr 30 06:30:21 UTC 2019

 mrisp_paint -a 5 /opt/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/lh.sphere.reg ../surf/lh.avg_curv 

#-----------------------------------------
#@# Cortical Parc lh Tue Apr 30 06:30:23 UTC 2019

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-01 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.annot 

#--------------------------------------------
#@# Make Pial Surf lh Tue Apr 30 06:30:33 UTC 2019

 mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub-01 lh 

#--------------------------------------------
#@# Surf Volume lh Tue Apr 30 06:41:58 UTC 2019
