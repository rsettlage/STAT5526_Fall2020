## note we are being really poor in our style here, we are expecting the args to come in order
### pi_beer.R 123456 1000
### this sets seed to 123455 and sets n to 1000

args <- commandArgs()
##cat(args, sep = "\n")

if (length(args)<2) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  seed <- args[1]
  n <- args[2]

}

n <- as.numeric(n)
set.seed(seed)
#n <- 200000  ## ok, no comments, but my wife likes IPAs ...
# choose positions of center of needle . Note the " board " is 10X10 , vertical lines x. pos <- runif (n ,0 ,10)
x.pos <- runif(n,0,10)
y.pos <- runif(n,0,10)
rotation <- runif(n,0,pi/2)
# figure out the x,y coords of the match endpoints
x.max <- x.pos + 0.5* cos(rotation)
x.min <- x.pos - 0.5* cos(rotation)
y.max <- y.pos + 0.5* sin(rotation)
y.min <- y.pos - 0.5* sin(rotation)
crosses <- ifelse(ceiling(x.min)==floor(x.max),1,0)
# draw the board

pi_est <- 2*n/sum(crosses)
pi_est
saveRDS(pi_est,paste0("pi_",n,"_",seed,".RDS"))
