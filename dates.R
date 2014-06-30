####----------------    Manipulating Time and Date    -----------------------------####

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



#### ------------lubridate ------------####
#From: http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/

library(lubridate)
# Format date:
ymd("20110604")
mdy("06-04-2011")
dmy("04/06/2011")

# Format date and time:
arrive <- ymd_hms("2011-06-04 12:00:00", tz = "Pacific/Auckland")
leave <- ymd_hms("2011-08-10 14:00:00", tz = "Pacific/Auckland")

# Extracting info:
second(arrive)
second(arrive) <- 0
wday(arrive)

# Manipulating time zones:
meeting <- ymd_hms("2011-07-01 09:00:00", tz = "Pacific/Auckland")
# Convert to a different time zone:
meeting
with_tz(meeting, "America/Chicago")
meeting-with_tz(meeting, "America/Chicago")


# Time intervals:
auckland <- interval(arrive, leave) 
auckland
# Same with %--% operator:
auckland <- arrive %--% leave
auckland


#Intervals over different time zones:
(jsm <- interval(ymd(20110720, tz = "Pacific/Auckland"), ymd(20110831, tz = "Pacific/Auckland")))

# Test for overlap:
int_overlaps(jsm, auckland)


## Arithmetic:
minutes(2) # period. 
dminutes(2) # duration. More reliable.

# Reliability of arithmetic to leap year (additional day)
leap_year(2011)
ymd(20110101) + dyears(1)
ymd(20110101) + years(1)

leap_year(2012)
ymd(20120101) + dyears(1)
ymd(20120101) + years(1)


## Testing using %within% operator:
meetings <- meeting + weeks(0:5)
meetings %within% jsm


## Unit change:
auckland / edays(1)
auckland / edays(2)
auckland / eminutes(1)

## Modulo:
auckland %/% months(1)
auckland %% months(1)

