
# For a complete review see:
# http://cran.r-project.org/doc/manuals/R-data.html
# or 
# "Import and Export Manual" in help.start()
#  Whenever possible, try using .csv format!

# ------------- On-line files--------------#

web.data<- read.table('http://www-stat.stanford.edu/~tibs/ElemStatLearn/datasets/bone.data', 
	header=T)
# web.data<- read.table(file='webdata.txt')

web.data
head(web.data)
tail(web.data)
View(web.data) 
fix(web.data) 

?read.table # Get help on importing options

# Note: if the data has a header, use header=TRUE switch of read.table() and read.csv()


# --------------- Local .csv file------------#

# Note:
# R is portable over platforms but *path specification* differs.
# This means import functions are *platform depedant*.
# The directories in this will will need to be adapted to the local machine.

getwd()
setwd('~/Dropbox/Maccabi Workshop/')
women<- read.csv(file='what women want.csv')

# --------------Local txt file ------------#

# Same operation. Different syntax.
women<- read.table(file='C:\\Documents and Settings\\Jonathan\\My Documents\\R Workshop\\what women want.txt')

#-----------Writing Data------------------#

#What is the working directory?
getwd() 
#Setting the working directory 
setwd('/Documents and Settings/Jonathan/My Documents/Dropbox/Maccabi Workshop/') 


write.csv(x=women,
		file='write_women.csv',
		append=F,
		row.names=F		
		)

?write.table


#---------------.XLS files-------------------#

# Strongly recommended to convert to .csv
# If you still insist see:
# http://cran.r-project.org/doc/manuals/R-data.html#Reading-Excel-spreadsheets



#------------- SAS XPORT files--------------#

#See read.xport in package "foreign"

install.packages('foreign')
library(foreign)
?read.xport

#--------------SPSS .sav files-----------#

#See read.spss in package "foreign"

install.packages('foreign')
library(foreign)
?read.spss


#------------------- MASSIVE files-----------------#

# scan() is faster then read.table() but less convenient:

start<- proc.time() #Initializing stopper
A<- read.table('matrix.txt', header=F)
proc.time()-start #Stopping stopper

dim(A)

start<- proc.time()
A <- matrix(scan("matrix.txt", n = 20*2000), 20, 2000, byrow = TRUE)
proc.time()-start

# On Linux/Mac differences are less notable.

#----------------MySQL-----------------#

# MySQL is the best integrated relational database.
# This is done with package RMySQL
# Here is an example assuming you have a MySQL server setup with a database named "test".

install.packages('RMySQL')
library(RMySQL) # will load package DBI as well

# open a connection to a MySQL database names "test".
con <- dbConnect(dbDriver("MySQL"), dbname = "test")
## list the tables in the database
dbListTables(con)
## load a data frame named "USAarrests" into database "test", deleting any existing copy
data(USArrests)
dbWriteTable(con, "arrests", USArrests, overwrite = TRUE)

## get the whole table
dbReadTable(con, "arrests")

## Send SQL query to database
dbGetQuery(con, 
		paste("select row_names, Murder from arrests",
				"where Rape > 30 order by Murder"))


dbRemoveTable(con, "arrests") #Removed the table "arrests" from database "test"
dbDisconnect(con) #Closes the connection to database "test"

# For more information see:
# http://cran.r-project.org/doc/manuals/R-data.html#Relational-databases




#-------------- HTML & XML Parsing -----------#
# Note: installing scapeR will require libxml.
install.packages('XML')
install.packages('scrapeR')
library(scrapeR)
[To Be Completed]

