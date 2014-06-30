
#--------------------- Reshaping Data----------------------#
## Aggregating:

# By one variable:
aggregate(x=Loblolly$height, by=list(seed=Loblolly$Seed), FUN=mean )

# By two variables:
head(
  aggregate(x=Loblolly$height, 
            by=list(seed=Loblolly$Seed, 
                    age=cut(Loblolly$age,breaks=2)), 
            FUN=mean )
)


## Wide and Long formats:

# "Wide" format has it's advantages
head(WorldPhones)

mosaicplot(WorldPhones)
matplot(WorldPhones, type='l' )
dotchart(WorldPhones)

# "Long" format has it's own advantages
# Note: 
# R is much much much more friendly to "long" data.
# Especially when specifying models.

head(Loblolly)
coplot(height ~ age | Seed, data=Loblolly)
plot(height ~ age , col=as.numeric(Seed), data=Loblolly)

# Long to wide
library(reshape)

# First "melt" the data:
head(m.Lob<- melt(Loblolly, id=c('Seed','age')))
# Then "cast" it into wide format:
head(wide.lob<- cast(m.Lob, age~Seed))



# Wide to long
WorldPhones
head(long.phones<- melt(WorldPhones, varnames=c('Year','Continent')))
coplot(value ~ Year | Continent, data=long.phones)

# See ?melt for more information on reshaping data

# Note: This can also be done manually or using reshape() which I don't like...



#------------------ Manipulating Strings    ------------------------------#
print("Hello\n") 	# Wrong!
show("Hello\n") 	# Wrong!
cat("Hello\n")		# Right!


# String concatenation:
paste("Hello", "World", "!")
paste("Hello", "World", "!", sep="")
paste("Hello", " World", "!", sep="")

x <- 5
paste("x=", x)
paste("x=", x, paste="")

cat("x=", x, "\n") #Too many spaces :-(
cat("x=", x, "\n", sep="")

# Collapsing strings:
s <- c("Hello", " ", "World", "!")
paste(s)
paste(s, sep="")
paste(s, collapse="")
paste(s, collapse=" 1")


s <- c("Hello", "World!")
paste(1:3, "Hello World!")
paste(1:3, "Hello World!", sep=":")
paste(1:3, "Hello World!", sep=":", collapse="\n")
cat(paste(1:3, "Hello World!", sep=":", collapse="\n"), "\n") # cat() does not collapse :-(


# Substrings:
s <- "Hello World"
substring(s, first=4, last=6)

# Splits:
s <- "foo, bar, baz"
strsplit(s, ", ")

s <- "foo-->bar-->baz"
strsplit(s, "-->")

# Using regular expressions (see ?regexp):
s <- "foo, bar, baz"
strsplit(s, ", *")
strsplit(s, "")

# Looking in *vectors* of strings:
(s <- apply(matrix(LETTERS[1:24], nr=4), 2, paste, collapse=""))

grep("O", s) # Returns location
grep("O", s, value=T) # Returns value


regexpr(pattern="o", text="Hello")
regexpr(pattern="o", text=c("Hello", "World!"))

s <- c("Hello", "World!")
regexpr("o", s)
s <- c("Helll ooo", "Wrld!")
regexpr("o", s)

# Fuzzy (approximate) matches:
grep ("abc", c("abbc", "jdfja", "cba")) 	# No match :-(
agrep ("abc", c("abbc", "jdfja", "cba")) 	# Match! :-)

## Note: agrep() is the function used in help.search()
s <- "foo bar baz"
gsub(pattern=" ", replacement="", s)   # Remove all the spaces
s <- "foo  bar   baz"
gsub("  ", " ", s)
gsub(" +", "", s) # Using regular expression
gsub(" +", " ", s)  # Remove multiple spaces and replace them by single spaces

s <- "foo bar baz"
sub(pattern=" ", replacement="", s) # sub() only replaces first occurance.
gsub("  ", " ", s)




#------------------    Manipulating Time and Date    ------------------------------#

"2005-05-15" # Character string
as.Date("2005-05-15") #Date

# Formatting (see ?strftime):
as.Date("15/05/2005", format="%d/%m/%Y")
as.Date("15/05/05", format="%d/%m/%y")
as.Date("01/02/03", format="%y/%m/%d")
as.Date("01/02/03", format="%y/%d/%m")

# Date arithmetic:
a <- as.Date("01/02/03", format="%y/%m/%d")
b <- as.Date("01/02/03", format="%y/%d/%m")
a - b

#Today:
Sys.Date()
Sys.Date() + 21
format(Sys.Date(), format="%d%m%y")
format(Sys.Date(), format="%A, %d %B %Y")

# Sequence of dates (see ?seq.Date):
seq(as.Date("2005-01-01"), as.Date("2005-07-01"), by="month")
seq(as.Date("2005-01-01"), as.Date("2005-07-01"), by=31)
seq(as.Date("2005-01-01"), as.Date("2005-03-01"), by="2 weeks")

# Warning: loops turn dates to numbers!
a <- seq(as.Date("2005-01-01"), as.Date("2005-03-01"), by="2 weeks")
str(a)
for (i in a) {
   str(i)
 }
# Better try:
for (i in a){
  print(as.Date(i, origin=a[[1]]))
}

# Warning #2: indexing turns dates to numerics!

## For the complete time (not only date):
as.POSIXct("2005-05-15 21:45:17")
as.POSIXlt("2005-05-15 21:45:17")

# What's the difference?
unclass(as.POSIXct("2005-05-15 21:45:17")) # Compact inner representation
unclass(as.POSIXlt("2005-05-15 21:45:17")) # Non-Compact inner representation


# Arithmetics of times:
as.POSIXlt("2005-05-15 21:45:17") - Sys.time()
difftime(as.POSIXlt("2005-05-15 21:45:17"), Sys.time(), units="secs")

# See also "date", "chron", "zoo" packages.

# Leap seconds added (not to accumulate latencies)?
.leap.seconds




