## From http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html
library(dplyr)
library(hflights)
dim(hflights)
head(hflights)

hflights_df <- tbl_df(hflights)
hflights_df

### Filter:
## Subset rows:
filter(hflights_df, Month == 1, DayofMonth == 1)
# Equivalent expression
hflights[hflights$Month == 1 & hflights$DayofMonth == 1, ]

## Boolean operators
filter(hflights_df, Month == 1 | Month == 2) # is actually...
filter(hflights_df, ...=Month == 1 | Month == 2)


### Arrange:
## Sort along selected variables:
arrange(hflights_df, DayofMonth, Month, Year)
# Equivalent:
hflights[order(hflights$DayofMonth, hflights$Month, hflights$Year), ]


# Descending order:
arrange(hflights_df, desc(ArrDelay))
# The same with the original data.frame (slow printing)
arrange(hflights, desc(ArrDelay))


### Select:
## Selecting a column subset:
select(hflights_df, Year, Month, DayOfWeek)
# Equivalent:
select(hflights_df, ...=list(Year, Month, DayOfWeek))

# Select range of columns:
select(hflights_df, Year:DayOfWeek)

# Remove range of columns:
select(hflights_df, -(Year:DayOfWeek))

# Compute/recode with mutate():
mutate(hflights_df,
       gain = ArrDelay - DepDelay,
       speed = Distance / AirTime * 60)

# Unlike base::transform() and base::within(), new columns can be referenced:
mutate(hflights_df,
       gain = ArrDelay - DepDelay,
       gain_per_hour = gain / (AirTime / 60)
)
transform(hflights,
          gain = ArrDelay - DepDelay,
          gain_per_hour = gain / (AirTime / 60)
)
within(hflights,
          gain = ArrDelay - DepDelay,
          gain_per_hour = gain / (AirTime / 60)
)



### Summarise:
summarise(hflights_df, delay = mean(DepDelay, na.rm = TRUE))
summarise(hflights_df, delay = length(DepDelay))

#Error:
summarise(hflights_df, delay = range(DepDelay))






### Groupby:
planes <- group_by(hflights_df, TailNum)
class(planes)
length(planes)
names(planes)

# Compute several descriptive statistics:
delay <- summarise(planes,
                   count = n(),
                   dist = mean(Distance, na.rm = TRUE),
                   delay = mean(ArrDelay, na.rm = TRUE))
delay <- filter(delay, count > 20, dist < 2000)

library(ggplot2)
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()


# Several new summary functions:
destinations <- group_by(hflights_df, Dest)
summarise(destinations,
          planes = n_distinct(TailNum),
          flights = n(),
          first=first(TailNum)
)


# Aggregate by undoing a grouping:
daily <- group_by(hflights_df, Year, Month, DayofMonth)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))



### Piping:
# No piping no.1:
a1 <- group_by(hflights, Year, Month, DayofMonth)
a2 <- select(a1, Year:DayofMonth, ArrDelay, DepDelay)
a3 <- summarise(a2,
                arr = mean(ArrDelay, na.rm = TRUE),
                dep = mean(DepDelay, na.rm = TRUE))
a4 <- filter(a3, arr > 30 | dep > 30)

# No piping no. 2:
filter(
  summarise(
    select(
      group_by(hflights, Year, Month, DayofMonth),
      Year:DayofMonth, ArrDelay, DepDelay
    ),
    arr = mean(ArrDelay, na.rm = TRUE),
    dep = mean(DepDelay, na.rm = TRUE)
  ),
  arr > 30 | dep > 30
)

# With piping:
hflights %>% # send data
  group_by(Year, Month, DayofMonth) %>% # then group by 
  select(Year:DayofMonth, ArrDelay, DepDelay) %>% # then subset columns
  summarise( # then computa summaries
    arr = mean(ArrDelay, na.rm = TRUE),
    dep = mean(DepDelay, na.rm = TRUE)
  ) %>% # then subset rows
  filter(arr > 30 | dep > 30)




## From http://fishr.wordpress.com/2014/04/17/dplyr-example-1/
library(dplyr)
if (!require('devtools')) install.packages('devtools')
require('devtools')
devtools::install_github('FSAdata','droglenc')
library(FSAdata)
library(plotrix)

data(RuffeSLRH92)
str(RuffeSLRH92)

# Remove columns:
RuffeSLRH92 <- select(RuffeSLRH92, -fish.id, -species, -day, -year)
head(RuffeSLRH92)

# Subset columns:
ruffeLW <- select(RuffeSLRH92, length, weight)
head(ruffeLW)

# Column subset by string:
ruffeL <- select(RuffeSLRH92, contains("l"))
str(ruffeL)

# Row subset:
male <- filter(RuffeSLRH92,sex=="male")
xtabs(~sex,data=male)
# Update the factor that now has fewer levels:
male <- droplevels(male)
xtabs(~sex,data=male)

# Compound subsetting:
maleripe <- filter(RuffeSLRH92, sex=="male", maturity=="ripe")
xtabs(~sex+maturity,data=maleripe)

maleripe2 <- filter(RuffeSLRH92,sex=="male" | maturity=="ripe")
xtabs(~sex+maturity,data=maleripe2)


### Arrange:
# Sort along "length" variable:
malea <- arrange(male, length)
head(malea)
maled <- arrange(male,desc(length))
head(maled)

# Sort along two variables:
ruffe2 <- arrange(RuffeSLRH92, length, weight)
head(ruffe2)


### Mutate:
ruffeLW <- mutate(ruffeLW, logL=log(length), logW=log(weight))
head(ruffeLW)

### group_by:
byMon <- group_by(RuffeSLRH92,month)
( sumMon <- summarize(byMon, 
                      count=n(),
                      sum=sum()) )



### Piping:
RuffeSLRH92 %.% # send data:
  group_by(month) %.% # then group by month
  summarize(n=n()) %.% # the count rows per group
  mutate(prop.catch=n/sum(n)) %.% # then compute proportions
  arrange(desc(prop.catch)) # then return in descending order

