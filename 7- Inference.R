# To find all available tests:

help.search('test',pack='stats')

# ---------Goodness of fit-----------#
(x <- c(A = 20, B = 15, C = 25))
chisq.test(x)

x <- c(89,37,30,28,2)
p <- c(0.4,0.2,0.2,0.15,0.05)
chisq.test(x, p = p)

p <- c(40,20,20,15,5)
chisq.test(x, p = p, rescale.p = TRUE)


hist(x<- rexp(100, rate=2))
ks.test(x=x, y=pexp)
ks.test(x=x, y=pexp, 2)

ks.test(x=x, y=rexp(100, rate=2))
ks.test(x=x, y=rexp(100, rate=1))



# -----Homogeity----- #
WorldPhones
chisq.test(WorldPhones)



#--------- T-test ------------#
x<- rnorm(100,4)
hist(x);rug(x)
t.test(x, mean=5)

t.test(x=1:10, y=c(7:20))      


#----------- Correlations----------#
cor(1:10,2:11)


head(longley)
(Cl <- cor(longley))
symnum(Cl) # highly correlated
library(lattice)
levelplot(Cl)

symnum(clS <- cor(longley, method = "spearman"))
symnum(clK <- cor(longley, method = "kendall"))



cor.test(longley$GNP, longley$Unemployed)




# ------ Non parametrics-----#
boxplot(x<- 1+runif(100))
wilcox.test(x)

y<- 1+runif(100)
wilcox.test(x,y)


z<- 1+runif(100)
kruskal.test(list(x,y,z))





