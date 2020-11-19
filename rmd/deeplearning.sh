#!/bin/bash

## sbatch --export=PARAM1=200,PARAM2=10 deeplearning.sh
##
## or two loops:  
##        for j in {1..5}; do for i in {16,24,32,64,96}; do sbatch --export=PARAM1=$i,PARAM2=$j deeplearning.sh ; done done

###########################################################################
####### job customization
#SBATCH --job-name=deeplearn
#SBATCH -N 1
#SBATCH --cores-per-socket=24 #   number of cores per socket to allocate
#SBATCH -t 10:00:00
#SBATCH -p intel_q
#SBATCH -A stat5526-fall2020
###SBATCH --mail-user=PID@vt.edu ## uncomment and change pid to you if you want emails
#SBATCH --mail-type=FAIL
####### end of job customization
###########################################################################

module reset
module load containers/singularity

echo running R
time singularity exec /projects/arcsingularity/Intel/ood-rstudio-keras_4.0.3.sif Rscript cifar10.R $PARAM1 $PARAM2

