
#------------------    Debugging    ------------------------------#
options(warn=1) 	# More warnings.
options(warn=2) 	# EVEN MORE WARNINGS!
options(warn=-1) 	# Enough with the warnings already!

# Recover errors
traceback()


# debug()
f<- function(x){
	x * 10
}
debug(f)
f(12)

undebug(f)

# Breakpoints: browser()
f<- function(x){
	y<- x * 10
	browser()
	return(y)
}
f(12)

# trace()
trace(sum)
hist(stats::rnorm(100)) # shows about 3-4 calls to sum()
untrace(sum)

# Core dump: dump.frames()
options(error=quote(dump.frames("testdump", TRUE))) # Will generate a custom error message and name the dumped frame.
f <- function() {
  g <- function() stop("test dump.frames")
  g()
}
f()   # will generate a dump on file "testdump.rda"
options(error=NULL) # Removes the custom error message.
 

load("testdump.rda") # Loads a dumped frame.
debugger(testdump) # Walk-through the execution of the dumped command.

# sys.call()
f <- function ()    { g(1) }
g <- function (...) { h(17^2) }
h <- function (x)   { 
  print(  sqrt(x)  )
  sys.calls()    
}

f()


# See also RUnit pacakge.

# Performance time: system.time()
system.time(mean(rnorm(1000000)))


# Profiling: Rprof()
Rprof()
n <- 200
m <- matrix(rnorm(n*n), nr=n, nc=n)
eigen(m)$vectors[,c(1,2)]
Rprof(NULL)

# Now go to shell and run R CMD Rprof Rprof.out
# The output will include the commands run, and the time on each command!



