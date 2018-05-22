# Exercise 11

# Assignment 1-a
library(rpart)
?cu.summary
head(cu.summary)
length(cu.summary)

tree <- rpart(Mileage~Price+Country+Reliability+Type, data=cu.summary, method='anova')

# Assignment 1-b
tree
library(partykit)
plot(as.party(tree))
# Price and Type are used to explain Milage

# Assignment 1-c
# The cheapest cars, has the highest Milage no matter the type. (they are all small, sporty and compact though)
# Cars of types Large, Van and Medium have the worst milage
# Cars of type Small, Sporty and Compact that are cheaper, have worse Milage

# Assignment 2-a
tree <- rpart(Kyphosis~Age+Number+Start, data=kyphosis, method='class')
tree2 <- partykit::ctree(Kyphosis~Age+Number+Start, data=kyphosis)

# Assignment 2-b
tree
plot(as.party(tree))

tree2
plot(tree2)
# Start and Age are used to explain Kyphosis presence with rpart

# Only start is used to explain Kyphosis presence with ctree

# Assignment 2-c
# This is the explanation when creating the tree using rpart
# The lower the number where surgery started (Start), the higher the probability of kyphosis being preset after operation
# The higher the age, the higher the probability of kyphosis being present after surgery. No presence if age is lower than 55






