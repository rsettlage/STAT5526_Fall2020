### expects power for size of matrix as command line arg
### usage: Rscript solve_time.R 10

args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  cat("One argument must be supplied (n for 2^n), setting it to 12","\n",sep="")
  n = 2^12
} else {
  # default output file
  n <- 2^as.numeric(args[1])
}

nl<-Sys.getenv('SLURM_NODELIST')
jid<-Sys.getenv('SLURM_JOB_ID')
cpus<-Sys.getenv('SLURM_CPUS_PER_TASK')
tmp<-paste0("/job_sets/job_",jid,"/cpuset.cpus")
if(file.exists(tmp)){
  cpuset<-read.table(tmp)
}else{
  tmp<-paste0("/sys/fs/cgroup/cpuset/slurm/uid_1207916/job_",jid,"/cpuset.cpus")
  cpuset<-read.table(tmp)
}
set.seed(34534)
M<-matrix(rnorm(n^2),nrow=n);
Mt<-t(M);
MtM<-M%*%t(M);
times<-as.data.frame(cbind(nl,jid,cpus,cpuset,n,rbind(c(system.time(s<-solve(MtM))[1:3],max(abs(s%*%MtM-diag(n)))),
                                                    c(system.time(s<-solve(MtM))[1:3],max(abs(s%*%MtM-diag(n)))),
                                                    c(system.time(s<-solve(MtM))[1:3],max(abs(s%*%MtM-diag(n)))),
                                                    c(system.time(s<-solve(MtM))[1:3],max(abs(s%*%MtM-diag(n)))),
                                                    c(system.time(s<-solve(MtM))[1:3],max(abs(s%*%MtM-diag(n)))),
                                                    c(system.time(s<-solve(MtM))[1:3],max(abs(s%*%MtM-diag(n)))))))
colnames(times)<-c("host","jobID","cores","cpuset","n","user","system","actual","maxDiff")
saveRDS(times,paste0(nl,"_times_",jid,".RDS"))
times