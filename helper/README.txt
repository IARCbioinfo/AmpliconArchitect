
# Amplicon Architect (12/04/2021)

## Get singularity image

```
#original docker image
singularity pull docker://virajbdeshpande/ampliconarchitect
# add make command 
singularity pull docker://adigenova/aarchitect:v1.0
# add make command and AmpliconClassifier code
singularity pull docker://iarcbioinfo/aarchitect:v2.0 
# add the cnvkit plus the CycleViz
singularity pull docker://iarcbioinfo/aarchitect:v3.0 
```

## Run Amplicon architect and Amplicon Classifier on mesomics

Inside the directory meso_data there is a makefile that exec all the comands.

```
make all
```


## Note on the number of seeds

If you generate your own file of CNV calls, please ensure the estimated copy number of these calls is in the last column of the bed file. Secondly, also ensure that the calls you are using are segmented, and not just raw per-bin estimates. This is not a concern for most users, however if you notice there are > 50 CNV seeds going into AA, there may be something wrong.


## Note for samples MESO_007_T and MESO_048_T2

We increase the CNV coverage to select the seeds for MESO_007_T and MESO_048_T2

```
python2 /home/programs/AmpliconArchitect-master/src/amplified_intervals.py --gain 6.0 --cnsize_min 50000 --ref GRCh38 --bed MESO_007_T.cnv.bed  --out MESO_007_T.cnv.aa
python2 /home/programs/AmpliconArchitect-master/src/amplified_intervals.py --gain 6.0 --cnsize_min 50000 --ref GRCh38 --bed MESO_048_T2.cnv.bed  --out MESO_048_T2.cnv.aa
```
