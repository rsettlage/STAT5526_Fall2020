#!/bin/bash

## sbatch --export=SEED=12345,N=10 sim_PI.sh 
##
## to try a loop: 
##        for i in {1..20..5}; do sbatch --export=SEED=12345,N=$i sim_PI.sh ; done
##
## or two loops:  
##        for i in {1..20..5}; do for j in {1..5}; do sbatch --export=SEED=12345$j,N=$i sim_PI.sh ; done done

###########################################################################
####### job customization
#SBATCH --job-name=matrixmult
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -t 01:00:00
#SBATCH -p normal_q
#SBATCH -A stat5526-fall2020
###SBATCH --mail-user=PID@vt.edu ## uncomment and change pid to you if you want emails
#SBATCH --mail-type=FAIL
####### end of job customization
###########################################################################

module reset
module load containers/singularity

echo running R

### to see it in action, use the following
singularity exec /projects/arcsingularity/ood-rstudio-basic_4.0.3.sif Rscript -e "set.seed($SEED);print($SEED);sum(rbinom($N,1,0.5))"

### when you are ready to use this on an actual script, comment the last line out and uncomment the next one
#singularity exec /projects/arcsingularity/ood-rstudio-basic_4.0.3.sif Rscript you_cool_pi.R
