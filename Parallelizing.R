library(parallel)
library(help='parallel')
?clusterApply

cores<- detectCores(logical = FALSE)
cl <- makeCluster(cores-1)

## ClusterApply
clusterApply(cl, 1:2, `+`, 3)
xx <- 1
clusterExport(cl, "xx")
clusterCall(cl, function(y) xx + y, 2)


##  mapply 
clusterMap(cl, function(x, y) {
  seq_len(x) + y},
  x=c(a =  1, b = 2, c = 3), 
  y=c(A = 10, B = 0, C = -10))


## Sapply
parSapply(cl, 1:20, get("+"), 3)
parSapply(cl, 1:20, `+`, 3)
parSapply(cl, 1:20, "+", 3)
parSapply(cl, 1:20, +, 3)



## A bootstrapping example, which can be done in many ways:

## set up each worker.  Could also use clusterExport()
clusterEvalQ(cl, {
  library(boot)
  # Generate data:
  cd4.rg <- function(data, mle) MASS::mvrnorm(nrow(data), mle$m, mle$v)
  # Compute statistics
  cd4.mle <- list(m = colMeans(cd4), v = var(cd4))
  NULL
})

# Generate bootsrap samples:
res <- clusterEvalQ(cl, boot(cd4, corr, R = 100,
                             sim = "parametric", 
                             ran.gen = cd4.rg, 
                             mle = cd4.mle))


library(boot)
## Concatenate boot results from different machines 
cd4.boot <- do.call(c, res)
# Use boot samples for CIs:
boot.ci(cd4.boot,  
        type = c("norm", "basic", "perc"),
        conf = 0.9, h = atanh, hinv = tanh)
stopCluster(cl)

## run everything in one call:
library(boot)
run1 <- function(...) {
  library(boot)
  # make data
  cd4.rg <- function(data, mle) MASS::mvrnorm(nrow(data), mle$m, mle$v)
  # cmpute sample wise statistics
  cd4.mle <- list(m = colMeans(cd4), v = var(cd4))
  boot(cd4, corr, R = 500, sim = "parametric",
       ran.gen = cd4.rg, mle = cd4.mle)
}
cl <- makeCluster(mc <- detectCores())
## to make this reproducible
clusterSetRNGStream(cl, 123)
cd4.boot <- do.call(c, parLapply(cl, seq_len(mc), run1))
boot.ci(cd4.boot,  type = c("norm", "basic", "perc"),
        conf = 0.9, h = atanh, hinv = tanh)
stopCluster(cl)
