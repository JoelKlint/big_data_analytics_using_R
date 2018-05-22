# Exercise 12

# Assignment 1-a
URL <- "http://archive.ics.uci.edu/ml/machine-learning-databases/statlog/german/german.data"
german.data <- read.table(URL)

# Assignment 1-b
colnames(german.data) <- c("Checking", "Duration", "CreditHistory", "Purpose", "CreditAmount",
                           "Savings", "Employment", "InstallmentRate", "GenderMarital", "OtherDebtors",
                           "YearsAtResidence", "RealEstate", "Age", "OtherInstallment", "Housing",
                           "ExistingCredits", "Job", "NumLiable", "Phone", "Foreign", "Credit")
library(dplyr)
german_df <- german.data %>% select(CreditHistory, CreditAmount, Employment, Age, Credit)


# Assignment 1-c
library(randomForest)
german.forest <- randomForest(Credit ~ ., data=german_df, importance=TRUE, method="class", proximity=TRUE)

german.importance <- importance(german.forest); german.importance
barplot(german.importance[,1], col=2:5, legend.text=rownames(german.importance), main='Variable Importance')
varImpPlot(german.forest, scale=TRUE, main='Variable Importance Plot')

# Assignment 1-d
ct <- party::ctree(Credit ~ ., data=german_df)
plot(ct)


# Assignment 1-e
library(ggplot2)
ggplot(german_df, aes(x=Age, y=CreditAmount, color=Credit)) + 
  geom_point() + 
  facet_grid(CreditHistory ~ Employment)


# Assignment 1-f
tree <- rpart::rpart(Credit~., data=german_df, method='class')


# Assignment 1-g
library(partykit)
plot(as.party(tree))

