#!/bin/bash
#SBATCH --job-name="AArchitec"
#SBATCH --partition=high_p
#SBATCH -c 40
#SBATCH --mem-per-cpu=7000

export TMPDIR=/tmp

CONTAINER=/data/scratch/digenovaa/mesomics/AMPARCHITECT/aarchitect_v2.0.sif
singularity exec ${CONTAINER} make  all -j 40
 
