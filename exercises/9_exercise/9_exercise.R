# Homework 9

# Exercise 1-a
education <- c(rep(1, 5), 
               rep(2, 5), 
               rep(3, 5))
education <- factor(education, 1:3, labels=c("LTHS", "HG", "CG"))
feed_length <- c(1.0, 6.5, 4.5, 2.0, 8.5, 
                 1.5, 4.0, 3.5, 1.5, 5.0, 
                 11.0, 6.5, 4.5, 7.5, 9.0)
breast_feeding.df <- data.frame(education, feed_length)
breast_feeding.aov <- aov(feed_length ~ education, data=breast_feeding.df)
summary(breast_feeding.aov)
# We can discard the null hypothesis

# Exercise 1-b
data <- breast_feeding.df[breast_feeding.df$education == "LTHS",]
plot(density(data$feed_length), main="Distribution of breast feeding Education = LTHS ")
mean <- mean(data$feed_length)
lines(rep(mean, 2), 0:1)

data <- breast_feeding.df[breast_feeding.df$education == "HG",]
plot(density(data$feed_length), main="Distribution of breast feeding, education: 2")
mean <- mean(data$feed_length)
lines(rep(mean, 2), 0:1)

data <- breast_feeding.df[breast_feeding.df$education == "CG",]
plot(density(data$feed_length), main="Distribution of breast feeding, education: 3")
mean <- mean(data$feed_length)
lines(rep(mean, 2), 0:1)


# Exercise 2
make_data = function() {
  # year 1
  year <- c(rep(1, 12))
  month <- c(1:12)
  salary <- c(15,22,18,23,23,12,26,19,15,14,14,21)
  # year 2
  year <- c(year, rep(2, 12))
  month <- c(month, 1:12)
  salary <- c(salary, 18,25,22,15,15,15,12,17,14,18,22,23)
  # year 3
  year <- c(year, rep(3, 12))
  month <- c(month, 1:12)
  salary <- c(salary, 22,15,15,14,26,11,23,15,18,10,19,11)
  # year 4
  year <- c(year, rep(4, 12))
  month <- c(month, 1:12)
  salary <- c(salary, 23,15,19,17,18,10,15,20,19,12,17,18)
  # year 5
  year <- c(year, rep(5, 12))
  month <- c(month, 1:12)
  salary <- c(salary, 24,14,21,18,14,8,18,10,20,23,11,14)
  
  month <- factor(month, 1:12, labels=c("Jan", "Feb", "Mar", "Apr", "Maj", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
  year <- factor(year, 1:5, labels=c("Year 1", "Year 2", "Year 3", "Year 4", "Year 5"))
  director_salary.df <<- data.frame(year, month, salary)
}
make_data()

# Exercise 2-a
director_salary.aov <- aov(salary ~ year+month, data=director_salary.df)
summary(director_salary.aov)
# P-value is not less than 0.05 for neither year or month or their combination --> We can not discard null hypothesis

# Exercise 2-b
boxplot(salary ~ month, data=director_salary.df, col=2:13,
        xlab="Month", ylab="Salary(x1000)", main="Average salary for a director per month during 5 years")
boxplot(salary ~ year, data=director_salary.df, col=2:6,
        xlab="Year", ylab="Salary(x1000)", main="Average salary for a director per year")

# Exercise 3
make_data = function() {
  restaurant <- c(
    rep("E1", 3),
    rep("E2", 3),
    rep("E3", 3),
    rep("E4", 3),
    rep("W1", 3),
    rep("W2", 3),
    rep("W3", 3),
    rep("W4", 3)
  )
  item <- c(rep(1:3, 8))
  item <- factor(item, 1:3)
  sales <- c(
    25 ,39, 36,
    36, 42, 24,
    31, 39, 28,
    26, 35, 29,
    51, 43, 42,
    47, 39, 36,
    47, 53, 32,
    52, 46, 33
  )
  food_sales <<- data.frame(restaurant, item, sales)
}
make_data()

# Exercise 3-a
food_sales.aov <- aov(sales ~ item, data=food_sales)
summary(food_sales.aov)
# We can not discard the null hypothesis

# Exercise 3-b
food_sales$coast <- c(
  rep("E", 12),
  rep("W", 12)
)
food_sales.aov <- aov(sales ~ coast, data=food_sales)
summary(food_sales.aov)
# We can discard the null hypothesis --> the mean sales volume of the coastal regions differ

# Exercise 3-c
food_sales.aov <- aov(sales ~ item*coast, data=food_sales)
summary(food_sales.aov)
with(food_sales, interaction.plot(x.factor=item, trace.factor=coast, response=sales))
# It is possible that there is interaction between them

# Exercise 4-a
Baumann.df <- carData::Baumann

# Exercise 4-b and 4-c
Y <- with(Baumann.df, cbind(pretest.1, pretest.2, post.test.1, post.test.2, post.test.3))
Baumann.manova <- manova(Y ~ group, data=Baumann.df)
summary(Baumann.manova)
summary.aov(Baumann.manova)

# All pretests was not significant different --> 
# The performance of the groups before teaching were rather similar
#
# All posttests was significant different --> 
# The perfornamce of the groups after teaching were rather dissimilar -->
# We can assume the different teaching methods lead to a difference -->
# This does not tell how the different groups performed relative each other though

tapply(Baumann.df$post.test.1, Baumann.df$group, mean)
tapply(Baumann.df$post.test.2, Baumann.df$group, mean)
tapply(Baumann.df$post.test.3, Baumann.df$group, mean)

# These values tell us how the different groups performed relative eachother

