# Exercise 1
library(data.table)
# I do not understad which column you want me to sort on, so I chose ORIGIN
flights_dt <- fread("flights_sep_oct15.csv", header=TRUE)
flights_dt[order(ORIGIN)]

# Exercise 2
Delay <- function(DT) {
  DT[, Total_Delay := ARR_DELAY - DEP_DELAY]
  DT[, .(Mean_Delay = mean(Total_Delay, na.rm=TRUE)),
     by=DAY_OF_MONTH][order(DAY_OF_MONTH)]
}

Delay(flights_dt)

# Exercise 3
library(bit64)
# Integer can not be larger than .Machine$integer.max
# As R can not handle integeres larger than 32 bits, this is impossible.
# But I can create an 64 bit integer with an external library
as.integer64(2^60)
