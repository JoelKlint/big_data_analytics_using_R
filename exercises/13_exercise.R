# Exercise 13

# Assignment 1-a
data(toothpaste, package='HSAUR3')
library(NbClust)
n <- NbClust(toothpaste,method="complete",index="hartigan", max.nc=4)$Best.nc[1]; n
toothpaste.cl <- kmeans(toothpaste, centers=2, nstart=4)
library(cluster)
clusplot(toothpaste, toothpaste.cl$cluster, color=TRUE, shade=TRUE)

# Assignment 1-b
toothpaste.dst <- as.matrix(dist(toothpaste))
sobj <- silhouette(toothpaste.cl$cluster, dmatrix=toothpaste.dst)
summary(sobj)
plot(sobj, col=2:4)


# Assignment 2
protein <- read.csv('~/Desktop/R-input.csv', sep=';', header=TRUE, row.names = 1)

# Assignment 2-a
protein.cl <- kmeans(protein, centers=2, nstart=4)

# Assignment 2-b
protein.dst <- as.matrix(dist(protein))
library(cluster)
sobj <- silhouette(protein.cl$cluster, dmatrix=protein.dst)
summary(sobj)
plot(sobj, col=2:4)

# Assignment 2-c
# One cluster has silhouette value 0.54
# The other cluster has silhouette value 0.29 which is very low
# Average silhouette value is 0.42 < 0.45 < 0.51 --> The structure is weak and could be artificial

# Assignment 2-d
ds <- dist(protein, method="euclidean")
hcst <- hclust(ds,method="complete")
plot(hcst, labels=rownames(protein), cex=0.8)
rect.hclust(hcst, 3)

