# Exercise 15

# Assignment 1-1
library(rela)
data(attitude)

paf.dat <- paf(as.matrix(attitude))
paf.dat$KMO
# KMO = 0.76328
paf.dat$Bartlett
# Bartlett chi-square = 98.753
library(psych)
pcacor <- cor(attitude)
det(pcacor)
# Determinant = 0.021869

# Assignment 1-2
scree(attitude, factors=FALSE, pc=TRUE)
# Two components has eigenvalues > 1.0

# Assignment 1-3
pca <- principal(attitude, nfactors=2, rotate='none'); pca
# Y1 = 0.8*rating + 0.85*complaints + 0.68*privileges + 0.83*learning + 0,86*raises + 0.36*critical + 0.58*advance
# Y2 = -0.42*rating + -0.36*complaints + -0.1*privileges + -0.05*learning + 0.19*raises + 0.64*critical + 0.61*advance

# Assignment 1-4
fa.diagram(pca)



