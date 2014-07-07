
#### Testing error catching ####
tryCatch(1, finally = print("Hello"))
e <- simpleError("test error")
class(e)
## Not run: 
stop(e)
tryCatch(stop(e), finally = print("Hello"))
tryCatch(stop("fred"), finally = print("Hello"))

## End(Not run)
tryCatch(rnorm(1),  error = function(e) e, finally = print("Hello"))
tryCatch(stop(e), error = function(e) "e", finally = print("Hello"))
tryCatch(stop("fred"),  error = function(e) e, finally = print("Hello"))
withCallingHandlers({ warning("A"); 1+2 }, warning = function(w) {})
## Not run: 
{ withRestarts(stop("A"), abort = function() {}); 1 }

## End(Not run)
withRestarts(invokeRestart("foo", 1, 2), foo = function(x, y) {x + y})


##================================================================##
###  In longer simulations, aka computer experiments,		 ###
###  you may want to						 ###
###  1) catch all errors and warnings (and continue)		 ###
###  2) store the error or warning messages			 ###
###								 ###
###  Here's a solution	(see R-help mailing list, Dec 9, 2010):	 ###
##================================================================##

##' Catch *and* save both errors and warnings, and in the case of
##' a warning, also keep the computed result.
##'
tryCatch.W.E <- function(expr)
{
  W <- NULL
  w.handler <- function(w){ # warning handler
    W <<- w
    invokeRestart("muffleWarning")
  }
  list(value = withCallingHandlers(tryCatch(expr, 
                                            error = function(e) e),
                                   warning = w.handler),
       warning = W)
}

str( tryCatch.W.E( log( 2 ) ) )
# List of 2
# $ value  : num 0.693
# $ warning: NULL

str( tryCatch.W.E( log( -1) ) )
# List of 2
# $ value  : num NaN
# $ warning:List of 2
# ..$ message: chr "NaNs produced"
# ..$ call   : language log(-1)
# ..- attr(*, "class")= chr [1:3] "simpleWarning" "warning" "condition"

str( tryCatch.W.E( log("a") ) )
# List of 2
# $ value  :List of 2
# ..$ message: chr "non-numeric argument to mathematical function"
# ..$ call   : language log("a")
# ..- attr(*, "class")= chr [1:3] "simpleError" "error" "condition"
# $ warning: NULL