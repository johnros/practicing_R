

# This is a comment.



#--------------------- Simple Calculator ------------------------#

10+5

70*81

2 ** 4
2 ^ 4

6 %% 4 #Modulus
6 %/% 4 #Integer division ("Erech Tachton")


log(10)       					
log(16, 2)    					
log(1000, 10)

Inf+7
1/Inf
1/0
0/0
Inf/Inf

?Syntax  #For operator precedence

?Arithmetic #For a comprehensive list of functions and operators 

# Vector operations
x <-  c(1,2,3,4,5,6)
x
x+2
log(x)

sum(x)
prod(x)

x+ c(1,2) #Vectors are recycled
x+ c(1,2,3,4)

y<- c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6)

x * y 
t(x) %*% y #Inner product
x %*% y 
crossprod(x,y) #Same. But more efficient.

x %*% t(y) #Outer product 
outer(x,y) #Same. But more efficient.

# Complex numbers
7+0.5i + 2 
a<- 1i #Useful when programming
a

sin(6i) 
exp(6i)

Re(3+2i)  #Real element
Im(3+2i)  #Imaginary element
abs(3+4i) #Modulus
Mod(3+4i)

#------------------ Probability Calculator ---------------------#

# What is the PDF of X~B(n=10,p=0.5) at 3? 
dbinom(x=3, size=10, prob=0.5)
# Without names, arguments are evaluated by order of appearance
dbinom(3, 10, 0.5)


# How do I know the argument names of a know function? 
?dbinom
# Or use tab completion (in RStudio or console, but not in editor)

# And if I don't know the function's name?
help.search('binomial')
??binomial
help.start()

# What about the CDF?
pbinom(q=3, size=10, prob=0.5) 	
dbinom(x=0, size=10, prob=0.5)+dbinom(x=1, size=10, prob=0.5)+dbinom(x=2, size=10, prob=0.5)+dbinom(x=3, size=10, prob=0.5)

#Percentiles
qbinom(p=0.1718, size=10, prob=0.5) 

# Generating random numbers
rbinom(n=1, size=10, prob=0.5) 	
rbinom(n=10, size=10, prob=0.5)
rbinom(n=100, size=10, prob=0.5)

# Assigning output to variables
x <- rnorm(100, mean=100, sd=1)
x

# Simple summary statistics
hist(x)
rug(x)

# Remove a variable:
rm(x)
gc()




#How about other distributions?
hist( rexp(n=100,rate=1) )
hist( runif(n=1000,min=0,max=1) )
hist( rnorm(n=1000,mean=0,sd=1) )

# For more information on distributions see 
# http://cran.r-project.org/web/views/Distributions.html



## Closing a session:
# Save the script
# Save the workspace 

# Note on starting RStudio: start by clicking an R file and not using a shortcut)