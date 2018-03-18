# Exercise 1
baseball = data.frame(
  team = c("Team A", "Team B", "Team C", "Team D", "Team E"), 
  batting = runif(25, .200, .400) 
)
means = with(baseball, tapply(batting, team, mean)); means

# Exercise 2
library(ggplot2)
ggplot(ToothGrowth, aes(x = supp, y = len, fill=supp)) + 
  geom_boxplot(notch = TRUE) + 
  ggtitle("Tooth thing growth among guinea pigs") + 
  xlab("Supplement") + 
  ylab("Tooth length") + 
  labs(fill="Supplement")

# Exercise 3
Titan = matrix(c(659, 146, 670, 192, 106, 296, 3, 20), nrow = 4, byrow = TRUE)
rownames(Titan) = c("PassMale", "CrewMale", "PassFemale", "CrewFemale")
colnames(Titan) = c("Died", "Survived")
barplot(
  t(Titan),
  beside = TRUE, 
  col=c('turquoise', 'orange'),
  legend = colnames(Titan),
  ylab = "Frequency"
)

# Exercise 4
my_cumsum = function(arg) {
  return(cumsum(arg))
}
my_cumprod = function(arg) {
  return(cumprod(arg))
}



