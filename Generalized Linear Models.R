
#------------ GLM --------------#

## Logistic regression
attach(PlantGrowth)
weight.factor<- cut(weight, 2, labels=c('Light', 'Heavy'))
plot(weight.factor)
plot(table(group, weight.factor))

contrasts(group)
options(contrasts=c(unordered='contr.treatment', ordered='contr.poly'))
contrasts(group)

# Fitting and interpreting a logistic regression:
glm.1<- glm(weight.factor~group, family=binomial)
summary(glm.1)
prop.table(table(group, weight.factor), margin=1)
log(0.6/0.4)- log(0.2/0.8)

# Predictions
(predict.1<- predict(glm.1))
exp(predict.1)/(exp(predict.1)+1) 
predict(glm.1, type='response')
# For help see ?predict.glm

# Analysis of Deviance ("ANOVA table")
anova(glm.1)
anova(glm.1, test='Chisq') # Equivalent to Type I sum of squares
drop1(glm.1, test='Chisq') # Equivalent to Type III sum of squares

# Analysis of residuals:
residuals(glm.1, type='response') 
residuals(glm.1, type='deviance')
residuals.1<- residuals(glm.1, type='pearson')
# For help see residuals.glm

detach(PlantGrowth)



# Same with continous predictors:
rm(list=ls())
data('Pima.te', package='MASS') # Loads data
head(Pima.te)
plot(Pima.te)
glm.1<- step(glm(type~., data=Pima.te, family=binomial))
summary(glm.1)
coef(glm.1)

anova(glm.1, test='Chisq')
plot(glm.1)

residuals.1<- residuals(glm.1, type='pearson')
plot(residuals.1~Pima.te$npreg); abline(0,0, lty=2); lines(lowess(residuals.1~Pima.te$npreg), col='red')
plot(residuals.1~Pima.te$glu); abline(0,0, lty=2); lines(lowess(residuals.1~Pima.te$glu), col='red')
plot(residuals.1~Pima.te$bmi); abline(0,0, lty=2); lines(lowess(residuals.1~Pima.te$bmi), col='red')
plot(residuals.1~Pima.te$ped); abline(0,0, lty=2); lines(lowess(residuals.1~Pima.te$ped), col='red')

glm.2<- step(glm(type~.^2, data=Pima.te, family=binomial))
summary(glm.2)




## Other binomial regressions:
glm(type~., data=Pima.te, family=binomial(link='logit')) # Logistic CDF
glm(type~., data=Pima.te, family=binomial(link='probit')) # Gaissuain CDF
glm(type~., data=Pima.te, family=binomial(link='cauchit')) # Cauchy CDF
glm(type~., data=Pima.te, family=binomial(link='cloglog')) # Complementary log-log 














## Poisson regression:
# Dobson (1990) Page 93: Randomized Controlled Trial :
counts <- c(18,17,15,20,10,20,25,13,12)
outcome <- gl(3,1,9)
(treatment <- gl(3,3))
(d.AD <- data.frame(treatment, outcome, counts))
glm.D93 <- glm(counts ~ outcome + treatment, family=poisson())
anova(glm.D93)
summary(glm.D93)




require(MASS)
## main-effects fit as Poisson GLM with offset
glm(Claims ~ District + Group + Age + offset(log(Holders)),
    data = Insurance, family = poisson)



# Other Poisson Link functions:
glm(counts ~ outcome + treatment, family=poisson(link=log))
glm(counts ~ outcome + treatment, family=poisson(link=sqrt))
glm(counts ~ outcome + treatment, family=poisson(link=identity))




# A Gamma example, from McCullagh & Nelder (1989, pp. 300-2)
clotting <- data.frame(
  u = c(5,10,15,20,30,40,60,80,100),
  lot1 = c(118,58,42,35,27,25,21,19,18),
  lot2 = c(69,35,26,21,18,16,13,12,12))
summary(glm(lot1 ~ log(u), data=clotting, family=Gamma))
summary(glm(lot2 ~ log(u), data=clotting, family=Gamma))