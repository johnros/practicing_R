#### Help resource ####
# For information on machine learning in R see:
# http://cran.r-project.org/web/views/MachineLearning.html



#### Linear Models ####
# SUPER useful and important!
# The engine behind most common models: regression, ANOVA, ANCOVA, OLS, ...


# Let's start with a single variable:
attach(trees)
plot(trees)


plot(Volume~ Girth); rug(Girth, side=1); rug(Volume, side=2)
lm.1<- lm(formula=Volume~ Girth)
abline(lm.1)

(predict.1<- predict(lm.1))
points(predict.1~Girth, col='red')


# General summary:
summary(lm.1)

# ANOVA table:
anova(lm.1)

# Coefficients:
coef(lm.1)
(coef.1.table<- coef(summary(lm.1)))
alpha<- 0.05
cbind(
  coef.1.table[,'Estimate']- qnorm(1-alpha/2)* coef.1.table[,'Std. Error'],
  coef.1.table[,'Estimate']+ qnorm(1-alpha/2)* coef.1.table[,'Std. Error']
)

confint(lm.1)

# Residuals:
(resid.1<- residuals(lm.1))

plot(resid.1)
abline(0,0, lty=2)
lines(lowess(resid.1), lty=3)

index.group<- cut(seq(along.with=resid.1), 6)
boxplot(resid.1~ index.group)
points(resid.1~ index.group, cex=0.5)
abline(0,0, lty=2)
# The residuals could look better
plot(resid.1~ Girth)
abline(0,0, lty=2)
lines(lowess(resid.1 ~ Girth), lty=3)




# Recall! the volume of a tube = pi * r^2 * h
plot(Volume ~ I(Girth^2) )
rug(Girth^2, side=1); rug(Volume, side=2)
lm.2<- lm(formula=Volume~ I(Girth^2))
abline(lm.2)
resid.2<- residuals(lm.2)

boxplot(resid.2~ index.group)
points(resid.2~ index.group, cex=0.5)
abline(0,0, lty=2)

plot(resid.2~ Girth)
abline(0,0, lty=2)
lines(lowess(resid.2 ~ Girth), lty=3)


# Predictions:
predict.2<- predict(lm.2)
plot(Volume ~ Girth )
abline(lm.2) # The model coefficients are in a different scale than the current plot.
lines(predict.2~Girth, col='red', type='b')

# Prediction: what will be the (average) volume of a tree of girth=10 ?
(coefs.2<- coef(lm.2))
coefs.2[[1]] + coefs.2[[2]] * 10^2 # Notice '[[' strips name attributes.

points(x=10, y=coefs.2[1] + coefs.2[2] * 10^2, col='blue', type='h')


# Exctracting more statistics:
summary.2<- summary(lm.2)
names(summary.2)
summary.2$call
summary.2$aliased
summary.2$r.squared
summary.2$fstatistic


detach(trees)


### Multiple linear regression:
library(rgl)
xy.grid <- data.frame(x1=runif(10000), x2=runif(10000))

func1<-function(mesh, a0, a1, a2, sigma) {
  n<-nrow(mesh)
  a0 + a1 * mesh[, 1] + a2 * mesh[, 2] + rnorm(n, 0, sigma)
}

# More noise hides the stucture in the data:
z<-func1(xy.grid, a0=5, a1=1, a2=3, .0);z;xyz=data.frame(xy.grid, z);plot3d(xyz, xlab='x1', ylab='x2')
z<-func1(xy.grid, a0=5, a1=1, a2=3, .4);xyz=data.frame(xy.grid, z);plot3d(xyz, xlab='x1', ylab='x2')
z<-func1(xy.grid, a0=5, a1=1, a2=3, 11);xyz=data.frame(xy.grid, z);plot3d(xyz, xlab='x1', ylab='x2')

z<-func1(xy.grid, a0=5, a1=1, a2=3, .4);xyz=data.frame(xy.grid, z);plot3d(xyz, xlab='x1', ylab='x2')
lmFit<- lm(z~., xyz) #Solves the system "prediction=(X'X)^-1 X'y"
summary(lmFit)







##### Factorial designs (ANOVA) and linear contrasts ####
rm(list=ls())

# Just for sanity checks:
group.means<- aggregate(x=PlantGrowth$weight, by=list(group= PlantGrowth$group), FUN=mean)
plot(group.means)

# Fit the first linear models:
lm.1<- lm(data= PlantGrowth, weight~ group)
summary(lm.1)
model.matrix(lm.1) # Shows the actual X matrix used for fitting

class(PlantGrowth$group)
attributes(PlantGrowth$group)

# Dummy coding by default:
contrasts(PlantGrowth$group) 

# Specifying a custom contrats:
(my.contrast<- cbind( trt1=c(0,1,0), trt2=c(0,0,1)))
contrasts(PlantGrowth$group)<- my.contrast
contrasts(PlantGrowth$group)
lm(data= PlantGrowth, weight~ group)

(my.contrast<- cbind( ctr1=c(1,0,0), trt2=c(0,0,1)))
contrasts(PlantGrowth$group)<- my.contrast
lm(data= PlantGrowth, weight~ group) # What is the base line category now?

(my.contrast<- cbind( allTrts=c(0,1,1)))
contrasts(PlantGrowth$group)<- my.contrast
contrasts(PlantGrowth$group)
lm(data= PlantGrowth, weight~ group) # Note the last contrast has been automatically added.
# Sanity checks:
mean(PlantGrowth$weight[PlantGrowth$group!='ctrl'])==sum(coef(lm(data= PlantGrowth, weight~ group))[c(1,2)])


# Effect coding:
(my.contrast<- cbind( ctrVStrt1=c(1,0,-1), ctrVStrt2=c(1,-1,0)))
contrasts(PlantGrowth$group)<- my.contrast
lm(data= PlantGrowth, weight~ group)
cat('Baseline is global mean:',mean(PlantGrowth$weight))

#------------ Note: why use effect coding?--------------#
# If you have an interaction of two categorical variables 
# then effect coding may provide some benefits. 
# The primary benefit is that you get reasonable 
# estimates of both the main effects and interaction using effect coding. 
# With dummy coding the estimate of the interaction is fine 
# but main effects are not "true" main effects but rather what are called simple effects, 
# i.e., the effect of one variable at one level of the other variable. 
# This is why most analysis of variance programs use some type of 
# effect coding when estimating the various effects in an ANOVA model
#--------------------------------------------------------------------------#



# Using built in contrast builders:
contrasts(PlantGrowth$group)<- contr.treatment(n=3, base=1) # For dummy coding
contrasts(PlantGrowth$group)

contrasts(PlantGrowth$group)<- contr.sum # For effect coding
contrasts(PlantGrowth$group)
lm(data= PlantGrowth, weight~ C(group, contr=contr.sum))

# Also possible through the C() interface:
lm(data= PlantGrowth, weight~ C(group, contr=contr.treatment, base=1))
lm(data= PlantGrowth, weight~ C(group, contr=contr.treatment, base=2))
lm(data= PlantGrowth, weight~ C(group, contr=contr.treatment, base=3))


# Help!: For more information about contrasts: ?contrast

# Get system default contrasts:
options('contrasts')
# Set default contrasts:
options(contrasts=c(unordered='contr.sum', ordered='contr.poly'))
options(contrasts=c(unordered='contr.treatment', ordered='contr.poly'))



## Formula interface: main effects, interactions, nesting
require('MASS')
head(npk) # 6 blocks, 2^3 design.
?npk

# Main effects only:
options(contrasts=c("contr.treatment", "contr.poly"))
(lm.1<- lm(yield ~ block + N+P+K, data=npk))
round(vcov(lm.1),2) # Non orthogonal contrasts
# Use Helmert contrasts: second- first, third-second, ...
options(contrasts=c("contr.helmert", "contr.poly")) 
lm.2<- lm(yield ~ block + N+P+K, data=npk)
round(vcov(lm.2),2)
summary(lm.2)
anova(lm.2)
drop1(lm.2, test='F')
contrasts(npk$N) # Note the output depends on the system defaults!


# Add interactions:
lm.3<- lm(yield ~ block + N*P*K, data=npk)
round(vcov(lm.3),2)
formula(lm.3)
anova(lm.3)
summary(lm.3)
alias(lm.3)
model.matrix(lm.3)
summary(lm.2)
alias(lm.2)


# Forcing the order of the terms:
lm(yield ~ block + N*P+K, data=npk)
lm(terms(yield ~ block + N * P + K, keep.order=TRUE), npk)



# Equivalent specifications:
options(contrasts=c("contr.treatment", "contr.poly"))
lm(yield ~ block + N*P, data=npk)
lm(yield ~ block + N + P + N:P, data=npk)
lm(yield ~ block + (N+P)^2, data=npk)

lm(yield ~ block + N*P*K, data=npk)
lm(yield ~ block + (N+P+K)^3, data=npk)



# "all the other variables" operator:
(lm.2<- lm(Employed~ . , data=longley))
(lm.3<- lm(Employed~ .^2 , data=longley))


## No intercept:
# Recall: volume= pi * radius^2 * height  =>
# log(volume) = 2*log(Girth) + log(height) - (log(pi) + 2*log(2))
# I would thus expect the coefficients! { log(pi), 2, 1 }
(inter<- -(log(pi)+2*log(2)))
(lm.3<- lm(log(Volume)~ log(Girth)+log(Height) , data=trees))
(lm.4<- lm(log(Volume)~ log(Girth)+log(Height)-1 , data=trees)) # Remove the intercept
(lm.5<- lm(log(Volume)~ log(Girth) + log(Height) - 1 + offset(rep(inter, nrow(trees))) , data=trees)) # Force a known intercept










#### Model selection ####
# Adding one term at a time:
lm.1<- lm(GNP~1, data=longley)
(my.formula2<- formula(~Unemployed+Armed.Forces+Population+Year+Employed))

add1(lm.1, scope=my.formula2, test='F')
add1(lm.1, scope=my.formula2, k=log(length(nrow(longley))))
add1(lm.1, scope=my.formula2)

(lm.2<- update(lm.1, ~.+Year))
add1(lm.2, scope=my.formula2)
(lm.3<- update(lm.2, ~.+Population))
add1(lm.3, scope=my.formula2)
(lm.4<- update(lm.3, ~.+Unemployed))
add1(lm.4, scope=my.formula2)


# Do I really need to do it manually?!?
step(lm.1, scope=my.formula2) # Stepwise search using AIC
step(lm.1, scope=my.formula2, direction='forward') # Forward search using AIC


# How about backward searches:
my.formula1<- formula(GNP~Unemployed+Armed.Forces+Population+Year+Employed)
(lm.5<- lm(my.formula1, data=longley))
step(lm.5) # Backward model selection using AIC
step(lm.5, k=log(nrow(longley))) # Backward model selection using BIC



# Regression diagnostics
formula(lm.5)
plot(lm.5)

##########################################
# !!!Beware of causal interpretations!!! #
##########################################





## Multiplicity & post-hoc 
rm(list=ls())
(lm.1<- lm(data= PlantGrowth, weight~ group)) 


# Q: When do I need aov and not lm?
# A: Essentialy, differene only in appearances. Use lm and move to aov when you get errors. 
TukeyHSD(lm.1) 
aov.1<- aov(data= PlantGrowth, weight~ group) 
(Tukey.pairwise<- TukeyHSD(aov.1)) 
plot(Tukey.pairwise)


# Stanradrd errors of contrasts
my.contrast.1<- list(group=="ctrl", group=="trt1")
se.contrast(aov.1, contrast.obj = list(PlantGrowth$group == "ctrl", PlantGrowth$group == "trt1"))


# p-vaule based procedures:
rm(list=ls())
lm.1<- lm(data= longley, Employed~.)
summary(lm.1)
(coef.pvals<- coef(summary(lm.1))[,'Pr(>|t|)'])
# FWE control:
p.adjust(coef.pvals, method="bonferroni")
p.adjust(coef.pvals, method="holm")
p.adjust(coef.pvals, method="hochberg")
p.adjust(coef.pvals, method="hommel")
# FDR control:
p.adjust(coef.pvals, method="BH")



# multcomp package is best suited for linear contrasts:
rm(list=ls())
install.packages('multcomp')
require(multcomp)

lm.1<- lm(data= PlantGrowth, weight~ group) 
glht.1<- glht(lm.1, linfct=mcp(group = "Tukey"))
summary(glht.1) # Adjusted p-values
confint(glht.1)
plot(glht.1)



## cars data:
amod <- aov(breaks ~ tension, data = warpbreaks)
glht(amod, linfct = matrix(c(1, 0, 0, 
                             1, 1, 0, 
                             1, 0, 1), byrow = TRUE, ncol = 3))
# confidence bands for a simple linear model, `cars' data
plot(cars, xlab = "Speed (mph)", ylab = "Stopping distance (ft)", las = 1)
# fit linear model and add regression line to plot
lmod <- lm(dist ~ speed, data = cars)
abline(lmod)
# a grid of speeds
speeds <- seq(from = min(cars$speed), to = max(cars$speed), length = 10)
# linear hypotheses: 10 selected points on the regression line != 0
(K <- cbind(1, speeds))                                                        
# set up linear hypotheses
(cht <- glht(lmod, linfct = K))
# confidence intervals, i.e., confidence bands, and add them plot
(cci <- confint(cht))
lines(speeds, cci$confint[,"lwr"], col = "blue")
lines(speeds, cci$confint[,"upr"], col = "blue")






#### Robust regression ####

# Single variable:
plot(cars)
abline(line(cars)) # Robust line
abline(lm(dist~speed, data=cars), col='red') #OLS line


# Multiple variables:
require('MASS')
(y<- names(longley)=='Employed')
rlm.1<- rlm(y=longley[,y], x=longley[,!y],)
summary(rlm.1)
lm.1<- lm(Employed~., data= longley)
round(cbind(coef(rlm.1), coef(lm.1)[-1]),2)

lines(predict(rlm.1)~ cars$speed)







#### SVM ####
install.packages('e1071')
library(e1071)


attach(trees)
svm.1<- svm(Volume~ Girth)

?predict.svm
predict.svm<- predict(svm.1, Girth)
plot(Volume~Girth)
lines(predict.svm~ Girth, type='b', col='red')
lines(predict.1~ Girth, col='grey', type='b')
 
summary(svm.1)


# Maybe regularization parameters should be optimized?
tune(svm, Volume~Girth, ranges = list(gamma = 2^(-1:1), cost = 2^(2:4)))

svm.2<- svm(Volume~Girth, gamma=0.5, cost=16)
predict.svm.2<- predict(svm.2, Girth)

plot(Volume~Girth)
lines(predict.svm.2~ Girth, type='b', col='brown')
lines(predict.svm~ Girth, type='b', col='red')







#### CART ####
library(rpart)

tree.1<- rpart(Volume ~ Girth)
predict.tree<- predict(tree.1)

plot(Volume~ Girth)
lines(predict.tree~ Girth, type='b', col='magenta')

install.packages('maptree')
help(package='maptree')
library(maptree)

draw.tree(tree.1)

tree.2<- clip.rpart(tree.1, best=2)
predict.tree.2<- predict(tree.2)
plot(Volume~ Girth)
lines(predict.tree~ Girth, type='b', col='magenta')
lines(predict.tree.2~ Girth, type='b', col='red')





#### PCA ####
head(USArrests)
summary(pc.cr <- princomp(USArrests, cor = TRUE))
loadings(pc.cr)  ## note that blank entries are small but not zero
plot(pc.cr) # shows a screeplot.
biplot(pc.cr)

setwd('~/Dropbox/Maccabi Workshop/')
capture.output(loadings(pc.cr), file='Output/USArrests.txt', append=FALSE)
capture.output(paste(rep("#", 100), collapse=""), file='Output/USArrests.txt', append=TRUE)

# Another implementation:
pc.cr.2<- prcomp(USArrests, scale=TRUE)
summary(pc.cr.2)
biplot(pc.cr.2)
capture.output(pc.cr.2$rotation, file='Output/USArrests.txt', append=TRUE)
capture.output(paste(rep("#", 100), collapse=""), file='Output/USArrests.txt', append=TRUE)


## Factor analysis:
factanl.1<- factanal(x=USArrests, factors=1,)
loadings(factanl.1)
capture.output(loadings(factanl.1), file='Output/USArrests.txt', append=TRUE)
capture.output(paste(rep("#", 100), collapse=""), file='Output/USArrests.txt', append=TRUE)

# Note: Factor analysis and principal components are not the same thing!
# They are however often confued because some implementations of FA use PCA.
# The FA implementation in SPSS is such.
# The FA implementation in R differs from PCA as we can see.






v1 <- c(1,1,1,1,1,1,1,1,1,1,3,3,3,3,3,4,5,6)
v2 <- c(1,2,1,1,1,1,2,1,2,1,3,4,3,3,3,4,6,5)
v3 <- c(3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,5,4,6)
v4 <- c(3,3,4,3,3,1,1,2,1,1,1,1,2,1,1,5,6,4)
v5 <- c(1,1,1,1,1,3,3,3,3,3,1,1,1,1,1,6,4,5)
v6 <- c(1,1,1,2,1,3,3,3,4,3,1,1,1,2,1,6,5,4)
m1 <- cbind(v1,v2,v3,v4,v5,v6)
cor(m1)
factanal(m1, factors = 3) # varimax is the default
factanal(m1, factors = 3, rotation = "promax")
# The following shows the g factor as PC1
prcomp(m1)

