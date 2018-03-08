setwd("~/git/studier/big_data_using_r")
rm(list=ls())
dev.off()

#Exercise 1
x = c(1, 2, 3, 4, 5, 2, 4, 3, 5, 1, 2, 3, 4, 5, 1, 2)
y = c("Red", "Green", "Blue", "Magenta")
y[x]
# The Number five will be N/A


#Exercise 2
A = matrix(c(1, 2, 3, 0, 1, 4, 5, 2, 4), nrow = 3, byrow = T)
B = matrix(c(2, 3, 0, -1, 2, 5, 3, 9, 2), nrow = 3, byrow = T)
C = A * B
C
# Element wise matrix multiplication

# Exercise 3
is.data.frame(state.x77)
ds = data.frame(state.x77)
is.data.frame(ds)
#Was not a dataset, but made it one

sum(ds["Income"] < 4000)
#13 states

head(ds[order(ds$Income, decreasing = TRUE),])
#Alaska has the highest income
