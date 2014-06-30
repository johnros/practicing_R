install.packages('lme4') 
require(lme4)

rm(list=ls())
data(Dyestuff, package='lme4')
head(Dyestuff)
attach(Dyestuff)
plot(Yield~Batch)

# Mixed effects model:
fm1<- lmer ( Yield ~ 1  | Batch  , Dyestuff )
fm1
fixef(fm1) # Fixed effects
ranef(fm1) # Random effects
fitted(fm1) # Note: predict() will not work on lme objects :-(
model.matrix(fm1)

detach(Dyestuff)




head(Penicillin)
attach(Penicillin)
table(sample, plate)
xtabs(~sample+plate, Penicillin) # Formula interface for cross tabulation.
dotplot(reorder(plate, diameter) ~ diameter,data=Penicillin, 
              groups = sample,
              ylab = "Plate", xlab = "Diameter of growth inhibition zone (mm)",
              type = c("p", "a"), auto.key = list(columns = 6, lines = TRUE))

fm2 <- lmer ( diameter ~  1+ (1| plate ) + (1| sample ) , Penicillin )
fixef(fm2) # Fixed effects
ranef(fm2) # Random effects


# Prediction intervals for random effects:
qrr2 <- dotplot(ranef(fm2, postVar = TRUE), strip = FALSE)
print(qrr2[[1]], pos = c(0,0,1,0.75), more = TRUE)
print(qrr2[[2]], pos = c(0,0.65,1,1))



detach(Penicillin)


# A nested random effect:
attach(Pastes)
head(Pastes)
str(Pastes) # very useful for discovering the structure of objects
xtabs ( ~ batch + sample , Pastes , sparse = FALSE )
xtabs ( ~ batch + sample , Pastes , sparse = TRUE )
# The sample factor is nested within the batch factor. 
# Each sample is from one of three casks selected from a particular batch.
# We can label the casks as ‘a’, ‘b’ and ‘c’ but then the cask factor by itself is meaningless
# (because cask ‘a’ in batch ‘A’ is unrelated to cask ‘a’in batches ‘B’, ‘C’, . . . ). The cask
# factor is only meaningful within a batch.


# Wrong!
(fm3 <- lmer ( strength ~ 1 + (1| batch ) + (1| cask ) , Pastes ))
# Right!
(Pastes$sample <- factor ( Pastes$batch : Pastes$cask ))
(fm3 <- lmer ( strength ~ 1 + (1| batch ) + (1| sample ) , Pastes ))


# Prediction intervals
Pastes <- within(Pastes, bb <- reorder(batch, strength))
Pastes <- within(Pastes, ss <- reorder(reorder(sample, strength), as.numeric(batch)))
print(dotplot(ss ~ strength | bb, Pastes,
              strip = FALSE, strip.left = TRUE, layout = c(1, 10),
              scales = list(y = list(relation = "free")),
              ylab = "Sample within batch", type = c("p", "a"),
              xlab = "Paste strength", jitter.y = TRUE))

# Maybe there is no batch variability?
# Note: estimation should be done using ML and not REML when comparing models:
fm3M <- update ( fm3 , REML = FALSE )
fm4M <- lmer ( strength ~ 1 + (1| sample ) , Pastes , REML = FALSE )
anova ( fm4M , fm3M ) # Yep... batch effect can be removed!

detach(Pastes)





## Adding fixed effects (a.k.a. "Hirarchial model", "Multiple Membership", "Cross classified model" )
rm(list=ls())
load('MixedModels/2011-08-15-Coventry/classroom.rda') # load the data from binary
head(classroom)
xtabs(~classid, classroom)

# Do not try to understand the next command. Just look at the plot.
refactor <- function(x) if(is.factor(x)) factor(x) else x
sch12 <- do.call(data.frame, lapply(subset(classroom, schoolid %in% c(12,15, 17, 33,46, 57, 68, 70, 71, 76, 85, 99)), refactor))
sch12$ss <- reorder(sch12$schoolid, sch12$mathgain)
sch12$cc <- reorder(reorder(sch12$classid, sch12$mathgain), as.numeric(sch12$schoolid))
print(dotplot(cc ~ mathgain | ss , sch12, 
              strip = FALSE, strip.left = TRUE, layout = c(1, 12),
              scales = list(y = list(relation = "free")), pch = 21,
              ylab = "Class within school", type = c("p", "a"),
              xlab = "Mathematics gain from kindergarten to grade 1",
              jitter.y = TRUE))



# Simple "unconditonal" model (not controlling for student charachteristis) (a.k.a. "random effects")
( fm5 <- lmer ( mathgain ~ 1 + (1| classid ) + (1| schoolid ) , classroom ))

# Mixed model:
 fm6 <- lmer ( mathgain ~ 1 + 1 + mathkind + minority + sex + ses + housepov + (1| classid ) + (1| schoolid ) , classroom )
fixef(fm6)
names(ranef(fm6))
summary(fm6)

# Where are the p-values?!?
# They are missing because they are hard to compute.
# A heuristic approach: t-values greater than 2 are significant.

# Check if class random effect is significant:
fm8 <- lmer(mathgain ~ mathkind + minority + ses + (1|classid) + (1|schoolid), classroom)
fm8M <- update ( fm8 , REML = FALSE )
fm9M <- lmer(mathgain ~ mathkind + minority + ses + (1|schoolid), classroom, REML = FALSE)

anova ( fm9M , fm8M ) # There seems to be a class effect!
# Note: the theory behind these tests is not very percise, so do not take them too seriously.





## Longitudinal data (a.k.a. repeated measures)
rm(list=ls())
data(sleepstudy)
xyplot(Reaction ~ Days | Subject, sleepstudy, aspect = "xy",
             layout = c(9,2), type = c("g", "p", "r"),
             index.cond = function(x,y) coef(lm(y ~ x))[1],
             xlab = "Days of sleep deprivation",
             ylab = "Average reaction time (ms)")

# Let's look at the distribution of intercepts and slopes:
plot(confint(lmList(Reaction ~ Days | Subject, sleepstudy), pooled = TRUE), order = 1)

# Fit a simple mixed model:
( fm1 <- lmer ( Reaction ~ Days + ( Days | Subject ) , sleepstudy ))
fixef(fm1)
ranef(fm1)
head(model.matrix(fm1))

# The correlation between random effects is small (see plot and output).
# Let's force uncorrelated random effects:
( fm2 <- lmer (Reaction ~ Days + (1 | Subject) + (0 + Days | Subject), sleepstudy ))

# Were we right?
anova(fm1, fm2) # Yep!


# "Borrowing strength" between subjects:
# The naive subject means are shrunken towards the fixed-effects estimates.

source('utility1.R') # shrinkage
source('utility2.R') # Predictions





## Specifying interactions:
rm(list=ls())
install.packages('SASmixed')
data(Multilocation, package='SASmixed')
head(Multilocation) #multi-location trial of several treatments
# There is definitly a location effect. The block effect is smaller:
source('utility3.R')

# Let's study the Trt effect while controlling for location and block (coded in Grp)
(fm3 <- lmer ( Adj ~ Trt + (1| Grp ) , Multilocation ) )
fm4 <- lmer ( Adj ~ 1 + (1| Grp ) , Multilocation )
anova ( fm4 , fm3 ) # There is indeed a Trt effect!

# If we want to look for different Trt effect at those location only:
fm5 <- lmer ( Adj ~ Location + Trt + (1| Grp ) , Multilocation )
fm6 <- lmer ( Adj ~ Location * Trt + (1| Grp ) , Multilocation )
anova(fm5, fm6) # Hmmm... I would say there is indeed a difference.


# Is there a block random effect on top of the location random effect?
fm7 <- lmer ( Adj ~ Trt + (1| Location ) + (1| Grp ) , Multilocation )
fm8 <- lmer ( Adj ~ Trt + (1| Location ) , Multilocation )
anova(fm7, fm8) # Nope.

## Interactions beytween random and fixed effects:
# Is there a location-batch random effect on top of the location-treatment interaction?
(fm9 <- lmer ( Adj ~ Trt + (1| Trt : Location ) + (1| Location ) , Multilocation , REML = FALSE ))
(fm10 <- update ( fm9 , . ~ . + (1| Grp )))
anova(fm9, fm10) # The location random effect suffice!

# Alternative formulation (at the possible risk of over determination):
(fm11 <- lmer ( Adj ~ Trt + ( Trt | Location ) + (1| Grp ) , Multilocation , REML = FALSE ))
# But wait. What is the base line? Maybe better remove the intercept:
(fm12 <- lmer ( Adj ~ Trt + (0 + Trt | Location ) + (1| Grp ) , Multilocation , REML = FALSE ))


## Correlation between random effects:
# Note the high correlation between random effects:
fm11
# By default, an arbitrary covariance between random effects is allowed.