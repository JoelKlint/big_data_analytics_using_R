# Exercise 18

library(statnet.common); library(ergm)
data(faux.magnolia.high)
fmh <- faux.magnolia.high
summary(fmh)

plot.network(fmh, displayisolates=F,
             vertex.col="Race")
legend("topright",fill=1:6,
       legend=paste("Race", 1:6),
       cex=0.8,bty="n")
