#page 3
u="http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"
wine <- read.csv(u)
colnames(wine) <- c("Cultivar","Alcohol","Malic.acid","Ash",
                    "Alcalinity.of.ash","Magnesium","Total.phenols","Flavanoids",
                    "Nonflavanoid.phenols","Proanthocyanins","Color.intensity","Hue",
                    "OD280.OD315.of.diluted.wines","Proline")
Wine <- wine[,-1] #exclude the first column
head(Wine,4)


#page 4
#install.packages("NbClust")
library(NbClust)
NbClust(Wine,method="complete",index="hartigan")$Best.nc
NbClust(Wine,method="complete",index="kl")$Best.nc

#page 5
library(cluster)
Gap <- clusGap(Wine, FUNcluster=pam, K.max=15)
Gap_df <- as.data.frame(Gap$Tab)
Gap_df

#page 6
library(ggplot2)
ggplot(Gap_df, aes(x=1:nrow(Gap_df))) +
  geom_line(aes(y=gap),color="red") +
  geom_point(aes(y=gap),color="red") +
  geom_errorbar(aes(ymin=gap-SE.sim,ymax=gap+SE.sim),color="red") +
  labs(x="Number of Clusters",y="Gap")

#page 9
library(NbClust)
n <- NbClust(mtcars,method="complete",index="hartigan")$Best.nc[1]
kc <- kmeans(mtcars, centers=n, nstart=4) #n=3
kc

#page 10
library(cluster)
clusplot(mtcars,kc$cluster,color=TRUE,shade=TRUE,labels=2)

#page 12
dst <- as.matrix(dist(mtcars))
sobj <- silhouette(kc$cluster, dmatrix=dst)
summary(sobj)
plot(sobj, col=2:4)

#page 13
library(cluster)
pamx <- pam(mtcars, 3)
summary(pamx)

#page 14
plot(pamx)

#page 15
library(cluster)
clx3 <- clara(xclara, 3, samples=100)

#page 16
#install.packages("factoextra")
library(factoextra)
fviz_cluster(clx3, geom = "point", frame.type = "norm")

#page 18
library(NbClust)
NbClust(USArrests, method="complete", index="hartigan")$Best.nc

#page 19
ds <- dist(USArrests, method="euclidean")
hcst <- hclust(ds,method="complete")
plot(hcst, labels=rownames(USArrests), cex=0.8)
rect.hclust(hcst, 3)

#page 20
cn <- cutree(hcst, k=3)
cn
table(cn) 
aggregate(USArrests,FUN=mean, by=list(cn))

#page 21
ds <- dist(USArrests, method="euclidean")
library(cluster)
pamd = pam(ds, 3)
plot(pamd)

#page 22
sobj = silhouette(pamd)
plot(sobj, col=2:4)
