# 
# Author: Jonathan Rosenblatt<john.ros@gmail.com>
###############################################################################

#--------------Motivating Examples--------------------------#
#
# Taken from :
#
# A) Paul Murrell's "R Graphics" book:
# http://www.stat.auckland.ac.nz/~paul/RGraphics/rgraphics.html
#
# B) Ross Ihaka's Statistical Graphics course: 
# http://www.stat.auckland.ac.nz/~ihaka/courses/787/

# Downloading a package (assuming not firewalled)
chooseCRANmirror(graphics=FALSE) # Just for the demonstratio
install.packages('lattice')
install.packages('ggplot2')
install.packages('scatterplot3d')
demo(graphics)


# Loading a package:
require('lattice')
library(lattice)
demo(lattice)
example(levelplot) #Includes contour( )
example(cloud) # Includes wireframe( )


############################################################
#--------------------- Base Graphics-----------------------#
############################################################

#------------ Starting a new plot-------------#
# plot.new()
# 
# # Margin sizes in inches:
# par(mai=c(2, 2, 1, 1))
# # Margin sizes in lines of text:
# par(mar=c(4, 4, 2, 2))
# # Plot size in inches:
# par(pin=c(5, 4))
# 
# # Set axis scals:
# plot.window(xlim=c(0,1), ylim=c(10,20))
# 
# plot.new()
# 
# plot.window(xlim=c(0,1), ylim=c(10,20))
# 
# axis(side=1)
# axis(side=2)
# axis(side=3)
# axis(side=4, pos=1.1)
# 
# plot.new()
# plot.window(xlim=c(1,4), ylim=c(10,20))
# axis(1, at=1:4, labels=c('A', 'B', 'C' ,'D'), col='dark orange', col.axis='red', font.axis= 2)
# title(main='Main', xlab='X', ylab='Y', font.main= 2, font.sub=3)
# title(sub='Sub', col.sub='dark green', cex.sub=10)
# box()
# 
# # A line graph:
# x = 1995:2005
# y = c(81.1, 83.1, 84.3, 85.2, 85.4, 86.5, 88.3, 88.6, 90.8, 91.1, 91.3)
# plot.new()
# plot.window(xlim = range(x), ylim = range(y))
# abline(h = -4:4, v = -4:4, col = "lightgrey")
# lines(x, y, lwd = 2)
# title(main = "A Line Graph Example",
# 		xlab = "Time",
# 		ylab = "Quality of R Graphics")
# axis(1)
# axis(2)
# box()
# 
# # Rosette:
# n = 17
# theta = seq(0, 2 * pi, length = n + 1)[1:n]
# x = sin(theta)
# y = cos(theta)
# (v1 = rep(1:n, n))
# (v2 = rep(1:n, rep(n, n)))
# plot.new()
# plot.window(xlim = c(-1, 1), ylim = c(-1, 1), asp = 1)
# segments(x[v1], y[v1], x[v2], y[v2])
# box()
# 
# # Curve Envelope:
# x1 = seq(0, 1, length = 20)
# y1 = rep(0, 20)
# x2 = rep(0, 20)
# y2 = seq(0.75, 0, length = 20)
# plot.new()
# plot.window(xlim = c(0, 1), ylim = c(0, 0.75), asp = 1)
# segments(x1, y1, x2, y2)
# box(col = "grey")
# 
# # Arrows:
# plot.new()
# plot.window(xlim = c(0, 1), ylim = c(0, 1))
# arrows(.05, .075, .45, .9, code = 1)
# arrows(.55, .9, .95, .075, code = 2)
# arrows(.1, 0, .9, 0, code = 3)
# text(.5, 1, "A", cex = 1.5)
# text(0, 0, "B", cex = 1.5)
# text(1, 0, "C", cex = 1.5)
# 
# # Arrows as error bars:
# x = 1:10
# y = runif(10) + rep(c(5, 6.5), c(5, 5))
# yl = y - 0.25 - runif(10)/3
# yu = y + 0.25 + runif(10)/3
# plot.new()
# plot.window(xlim = c(0.5, 10.5), ylim = range(yl, yu))
# arrows(x, yl, x, yu, code = 3, angle = 90, length = .125)
# points(x, y, pch = 19, cex = 1.5)
# axis(1, at = 1:10, labels = LETTERS[1:10])
# axis(2, las = 1)
# box()
# 
# # Manual boxplot:
# plot.new()
# plot.window(xlim = c(0, 5), ylim = c(0, 10))
# rect(0:4, 0, 1:5, c(7, 8, 4, 3), col = "lightblue")
# axis(1)
# axis(2, las = 1)
# 
# # Spiral Squares:
# plot.new()
# plot.window(xlim = c(-1, 1), ylim = c(-1, 1), asp = 1)
# x = c(-1, 1, 1, -1)
# y = c( 1, 1, -1, -1)
# polygon(x, y, col = "cornsilk")
# vertex1 = c(1, 2, 3, 4)
# vertex2 = c(2, 3, 4, 1)
# for(i in 1:50) {
# 	x = 0.9 * x[vertex1] + 0.1 * x[vertex2]
# 	y = 0.9 * y[vertex1] + 0.1 * y[vertex2]
# 	polygon(x, y, col = "cornsilk")
# }
# 
# # Drawing text:
# plot.new()
# plot.window(xlim = c(0, 1), ylim = c(0, 1))
# abline(h = c(.2, .5, .8), v = c(.5, .2, .8), col = "lightgrey")
# text(0.5, 0.5, "srt = 45, adj = c(.5, .5)", srt=45, adj=c(.5, .5))
# text(0.5, 0.8, "adj = c(0, .5)", adj = c(0, .5))
# text(0.5, 0.2, "adj = c(1, .5)", adj = c(1, .5))
# text(0.2, 0.5, "adj = c(1, 1)", adj = c(1, 1))
# text(0.8, 0.5, "adj = c(0, 0)", adj = c(0, 0))
# axis(1)
# axis(2, las = 1)
# box()
# 
# # Circles (Just a polygon...):
# R = 1
# xc = 0
# yc = 0
# n = 72
# t = seq(0, 2 * pi, length = n)[1:(n-1)]
# (x = xc + R * cos(t))
# (y = yc + R * sin(t))
# plot.new()
# plot.window(xlim = range(x), ylim = range(y), asp = 1)
# polygon(x, y, col = "lightblue", border = "navyblue")
# 
# # Ellipse:
# a = 4
# b = 2
# xc = 0
# yc = 0
# n = 72
# t = seq(0, 2 * pi, length = n)[1:(n-1)]
# (x = xc + a * cos(t))
# (y = yc + b * sin(t))
# plot.new()
# plot.window(xlim = range(x), ylim = range(y), asp = 1)
# polygon(x, y, col = "lightblue")
# 
# # Rotated Ellipse:
# a = 4
# b = 2
# xc = 0
# yc = 0
# n = 72
# theta = 45 * (pi / 180)
# t = seq(0, 2 * pi, length = n)[1:(n-1)]
# x = xc + a * cos(t) * cos(theta) - b * sin(t) * sin(theta)
# y = yc + a * cos(t) * sin(theta) + b * sin(t) * cos(theta)
# plot.new()
# plot.window(xlim = range(x), ylim = range(y), asp = 1)
# polygon(x, y, col = "lightblue")
# 
# # Bivariate normal quantile:
# n = 72
# rho = 0.5
# d = acos(rho)
# t = seq(0, 2 * pi, length = n)[1:(n-1)]
# plot.new()
# plot.window(xlim = c(-1, 1), ylim = c(-1, 1), asp = 1)
# rect(-1, -1, 1, 1)
# polygon(cos(t + d), y = cos(t))
# segments(-1, 0, 1, 0, lty = "13")
# segments(0, -1, 0, 1, lty = "13")
# axis(1)
# axis(2, las = 1)
# 
# # Spiral:
# k = 5
# n = k * 72
# theta = seq(0, k * 2 * pi, length = n)
# R = .98^(1:n - 1)
# x = R * cos(theta)
# y = R * sin(theta)
# plot.new()
# plot.window(xlim = range(x), ylim = range(y), asp = 1)
# lines(x, y)
# 
# # Querying the device status:
# par('din') # Device dimentions in inches
# par('fin') # Current figure dimensions in inches
# par('pin') # Current plot region dimensions in inches
# par('fig') # Normalized Device Coordinates for the figure region
# par('plt') # NDC coordinates for the plot region
# par('usr') # Extract exact scale limits: xleft, xright, ybottom, ytop.
# 
# 
# # Calculate angles:
# x = c(0, 0.5, 1.0)
# y = c(0.25, 0.5, 0.25)
# plot(x, y, type = "l")
# (dx = diff(x))
# (dy = diff(y))
# (pin = par("pin")) 
# (usr = par("usr"))  
# (ax = pin[1]/diff(usr[1:2]))
# (ay = pin[2]/diff(usr[3:4]))
# diff(180 * atan2(ay * dy, ax * dx) / pi) # Degrees of direction change
# 
# 

#------------Basic Scatter plot---------------#
# Make variables inside the data.frame accesible without calling it
attach(trees)
?trees
plot(Girth ~ Height)
# Now copy the plot to clipboard or export it using GUI.



par(mfrow=c(2,3))
plot(Girth, type='h', main="type='h'")
plot(Girth, type='o', main="type='o'")
plot(Girth, type='l', main="type='l'")
plot(Girth, type='s', main="type='s'")
plot(Girth, type='b', main="type='b'")
plot(Girth, type='p', main="type='p'")
par(mfrow=c(1,1))

#Plotting Character:
plot(Girth, pch='+', cex=3)
example(points)

#Line Appearance:
par(mfrow=c(2,3))
plot(Girth, type='l', lty=1, lwd=2)
plot(Girth, type='l', lty=2, lwd=2)
plot(Girth, type='l', lty=3, lwd=2)
plot(Girth, type='l', lty=4, lwd=2)
plot(Girth, type='l', lty=5, lwd=2)
plot(Girth, type='l', lty=6, lwd=2)
par(mfrow=c(1,1))


#Annotating plot:
plot(Girth)

abline(v=14, col='red')
abline(h=9, lty=4,lwd=4, col='pink')
abline(0,1 )

locator(1)

points(locator(5),pch=11)

points(x=1:30, y=rep(12,30), cex=0.5, col='darkblue')

lines(x=rep(c(5,10), 7), y=7:20, lty=2 )
lines(x=rep(c(5,10), 7)+2, y=7:20, lty=2 )
lines(x=rep(c(5,10), 7)+4, y=7:20, lty=2 , col='darkgreen')
lines(x=rep(c(5,10), 7)+6, y=7:20, lty=4 , col='brown', lwd=4)

plot(Girth)

segments(x0=rep(c(5,10), 7), y0=7:20, x1=rep(c(5,10), 7)+2, y1=(7:20)+2 )

arrows(x0=13,y0=16,x1=16,y1=17, )

rect(xleft=10, ybottom=12,  xright=12, ytop=16)

polygon(x=c(10,11,12,11.5,10.5), y=c(9,9.5,10,10.5,9.8), col='grey')

title(main='This plot makes no sense', sub='Or does it?')

text(locator(2),'Amazing!' )

mtext('Printing in the margins', side=2)
mtext(expression(alpha==log(f[i])), side=4)

# For more information for mathematical annotation see ?plotmath



#Adding legend
plot(Girth, pch='G',ylim=c(8,77), xlab='Tree number', ylab='', type='b', col='blue')
points(Volume, pch='V', type='b', col='red')
legend(x=2, y=70, legend=c('Girth', 'Volume'), pch=c('G','V'), col=c('blue','red'), bg='grey')
legend(locator(1), legend=c('Girth', 'Volume'), pch=c('G','V'), col=c('blue','red'), bg='grey')


#Adjusting Axes:
plot(Girth, xlab='Tree Index', ylab='Tree Girth')

plot(Girth, xlim=c(0,15), ylim=c(8,12))

# # Using layout
# (A<-matrix(c(1,1,2,3,4,4,5,6), byrow=TRUE, ncol=2))
# layout(A,heights=c(1/14,6/14,1/14,6/14))
# 
# oma.saved <- par("oma")
# par(oma = rep.int(0, 4))
# par(oma = oma.saved)
# o.par <- par(mar = rep.int(0, 4))
# for (i in seq_len(6)) {
# 	plot.new()
# 	box()
# 	text(0.5, 0.5, paste('Box no.',i), cex=3)
# }


## Very important to detach!!!
detach(trees)

############################################################
#--------------- Univariate Display------------------------#
############################################################
attach(PlantGrowth)
?PlantGrowth
head(PlantGrowth)

table(group)
length(unique(group))

dev.off() #Just to clean the graphics device
plot(group)
pie(table(group))

plot(weight)

plot(ecdf(weight))

hist(weight)
rug(weight)

plot(density(weight))
rug(weight)


fact.weight<- cut(weight, breaks=2, labels=c('Light', 'Heavy'))
table(group, fact.weight)
plot(table(group, fact.weight))

barplot(table(group, fact.weight),legend=T)
barplot(table(group, fact.weight),legend=T, col=c('seagreen','grey60','lightblue' ))
barplot(table(fact.weight,group),legend=T, col=c('seagreen','grey60'), horiz=T,density=c(50,25))

dotchart(table(fact.weight,group), pch=c(1,4), col=c('seagreen','grey'))
dotchart(table(group,fact.weight), col=c('red','darkred','blue'))

dotplot(weight)

boxplot(weight)

par(mfrow=c(3,1))
hist(weight[group=='trt1'], ylim=c(0,3),xlim=c(3,6))
hist(weight[group=='trt2'], ylim=c(0,3),xlim=c(3,6))
hist(weight[group=='ctrl'], ylim=c(0,3),xlim=c(3,6))
par(mfrow=c(1,1))

boxplot(weight ~ group)
boxplot(weight~group, col=c('seagreen2','lightgrey','darkred'))
colors()
boxplot(weight~group, col=sample(colors(),3), varwidth=T)


dens.trt1<- density(weight[group=='trt1'])
dens.trt2<- density(weight[group=='trt2'])
dens.ctrl<- density(weight[group=='ctrl'])
plot(dens.trt1, xlim=c(2,8), ylim=c(0,1), col='seagreen')
lines(dens.trt2, col='grey')
lines(dens.ctrl, col='darkred')
legend(x=2, y=1, legend=c('trt1','trt2','ctrl'), col=c('seagreen', 'grey', 'darkred'),lty=1)

par(mfrow=c(3,1))
hist(weight[group=='trt1'], probability=TRUE, xlim=c(2,8))
lines(dens.trt1)
rug(weight[group=='trt1'])
hist(weight[group=='trt2'], probability=TRUE, xlim=c(2,8))
lines(dens.trt2)
rug(weight[group=='trt2'])
hist(weight[group=='ctrl'], probability=TRUE, xlim=c(2,8))
lines(dens.ctrl)
rug(weight[group=='ctrl'])
par(mfrow=c(1,1))


require(lattice)
dotplot(weight~group)

detach(PlantGrowth)
#############################################################
#--------------- Multivariate Display-----------------------#
#############################################################
head(trees)
attach(trees)

# Mosaic plot for categorical variables
fac.height<- factor(cut(Height,2), labels=c('Short','Tall'))
fac.Volume<- factor(cut(Volume, 3), labels=c('Small', 'Medium', 'Large'))
fac.Girth<- factor(cut(Girth, 2), labels=c('Fat', 'Thin'))

# Two at a time:
table(fac.Volume, fac.height)
mosaicplot(table(fac.Volume, fac.height))

# Three at a time:
table(fac.Volume, fac.height, fac.Girth)
ftable(fac.Volume, fac.height, fac.Girth)
mosaicplot(table(fac.height, fac.Volume , fac.Girth))


ftable(Titanic)
mosaicplot(Titanic)


# Scatter plots with our first OLS line!
plot(Volume~Girth)
abline(lm(Volume ~ Girth))
(lm.coefs<- round(coef(lm(Volume~Girth)),2))  
text(x=12, y=70, paste('Slope=', lm.coefs[2],'\n Intercept=', lm.coefs[1] ))
rug(Girth, side=1)
rug(Volume, side=2)

plot(Volume~Girth, col=fac.height)
legend(x=9, y=71, legend=c('Short','Tall'), col=c(1,2), pch=1)

# Printer friendly version
pchs<- as.numeric(fac.height) 
plot(Volume~Girth, pch=pchs)
legend(x=9, y=71, legend=c('Short','Tall'), pch=unique(pchs))
abline(lm(Volume[fac.height=='Short']~Girth[fac.height=='Short']))
abline(lm(Volume[fac.height!='Short']~Girth[fac.height!='Short']), lty=2)

#Interaction with the plot
plot(Volume~Girth)
identify(y=Volume, x=Girth) # Press ESC to exit interactive mode

# Scatter plot matrix:
plot(trees) #this actually calls: 
pairs(trees)

# A fancier version of the scatter plot matrix:
require(car)
scatterplot.matrix(trees)

# A conditional scatterplot:
coplot(Volume ~ Girth | fac.height)

# 3D scatter plot with fitted plane
require(scatterplot3d)
s3d<- scatterplot3d(x=Girth, y=Height , z=Volume , type='h', highlight.3d=T)

(lm.2<- lm(Volume ~  Girth + Height))
s3d$plane3d(lm.2, lty.box='solid')

#Interactive 3D plot
library(rgl)
plot3d(x=Girth, y=Height , z=Volume)


############################################################
#--------------------- Exporting Graphics------------------#
############################################################
# getwd()
# setwd("Output/")
# 
# tiff(filename='graphicExample.tiff')
# plot(rnorm(100))
# dev.off()
# 
# tiff(filename='graphicExample.tiff')
# plot(rnorm(100))
# boxplot(rnorm(100))
# dev.off() #Only the last plot is saved
# 
# tiff(filename='graphicExample%d.tiff') #Creates a sequence of files
# plot(rnorm(100))
# boxplot(rnorm(100))
# hist(rnorm(100))
# dev.off()
# 
# # Let's open several devices at a time:
# jpeg(filename='graphicExample.jpg')
# tiff(filename='graphicExample.tiff')
# pdf(file='graphicExample.pdf')
# 
# dev.list() #Returns a list of devices
# graphics.off()
# 
# pdf(file='graphicExample.pdf')
# plot(rnorm(100))
# boxplot(rnorm(100))
# hist(rnorm(100))
# plot(rnorm(100))
# boxplot(rnorm(100))
# hist(rnorm(100))
# dev.off()
# 
# # PDF supports transparancy!
# y <- 10*1:ncol(volcano)
# x <- 10*1:nrow(volcano)
# lev <- pretty(range(volcano), 10)
# 
# pdf(file='volcano.pdf', version='1.4')
# contour(x, y, volcano, levels = lev, lty="solid")
# image(volcano, col=heat.colors(10, alpha=0.6), add=T)
# dev.off()
# 
# image(volcano, col=heat.colors(10, alpha=0.6))
# 
# See ?pdf and ?jpef for more info.



#############################################################
#-----------Lattice Package (Deepayan Sarkar)---------------#
#############################################################
# Implemets Cleavland's Trellis framework
# Useful for visualizing a response conditional on other variables.
# Implemented on Paul Murrell *grid* engine.
# See ?Lattice for more information


# Univariate case:
stripplot(Volume ~ fac.Girth )
stripplot(~ Volume | fac.Girth)
stripplot(Volume ~ fac.Girth | fac.height)
stripplot(~ Volume | fac.Girth + fac.height)

histogram(~ Volume | fac.Girth)
histogram(~ Volume | fac.Girth + fac.height)

densityplot(~ Volume | fac.Girth)
densityplot(~ Volume | fac.Girth + fac.height)

boxplot(Volume ~ fac.Girth)
bwplot(~Volume | fac.Girth) 
bwplot(Volume~ fac.Girth | fac.height)

bwplot(Volume ~ fac.Girth | fac.height) #This is very hard in graphics package.

bwplot(Volume ~ fac.Girth | fac.height, layout=c(1,2))
bwplot(Volume ~ fac.Girth | fac.height, layout=c(2,1))

boxplot(Volume ~ fac.Girth + fac.height )
bwplot(Volume ~ fac.Girth + fac.height )
bwplot(Volume ~ fac.Girth | fac.height )
bwplot(Volume ~ fac.Girth | fac.height )
bwplot(~ Volume | fac.Girth + fac.height )# Not very informative...

# Multivariate Case:
moscaiplot

coplot(Volume ~ Girth | fac.height)
xyplot(Volume ~ Girth | fac.height)# lattice equivalent of graphics::coplot()
xyplot(Volume ~ Girth | fac.height, index.cond=list(c(2,1)), aspect=0.5 )

splom(~airquality[,1:3], groups = Month, data = airquality)
splom(~ airquality[,1:3] | Month , data = airquality)

# Trellis graphics are R objects!
my.xy<- xyplot(Volume ~ Girth | fac.height)# lattice equivalent of graphics::coplot()
my.box<- bwplot(Volume ~ fac.Girth | fac.height )

attributes(my.xy)
summary(my.xy)

print(my.xy, position=c(0,0.5,1,1),  more=T)
print(my.box, position=c(0,0,1,0.5))

# Notice the use of groups and a legend:
xyplot(Volume ~ Girth ,groups= fac.height, auto.key=T) 

# Plot annotation: (1) Using the panel function
# Most graphics:: functions have a panel equivalent named panel.foo
# Example: panel.xyplot(), panel.text(), panel.lines(), ...
xyplot(Volume ~ Girth | fac.height,  
		panel=function(x,y,...){
			panel.xyplot(x, y,...)			
			panel.text(x=15,y=60, 'Hurray!', cex=2)
			panel.abline(v=median(x), lty=2)
			panel.abline(h=median(y), lty=2)
			panel.rug(x=x)
			panel.rug(y=y) #Note the syntax is different then rug()
			panel.loess(x=x,y=y)
			panel.lmline(x=x,y=y, col=2)
		}) 

# Plot annotation: (2) Using trellis.focus() 
xyplot(Volume ~ Girth | fac.height) 
panel.text(x=10,y=60, 'Text!', cex=2)


xyplot(Volume ~ Girth | fac.height) 
trellis.focus('panel',1,1, highlight=T)
panel.text(x=10,y=60, 'Text!', cex=2)
trellis.focus('panel',2,1, highlight=T)
panel.loess(x=Girth,y=Volume)
trellis.unfocus()

panel.identify(Volume ~ Girth | fac.height)
# See ?trellis.focus for more help.



# Exporting graphics
getwd()
setwd('~/Projects/R Workshop/Graphic Examples')

tiff(filename='graphicExample.tiff')
xyplot(Volume ~ Girth | fac.height)
dev.off()
						

#############################################################
#------------------ggplot2 (Hadley Wickham)-----------------#
#############################################################
# ggplot2 easily creates stylish plots. 
# ggplot2 is a whole *grammer* for graphics.
# Might look wierd at first, but it gros on you :-)
# For more insformation see http://had.co.nz/ggplot2

# Diamonds example (Taken from Wickham's web site: http://had.co.nz/ggplot2/book)
require(ggplot2)
?diamonds
head(diamonds)

dsmall <- diamonds[sample(nrow(diamonds), 100), ]

rbind()

# qplot defaults to a histogram on a single continous variable
qplot(carat, data = dsmall)
qplot(carat, data = dsmall, binwidth = 1)
qplot(depth, data = dsmall, binwidth = 0.2)
qplot(depth, data = dsmall, binwidth = 0.2, fill = cut) + xlim(55, 70)

# Faceting is similar to lattice graphics
qplot(depth, data = dsmall) + facet_wrap(~ cut)

#qplot defaults to a scatter plot on two continous variables
qplot(carat, price, data = dsmall)
qplot(log(carat), log(price), data = dsmall)

qplot(carat, price, data = dsmall, colour = color)
qplot(carat, price, data = dsmall, shape = cut)

# Transparancy is unique (?) to ggplot2
qplot(carat, price, data = diamonds, alpha = I(1/10))
qplot(carat, price, data = diamonds, alpha = I(1/100))

# "geoms" controls the type of plot:
qplot(carat, price, data = dsmall, geom = c("point", "smooth"))
qplot(carat, price, data = diamonds, geom = c("point", "smooth")) # overlay is in order of appearance
qplot(carat, price, data = dsmall, geom = c("point", "smooth"),	span = 0.2) #each geom has its parameters
qplot(carat, price, data = dsmall, geom = c("point", "smooth"),	span = 1)

qplot(color, price / carat, data = diamonds, geom = "jitter")
qplot(color, price / carat, data = diamonds, geom = "boxplot")

# Varying transparency is useful:
qplot(color, price / carat, data = diamonds, geom = "jitter", alpha = I(1 / 5))
qplot(color, price / carat, data = diamonds, geom = "jitter", alpha = I(1 / 50))
qplot(color, price / carat, data = diamonds, geom = "jitter", alpha = I(1 / 200))

# Visualising a distribution
qplot(carat, data = diamonds, geom = "histogram")
qplot(carat, data = diamonds, geom = "density")

qplot(carat, data = diamonds, geom = "histogram", binwidth = 1,	xlim = c(0,3))
qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.1, xlim = c(0,3))

# Mapping a categorical variable to an aestethic:
qplot(carat, data = diamonds, geom = "density", colour = color)
qplot(carat, data = diamonds, geom = "histogram", fill = color)

# Bar plot:
qplot(color, data = diamonds, geom = "bar")

# Lines:
head(economics)

qplot(date, unemploy / pop, data = economics, geom = "line")# uempmed: median duration of unemplyment.
qplot(date, uempmed, data = economics, geom = "line")

#Paths
year <- function(x) as.POSIXlt(x)$year + 1900
qplot(unemploy / pop, uempmed, data = economics, geom = c("point", "path"))
qplot(unemploy / pop, uempmed, data = economics, geom = "path", colour = year(date)) + scale_area()

#2D histogram (a.k.a. Heatmap) tabulates and plots:
qplot(carat, data = diamonds, facets = color ~ ., geom = "histogram", binwidth = 0.1, xlim = c(0, 3))

qplot(carat,
		..density..,
		data = diamonds, 
		facets = color ~ .,
		geom = "histogram",
		binwidth = 0.1,
		xlim = c(0, 3)
)

qplot(carat, price, data = diamonds, geom = "bin2d", main='Count Heatmap')

# Anotating plots
qplot(carat, price, data = dsmall,  
		xlab = "Price ($)", ylab = "Weight (carats)",  
		main = "Price-weight relationship"
)

qplot(
		carat, price/carat, data = dsmall, 
		ylab = expression(frac(price,carat)), #note the use of an expression
		xlab = "Weight (carats)",  
		main="Small diamonds", 
		xlim = c(.2,1)
)

qplot(carat, price, data = dsmall, log = "xy") #logarithmic axes

# qplot actually wraps the building of several seperate layers:
layer(geom, geom_params, 		# what kind of drawing?
		stat,stat_params, 		# How to summarize the data?
		data, 					# Which data? 
		mapping, position) 		#Map variables to locations (scale), colors and shapes (aesthetics)

p <- ggplot(diamonds, aes(x = carat))
p <- p + layer(
		geom = "bar", 
		geom_params = list(fill = "steelblue"),
		stat = "bin",
		stat_params = list(binwidth = 2)
)
print(p)

d <- ggplot(dsmall, aes(x=carat, y=price)) #axes layer (where to plot?)
d + geom_point() #geom layer (what to plot?)
d + geom_point(aes(colour = carat)) #aesthetics layer (how to plot?)

# qplot does make life easier:
ggplot(msleep, aes(sleep_rem / sleep_total, awake)) + geom_point() # is equivalent to...
qplot(sleep_rem / sleep_total, awake, data = msleep)

#ggplot returns R objects with print and summary methods:
p <- ggplot(dsmall, aes(carat, price, colour = cut))
attributes(p)
print(p)
p <- p + layer(geom = "point")  
print(p)
summary(p)

# Original Data and mappings are used as default layers
p <- ggplot(dsmall, aes(x=price))
p + geom_histogram()
p + stat_bin(geom="area")
p + stat_bin(geom="point")
p + stat_bin(geom="line")
p + geom_histogram(aes(fill = clarity))

#Layers can be added to qplot as well:
qplot(sleep_rem / sleep_total, awake, data = msleep, geom = c("point", "smooth"))  
# Is equivalent to:
qplot(sleep_rem / sleep_total, awake, data = msleep) + 
		geom_smooth() # or
ggplot(msleep, aes(sleep_rem / sleep_total, awake)) + 
		geom_point() + geom_smooth()


# See how layers are updated:
p <- ggplot(msleep, aes(sleep_rem / sleep_total, awake))
summary(p)
p <- p + geom_point()
summary(p)



# To be continued....
