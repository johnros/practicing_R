###########################################################################

c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21)
10:21 							
seq(from=10, to=21, by=1) 							
seq(from=10, to=21, by=2) 								
x<-c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21) # Will only assign (silent) 	
x
(x<-c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21)) # Will assign and print

# Non standard assignments (We will not be using them in this lifetime)
c(1,2,3) ->y ; y
assign('y', c(1,2,3) ); y
assign('y', c(1,2,3), env=.GlobalEnv )

# You can assign AFTER the computation is finished:
c(1,2,3)
y<- .Last.value 
y

# Operations usually work element-wise:
x+2     
x*2    
x^2    
sqrt(x)  
log(x)   
###########################################################################

##vector (numeric)

x<-c(2,4,6,8,10,12,14,16,18)
x
x<-seq(0,5,by=0.1)
x
x<-seq(0,5,length=100)
x
class(x)

##logical ( T / F )

TRUE
T
FALSE
F
a<-T
a
b<- 1 == 0 # Notice operators precedence
b
c<- 1 < 4
c
class(c)

b+c # Acts a OR
c*9 # Acts as numeric

x<-c(11,12,13,14,15,16)
x
x[c(T,F,F,T,F,T) ]
x[c(1,0,0,1,0,1)] # 1 is not TRUE!
x[as.logical( c(1,0,0,1,0,1))]

##character
a<-2010
t<-a
t
t<-"a"
t

x<-c("a","b","c","d")
x
month.name
letters
LETTERS
x<-month.name
x
class(x)

x<-c("a","a","a","a","b","b","c","c","c","d","d","e","e")
x
table(x)

##factor (Most relevant when specifying statistical models)
x.f<-factor(x)
x.f
x.f<-factor(x, labels = c("Num1","Num2","Num3","Num4","Num5") )
x.f

##list objects:
name<-c("a","b","c")
month<-c(11,3,7)
(number.a<-round( rnorm(n=10, mean=0, sd=1) , digits = 2))
(number.b<-round( rnorm(n=10, mean=0, sd=1) , digits = 2))
(number.c<-round( rnorm(n=10, mean=0, sd=1) , digits = 2))

(list.a<-list( name[1] , month[1] , number.a ))
(list.b<-list( name[2] , month[2] , number.b ))
(list.c<-list( name[3] , month[3] , number.c ))

(data<-list(A = list.a, B=list.b , C=list.c))

# Extracting from list objects:
data[[1]]
data$A
data$A[[3]]
data$A[[3]][1]
data$A[[3]][1:5]
data[1:2]

mean(data$A[[3]])

##matrix objects
mat1<-matrix(data = c(seq(1,7),1,1)  , ncol=3)
mat1
mat2<-matrix(c(1:4,-5:2),nrow=3)
mat2

edit(mat1)
mat1<-edit(mat1)
fix(mat1) 

mat1 %*% mat2

solve(mat1)

eigen(mat1)

eigen(mat1)$v
eigen(mat1)$va
eigen(mat1)$ve

##data.frame
A<-as.data.frame(mat1)
B<-as.data.frame(mat2)
A;B
A %*% B  ## Error
x<-c(1,2,3,4)
n<-c("H","I","J","K")
q<-c(0,0.33,0.66,1)
x;n;q

data.frame(x,n,q)

x<-c("a","b","c")
B
B<-cbind(B,x)
B

A<-rbind(A,x)
A

x<-c("a",1,2,3,4,5,6,7,8,9,10)
x
y<-c("151","143","176","187","651","311")
y
class(y)
mean(y)   ## NA

y<-as.numeric(y)
y
mean(y)

a<-c(1,2,3,4,5,6,7,8,9,10)
b<-c(5,32,5,7,2,4,5,6,7,8)
c<-c(5,1,4,10,7,2,6,8,9,3)
ord<-data.frame(a,b,c)
ord

ord$c
ind <- order( ord[,3] )
ord[ ind, ] 


x<-c(0,1,2,3,4)
class(x)
as.factor(x)
as.list(x)
as.character(x)
as.logical(x)

###########################################################################

## Adding columns:
days<-c(31,28,31,30,31,30,31,31,30,31,30,31)
head(data<-data.frame(Number=1:12 , month.name , month.abb))
head(data<- cbind( data , days ))


## Subsetting & Indexing:
subset(data, days==31)
subset(data, days==31, select=month.name )

subset(data, days!=31 & Number >= 6 , select=  -month.abb )

J1<-round( rnorm(9,100,25) , digits=2)
F1<-round( rnorm(9,100,25) , digits=2)
M1<-round( rnorm(9,100,25) , digits=2)
J1;F1;M1

J2<-T
F2<-T
M2<-F
J2;F2;M2


J<- list(Numbers= J1, Logic = J2, Day =days[1])
F<- list(Numbers= F1, Logic = F2, Day =days[2])
M<- list(Numbers= M1, Logic = M2, Day =days[3])
J
J$Numbers
J$Day

tbl<- list(Jan = J,Feb = F,Mar = M)

tbl
tbl$Jan$Day
tbl[[1]][[3]]

sum(tbl$Jan$Numbers)

data<- data.frame ( jan = tbl$J$N, feb = tbl$F$N, mar = tbl$M$N)
data
class(data[,1])

class(data)

min(data)
max(data)

#---------------------------
plot(data[,1], type="l")
plot(data[,2], type="l")

plot(data[,1], 	type="b")
lines(data[,2],	type="b"	,col=2)
lines(data[,3], 	type="l"	,col=3)
#---------------------------
###########################################################################

## Loops
i<-1
i*2
for (i in 1:5)
{
	i*2
}

for (i in 1:5)
{
	print(i*2)
}

num<-0
while (num<10) {
	num <- runif(n=1, min= 0, max= 12)
	print(num)
}

i<-0; j<-1
while (i<10)
{
	i <- i+1
	j <- j*2
}
i;j

data
t<-0
for (i in 1:9)
{
	if (data[ i ,1] > mean(data[,1])) 
	{
		t <- t + data[ i , 1 ]
	} 
	else	{break}
}
t
mean(data$jan)

dim(data)
dim(data)[1]
n<- dim(data)[1]

plot(as.numeric(data[1,]),ylim=c(min(data),max(data)) )
for (i in 2:n)
	lines(as.numeric ( data[ i , ]) , col=i , type="p")

###########################################################################
months<-month.name
tbl2<-data.frame(month=months,val=rnorm(12))
tbl2

library(car)
#	-10 :-0.5      -->  1 
#	-0.5: 0         -->  2  
#	 0  : 0.5	       -->  3 
#	 0.5: 10        -->  4


gr<-recode (tbl2$val , " -10:-0.5 =1; -0.5:0 = 2; 0:0.5 =3; 0.5:10=4 ")
gr

tbl2<- cbind(tbl2,group=gr)
tbl2

##switch

switch(3 ,	  "a","b","c","d","e","f","g")

tbl
tbl$J
tbl[[1]]

for (i in 1:3)
{	
	s<-tbl[[i]]$Num
	print(s)
	print(  switch( i , quantile(s, 0.33) ,quantile(s, 0.667) ,quantile(s, 1)  )    )
}



###########################################################################

##  Functions

sum.for<-function(val , data )
{
	t<-0
	for (i in 1:9)
	{
		if (data[ i ,1] > val) 
		{
			t<-t+data[ i ,1]
		} 
		else	{break}
	}
	return(t)
}

sum.for( 90 ,data ) 










f1<-function(x)
{
	if (  identical(  x,sort(x)  )  ) return ( mean(x) )
	quant<-quantile(x, seq(0,1,by=0.25))
	E<-mean(x)
	V<-var(x)
	y<-list(mean= E, var = V, q=quant)
	return(y)

}

f1(c(1,2,3,4,5,6))
f1(rnorm(10000))


f2<-function(a,b,c)
{
	SU<-a+b+c
	MU<-a*b*c
	if ( MU < SU ) {
		print("SU>MU")
		return(SU)
	}
	else {
		print("MU>SU")
		return(MU)
	}	
}

f2(1,1,1)
f2(9,1,2)

debug(f2)
f2(1,1,1)
undebug(f)


rm(V)
rm(y)
g<-function(x)
{
	if ( identical(x,sort(x) )) return (mean(x))
	
	quant<-quantile(x, seq(0,1,by=0.1))
	E<-mean(x)
	browser()  #-------------------------------------------#
	V<-var(x)
	y<-list(mean= E, var = V, q=quant)
	return(y)
}

g(rnorm(100))
E
quant
V


g2<-function(x)
{
	if ( identical(x,sort(x) )) return (mean(x))
	
	quant<-quantile(x, seq(0,1,by=0.1))
	E<-mean(x)
	V<-var(x)
	y<-list(mean= E, var = V, q=quant)
	return(y)
}


debug(g2)
g2( rnorm(100) )
undebug(g2)


