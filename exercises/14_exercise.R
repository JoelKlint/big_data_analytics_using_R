# Exercise 14

# Assignment 1-a
library(arules)
data(Adult)
itemFrequencyPlot(Adult, topN=12, type="relative")

# Assignment 1-b
library(arulesViz)
rules <- apriori(Adult, parameter=list(support=0.1, confidence=0.8, maxlen=10)); rules
rules.sorted <- sort(rules, by='support', decreasing = TRUE)
plot(rules.sorted[1:12], method="graph", measure='confidence', shading='lift', 
     control=list(type='items'))
# We observe that sex and relationship are not included in the top rules
# We observe that the strongest rules for capital gains and loss is with native country and race

# Assignment 1-c
library(dplyr)
data("AdultUCI")
classes <- AdultUCI %>% 
  filter(age <= 45 & age >= 26) %>%
  select(workclass)

table(classes)
# Based on the counts, the probability is 0.743083004
