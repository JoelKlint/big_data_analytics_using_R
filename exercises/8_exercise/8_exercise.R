# Exercise 1-a
X <- c(3.3, 2.9, 2.5, 4.0, 2.8, 2.5, 3.7, 3.8, 3.5, 2.7, 2.6, 4.0)
Y <- c(2.7, 2.5, 1.9, 3.3, 2.7, 2.2, 3.1, 4.0, 2.9, 2.0, 3.1, 3.2)
grades <- data.frame(X, Y)
grades.lm <- lm(Y ~ X, data=grades)
grades.lm
# Regression slope = 0,7861
# Y-intercept = 0.2911

# Exercise 1-b
with(grades, plot(X, Y, pch=23, bg="limegreen"))
lines(grades$X, grades.lm$fitted.values, col="red")

# Exercise 1-c
coefs = coef(grades.lm)
coefs[1] + coefs[2] * 3.0 #predicted grade -> 2.649336

# Exercise 1-d
summary(grades.lm)
# Coefficient of determination -> 0.5975
# Coefficient of nondetermination -> 0.4025
# coef of determination explains how well the model predicts the output.
# Coef of determination = 1 -> we can predict everything perfectly
# Coef of determination = 0 -> we can not predict anything perfectly.

# Exercise 1-e
summary(grades.lm)
# The p-value is 0.003197 < 0.05. Hence, there is a relationship between the data

# Exercise 1-f
with(grades, plot(X, Y, pch=23, bg="limegreen"))
lines(grades$X, grades.lm$fitted.values, col="red")
segments(X, Y, X, predict(grades.lm), col="blue")

# Exercise 2
head(ISwR::kfm)
form <- dl.milk ~ sex + weight + ml.suppl + mat.weight + mat.height
kfm.lm <- lm(form, data=ISwR::kfm)
summary(kfm.lm)
# We can see that weight is a very important parameter in relation to milk intake
# Also height of mother seem to be related to the milk intake
# We can not discard the null hypothesis for the relation between sex and milk intake

# Exercise 3
male = c()
temp = c()

TEMP = 27.2
for(row in 1:2) {
  temp <- c(temp, TEMP)
  male = c(male, 1)
}
for(row in 1:25) {
  temp <- c(temp, TEMP)
  male = c(male, 0)
}

TEMP = 27.7
for(row in 1:17) {
  temp <- c(temp, TEMP)
  male = c(male, 1)
}
for(row in 1:7) {
  temp <- c(temp, TEMP)
  male = c(male, 0)
}

TEMP = 28.3
for(row in 1:26) {
  temp <- c(temp, TEMP)
  male = c(male, 1)
}
for(row in 1:4) {
  temp <- c(temp, TEMP)
  male = c(male, 0)
}

TEMP = 28.4
for(row in 1:19) {
  temp <- c(temp, TEMP)
  male = c(male, 1)
}
for(row in 1:8) {
  temp <- c(temp, TEMP)
  male = c(male, 0)
}

TEMP = 29.9
for(row in 1:27) {
  temp <- c(temp, TEMP)
  male = c(male, 1)
}
for(row in 1:1) {
  temp <- c(temp, TEMP)
  male = c(male, 0)
}
turtles <- data.frame(temp, male)

# Exercise 3-a
turtles.lm <- glm(male~temp, family=binomial, data=turtles)
summary(turtles.lm)
# p-value is << 0.5 --> We can discard null hypothesis --> there is a causal link between temp and sex
coefs <- coef(turtles.lm)
x <- c(27.2, 27.7, 28.3, 28.4, 29.9)
P <- 1 / (1 + exp( -(coefs[1] + coefs[2]*x) ))
logitP <- log(P / (1-P))
cat("Logit(P) for \n__P__\n", P, "\n\n__Logit(P)__\n", round(logitP, 3))
# Logit(P) is -61.31832 + 2.211031 * x

# Exercise 3-b
coefs <- coef(turtles.lm)
odds_ratio = exp(coefs); odds_ratio
# For every increase of 1 unit of temperature, the probability for turtle being male increases 9.125121 times
summary(turtles.lm)


# Exercise 3-c
library(ggplot2)
ggplot(turtles, aes(x=temp, y=turtles.lm$fitted.values)) + 
  geom_point(col = "red") + 
  geom_smooth(
    method = "glm", 
    method.args=list(
      family="binomial"
      ),
    se=FALSE,
    col="purple") + 
  ggtitle("Probability of turtle being male given temperature") + 
  ylab("Probability")

# Exercise 4
womensrole <- HSAUR3::womensrole
education <- c()
agree <- c()
gender <- c()

library(reshape2)
votes <- reshape(HSAUR3::womensrole, timevar = 'gender', idvar= c('education'), direction='wide')
by(votes, 1:nrow(votes), function(row) {
  for(i in 1:row$agree.Male) {
    education <<- c(education, row$education)
    agree <<- c(agree, 1)
    gender <<- c(gender, 1)
  }
  for(i in 1:row$disagree.Male) {
    education <<- c(education, row$education)
    agree <<- c(agree, 0)
    gender <<- c(gender, 1)
  }
  for(i in 1:row$agree.Female) {
    education <<- c(education, row$education)
    agree <<- c(agree, 1)
    gender <<- c(gender, 0)
  }
  for(i in 1:row$disagree.Female) {
    education <<- c(education, row$education)
    agree <<- c(agree, 0)
    gender <<- c(gender, 0)
  }
})
votes.samples <- data.frame(education, agree, gender)
head(votes.samples)

# Exercise 4-a
form <- agree ~ gender + education
votes.lm <- glm(form, family=binomial, data=votes.samples)
summary(votes.lm)
# We can not discard the null hypothesis for gender
# We can discard the null hypothesis for education
coefs <- coef(votes.lm)
odds_ratio = exp(coefs); odds_ratio
# For every increase of 1 year in education, the probability for a person agreeing is decreased to 0.7786626 the previous value

# Exercise 4-b
library(dplyr)
womensrole.df <- womensrole %>% 
  select(education, agree, disagree) %>%
  group_by(education) %>%
  summarize(agree=sum(agree), disagree=sum(disagree), agree.prob=sum(agree)/(sum(agree)+sum(disagree))) %>%
  select(education, agree.prob)

womensrole.df <- data.frame(womensrole.df)
form <- agree ~ education
womensrole.lm <- glm(form, family=binomial, data=votes.samples)

library(ggplot2)
ggplot(womensrole.df, aes(x=education, y=agree.prob)) + 
  geom_point(col = "red") + 
  geom_line(
    aes(y=unique(womensrole.lm$fitted.values)),
    col = "blue") +
  ggtitle("Fitted and observed probabilities for womensrole dataset") + 
  ylab("Probability")
