#!/bin/bash

###########################################################################
##
## sbatch SLRUM_solve_time.sh
##
## for i in {1..200}; do sbatch -c64 --export=NCOLS=13 SLRUM_solve_time.sh ; done
##
###########################################################################

####### job customization
#SBATCH --job-name=R_test
#SBATCH -N 1
#SBATCH -c 8                         #this sets SLURM_CPUS_ON_NODE
#SBATCH -t 00:15:00
#SBATCH -p normal_q
#SBATCH -A stat5526-fall2020
###SBATCH --mail-user=rsettlag@vt.edu #uncomment and change if you want emails
#SBATCH --mail-type=FAIL

###########################################################################
date
cluster=${SLURM_CLUSTER_NAME}
echo running on $cluster cluster in node `hostname`
echo in job $SLURM_JOB_ID
echo with tmpfs $TMPFS
echo with tmpdir $TMPDIR

## starting the script, need day
start=$(date +%s)
today=$(date '+%D %T')
echo $today

#####################################
# cd /home/rsettlag/zz_R_testing/

module load containers/singularity
singularity exec --bind $TMPFS:/tmp,/sys/fs/cgroup/cpuset/slurm/uid_$(id -u):/job_sets \
			/projects/arcsingularity/ood-rstudio-basic_4.0.0.sif Rscript solve_time.R $NCOLS

#####################################

end=$(date +%s)
echo script took echo $((end - start))
echo DONE DONE
exit;