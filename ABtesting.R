# Distribution of KPI for each alternative:
means<- c(-1,1)
aPop<- function(x) dnorm(x,means[1])
bPop<- function(x) dnorm(x,means[2])

curve(aPop, -5,5, axes=FALSE, ylab="Frequency", xlab="", main="Distribution of KPI for Each Alternative")
curve(bPop, add=TRUE)
axis(side=1, at=means, labels=c("A","B"))
abline(v=means, lty=3)

# Observed KPI values:
observed<- c(-0.8, 0.2)
points(x=observed, y=c(0,0), pch=4)



# Distribution of difference under H_0 assumption:
difPop<- function(x) dnorm(x,0)
curve(difPop, -5,5, axes=FALSE, ylab="Frequency", xlab="", main="Distribution of Difference in KPI Between A,B")
axis(side=1, at=0)

obs.diff<- diff(observed)
points(x=obs.diff, y=0, pch=4, cex=2)
xs<- seq(obs.diff,5,length.out=40)
segments(x0=xs, y0=0, x1=xs, y1=difPop(xs) )


#### Sample size calculator ####
# Assuming:
# () equal variance
# () coef of variation =1
# () equal group sizes
# () null is equal expectancies

my.n<- function(c) 2*(qnorm(0.95)-qnorm(0.2))^2/(c-1)^2
curve(my.n, 1, 2, ylab='Group Size', xlab='Change Ratio', main="Sample Size to Detect KPI Difference", log='y')


function(n) power.t.test



