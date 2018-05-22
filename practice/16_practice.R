# === (16) Principle Component Analysis === #

#page 3
edat17 <- read.csv('index2017_data.csv', header=TRUE)
names(edat17)

#page 4
edat <- edat17[,-c(1:2)] #exclude 1:2 columns
str(edat)
for(i in c(1:4,7:10))
  edat[,i] <- as.numeric(edat[,i])

#page 5
# install.packages("rela")
library(rela)
paf_dat <- paf(as.matrix(edat))
paf_dat$KMO

#page 6
paf_dat$Bartlett
library(psych)
pcacor <- cor(edat)
cortest.bartlett(pcacor, n=186)

#page 7
det(pcacor)

#page 8
library(psych)
scree(edat, factors=FALSE, pc=TRUE)

#page 9
nc <- dim(edat)[1]
#fm="pa": principal factor solution
#fa="pc": principal components
fa.parallel(edat,n.obs=nc, fm="pa", fa="pc")
abline(h=1, col="grey")

#page 10
library(psych)
pca <- principal(edat, nfactors=2, rotate='none')
pca

#page 12
alpha(pcacor)

#page 13
pca$communality #h2

#page 14
library(psych)
pca <- principal(edat, nfactors=2, rotate='none')
biplot.psych(pca, col=c("black","red"), cex=c(0.5,1), arrow.len=0.08,
             main=NULL, labels=edat17[,1])

#page 15
##  2016 USA President Election
# Data Source for Final vote count
# https://en.wikipedia.org/wiki/United_States_presidential_election,_2016
dat <- read.csv("USA2016PresidentElection.csv",header=T)
head(dat,4)
xd <- dat[,-c(1,4,5)] #exclude state names
library(psych)
pcusa <- principal(xd, nfactors=2, rotate="none")
pcusa$loadings

par(bg="cornsilk")
biplot(pcusa,col=c("black","blue"),
       cex=c(1,0.2),arrow.len=0.08,
       labels=dat[,1],main="")


#page 17
library(ca)
data(smoke)
smoke

#page 18
smoke_ca <- ca(smoke)
names(smoke_ca)
summary(smoke_ca)

#page 19
library(factoextra)
get_eigenvalue(smoke_ca)

#page 20
plot(smoke_ca, mass=TRUE, contrib="absolute",
     map="rowgreen", arrows=c(FALSE, TRUE))
