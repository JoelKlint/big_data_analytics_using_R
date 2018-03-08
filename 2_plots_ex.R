#Exercise 1
library(MASS)
a = Animals[order(Animals$body),]
plot(log(a), type='l', main="Ratios of brain vs body weight for animals", xlab="log Body weight [kg]", ylab='log Brain weight [g]') + 
  text(log(a), labels = row.names(a), adj=50, cex=0.5, pos = 2.5)

library(ggplot2)
ggplot(data=log(a), mapping=aes(x=body, y=brain)) + 
  xlab("log Body weight [kg]") + 
  ylab("log Brain weight [g]") + 
  geom_point() +
  geom_line() + 
  geom_label(label=row.names(a), size=2) + 
  stat_smooth() +
  ggtitle("Ratios of brain vs body weight for animals")

#Exercise 2
caffeine = matrix(c(652,1537,598,242,36,46,38,28,218,327,106,67), nrow=3, byrow = TRUE)
rownames(caffeine) = c("Married", "Prev.married","Single")
colnames(caffeine) = c("0", "1-150", "151-300", ">300")
barplot(caffeine, beside = TRUE ,legend=TRUE, col=2:4, xlab="Caffeine consumption", ylab="Number of women", main="Caffeine consumption for different martial statuses among women")

#Exercise 3
ggplot(data=iris, mapping = aes(x = Sepal.Length, fill=Species)) + 
  geom_bar(color = 'black') +
  xlab("Sepal Length") + 
  ylab("Count") + 
  ggtitle("Distribution of Sepal length in iris dataset")

#Exercise 4
ggplot(data=airquality, mapping = aes(Day, Ozone, size=Wind, color=Month)) + 
  xlab("Day of the month") + 
  ylab("Ozone [ppb]") +
  labs(size="Wind [mph]", color="Month") + 
  geom_point() + 
  ggtitle("Measurements of air quality")
