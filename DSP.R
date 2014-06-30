############################################################
#--------------- DSP; One dimentional signal---------------#
############################################################

#----------- Fourier Baby! -----------------#
(x<- seq(0,2*pi, length=100))
signal<- rep(1,length(x))
plot(signal~x, type='l')
plot(abs(fft(signal)), type='h')

signal<- Re(exp(-1i*x*2))
plot(signal~x, type='l')
plot(abs(fft(signal)), type='h')

#----------- Nyquest -----------------#
signal<- Re(exp(-1i*x*))
plot(signal~x, type='l')
plot(abs(fft(signal)), type='h')

#--------------- Noisy signal-------------#
signal<- Re(exp(-1i*x*4))+rnorm(length(x), sd=0.5)
plot(signal~x, type='l')
plot(abs(fft(signal)), type='h')

# Low pass filter:
oldSpectrum<- fft(signal)
filteredSpectrum<- oldSpectrum * c(rep(1,length(x)/4),rep(0,length(x)*3/4))
plot(abs(filteredSpectrum), type='h')
plot(fft(filteredSpectrum, inv=TRUE)~x, type='l')

#-------------- Discrete Cosine Transform------------#
install.packages('dtt')
library(dtt)
plot(abs(dct(signal)), type='h')

#-------------- Discrete Hartley Transform ----------------#
plot(abs(dht(signal)), type='h')

#------------- Moving Average--------------#
plot(filter(signal, rep(1,3)/3, method='convolution')~x) # Window of size 3
lines(signal~x, col='grey')

#---------- Gaussian Kernel-----------#
plot(filter(signal, dnorm(-2:2), method='convolution')~x) 
lines(signal~x, col='grey')

#---------- Runnig median---------#
plot(smooth(signal)~x, type='l') 
lines(signal~x, col='grey')


#---------- Wavelet Transform-----------#
install.packages('wavelets')
library(wavelets)
signalWT<-dwt(signal)
plot(signalWT)
	
RSiteSearch('wavelet') # For help on threshing coeffieicnts

#----------- LOESS------------#
## TODO: A) Fix prediction scale
plot(predict(loess(signal~x, degree=2, span=0.3))~x, type='l')
lines(lty=2, signal~x, col='grey')


#------------- I/O of wave fils---------------#
install.packages('tuneR')
Wobj <- sine(440, bit = 16)
str(Wobj)

readWave(filename)
writeWave(object, filename)

# See package "seewave" for more datails.

############################################################
#--------------- DSP; Two dimentional signal---------------#
############################################################

example(image)

setRepositories()
install.packages('EBImage')
library(EBImage)
library(lattice)

f <- system.file("images","lena.gif", package="EBImage")
lena <- readImage(f)
display(lena)
#writeImage(lena, 'lena.jpeg', quality=95)
#image(lena)
dim(lena)
class(lena)

lenac <- readImage(system.file("images", "lena-color.png", package="EBImage"))
display(lenac)

nuc <- readImage(system.file('images', 'nuclei.tif', package='EBImage'))
display(nuc)


display(lena+0.5)
display(3*lena)
display((0.2+lena)^3)
display(lena[299:376, 224:301])
display(lena>0.5)
display(t(lena))

print(median(lena))

display(rotate(lena, 30))
display(translate(lena, c(40, 70)))
display(flip(lena))


# Blur filter
flo <- makeBrush(21, shape='disc', step=FALSE)^2
levelplot(flo <- flo/sum(flo))
display(filter2(lenac, flo))

# Gradient filter
(fhi <-  matrix(1, nc=3, nr=3))
fhi[2,2] <- -8
display(filter2(lenac, fhi))

# Morphological transformations
ei <- readImage(system.file('images', 'shapes.png', package='EBImage'))
ei <- ei[110:512,1:130]
display(ei)

levelplot(kern <- makeBrush(5, shape='diamond'))
display(erode(ei, kern))
display(dilate(ei, kern))

