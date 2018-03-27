# === (6) Unleashing the Power of R === #

#page 6
install.packages("data.table")
library(data.table)

#page 15
system.time(flights_dt <- fread("flights_sep_oct15.csv", header=TRUE))
pivot <- dcast.data.table(flights_dt,
                          UNIQUE_CARRIER~MONTH,
                          fun.aggregate=mean,
                          value.var="ARR_DELAY", na.rm=TRUE)

flights_dt[, sum(ARR_DELAY > 120, na.rm=TRUE)]
st <- flights_dt[, c("SPEED", "TOTAL_DELAY") := .(DISTANCE/AIR_TIME, ARR_DELAY-DEP_DELAY) ]
smo.dt <- flights_dt[, 
                     .(SumCancel=sum(CANCELLED), MeanArrDelay=mean(ARR_DELAY, na.rm=TRUE)), 
                     by=ORIGIN_CITY_NAME]

pivot <- dcast.data.table(flights_dt, 
                          UNIQUE_CARRIER~MONTH,
                          fun.aggregate=mean,
                          value.var="ARR_DELAY", na.rm=TRUE
                          )

#page 16
names(pivot) <- c("Carrier","September","October")
y=rbind(pivot$September,pivot$October)
color=c("magenta","cyan")
barplot(y,beside=TRUE,names.arg=pivot$Carrier,col=color,
        xlab="UNIQUE_CARRIER",ylab="Mean(ARR_DELAY)")
legend("topleft",fill=color,legend=names(pivot[,2:3]),
       title="Month")

#page 17
pvs <- dcast(flights_dt, UNIQUE_CARRIER~MONTH,
             fun.aggregate=mean, value.var="ARR_DELAY",
             subset=.(DEP_DELAY > 0), na.rm=TRUE)

#page 21
install.packages("parallel")

library(parallel)
install.packages("snow")
library(snow)