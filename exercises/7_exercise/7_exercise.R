# Assignment 1a
radio_preferences = matrix(c(14, 10, 3, 4, 15, 11, 7, 9, 5), nrow=3, byrow=TRUE)
rownames(radio_preferences) = c("Music", "News", "Sports")
colnames(radio_preferences) = c("Young Adult", "Middle Age", "Older Adult")
radio_preferences = as.table(radio_preferences)

library(gmodels)
CrossTable(radio_preferences, expected=TRUE, format="SPSS")
# We can see that p = 0.027 which is smaller than 0.05
# Therefore we can reject the null hypothesis that age and preference have no correlation
# It is safe to assume that there is correlation between age and preference

# Assignment 1b
prop.table(radio_preferences, 1) #Row proportions
prop.table(radio_preferences, 2) #Column proportions
library(grid)
library(vcd)
mosaic(radio_preferences, shade=TRUE)

# Assignment 2a
tab3 <- xtabs(~ Treatment+Sex+Improved, data=Arthritis)

# Assignment 2b
mosaic(tab3, shade=TRUE)

# Assignment 2c
mantelhaen.test(tab3)
# Important to make sure Improved is the last input in xtabs method call above
# p-value is > 0.05 --> We can not discard null hypothesis --> 
# Treatment and Sex are conditionally independent of Improved

# Assignment 2d
doubledecker(ftable(tab3))

# Assignment 2e
female_only = Arthritis[Arthritis$Sex == 'Female',]
tab2 <- xtabs(~ Treatment+Improved, data=female_only)
mosaic(tab2, gp=shading_max)
