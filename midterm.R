Response <- c("Cry", "Anger", "Withdraw")
Boy <- c(25, 15, 6)
Girl <- c(28, 8, 5)
df <- data.frame(Response, Boy, Girl)

write.csv(df, "ChildResponse.csv", row.names=FALSE)
dt <- read.csv("ChildResponse.csv", header=TRUE)


x <- c(652,1537,598,242, 36,46,38,21, 218,327,106,67)
xm <- matrix(x, nrow=3, byrow=TRUE)
colnames(xm) <- c("0", "1-150", "151-300", ">300")
rownames(xm) <- c("Married", "Prev.married", "Single")
xm <- as.table(xm)
barplot(xm, xlab="Caffeine Consumption (mg(day)",
        ylab="Count", beside=TRUE, col=gray(3:1/3))
legend("topright", legend=rownames(xm), fill=gray(3:1/3),
       title="Martial Status")


library(shiny); library(ggvis)
plot_tree <- ggvis(trees, x=~Girth, y=~Height, 
                   size=~Volume, fill:=input_select(
                     choices=c('#C0C0C0', '#808080', '#404040'),
                     selected='#C0C0C0', label='Color'
                   ))
layer_points(plot_tree)

# TODO!!!!
with(airquality, tapply(Ozone, Month, function(vals) round(mean(vals, na.rm=TRUE), digits=3)))
with(airquality, tapply(Solar.R, Month, function(vals) round(median(vals, na.rm=TRUE), digits=3)))

library(dplyr)
airquality %>% filter(Month==8)
library(psych)
a <- describeBy(airquality, airquality$Month); a
a$`Lib Arts` %>% select(vars, n, mean, sd, median, min, max, range, se)


library(nycflights13); library(data.table)
carry_dt <- data.table(flights)
carry_dt[, .(N=.N, mean_speed=mean(distance/air_time, na.rm=TRUE)), by=month][order(month)]


library(googleVis)
City = c("Daejeon", "Gwangju", "Suwon", "Ulsan")
Population = c(1519658, 1485049, 1240480, 1185646)
CityPopulation = data.frame(City, Population)
CityPopulation
Geo <- gvisGeoChart(CityPopulation, locationvar="City",
                    colorvar="Population", options=list(region="KR",
                    height=350, displayMode='markers'))
GT <- gvisTable(CityPopulation, options=list(width=200, height=350))
plot(gvisMerge(Geo, GT, horizontal=TRUE))



library(ggmap); library(ggplot2)
px <- "KAIST"; xy <- geocode(px)
qmap(location=px, zoom=15, maptype="toner", source="google") + 
  geom_point(data=xy, aes(x=lon, y=lat), size=6) + 
  geom_text(data=xy, aes(x=lon, y=lat, label=px), hjust=1.3)



radio_preferences = matrix(c(14, 10, 3, 4, 15, 11, 7, 9, 5), nrow=3, byrow=TRUE)
rownames(radio_preferences) = c("Music", "News", "Sports")
colnames(radio_preferences) = c("Young Adult", "Middle Age", "Older Adult")
radio_preferences = as.table(radio_preferences)

chisq.test(radio_preferences)



turtles.lm <- glm(male~temp, family=binomial, data=turtles)
summary(turtles.lm)
turtles.lm$coefficients
predict.logistic.uni = function(glm, x) {
  return(1/(1+exp(-glm$coefficients[1]-glm$coefficients[2]*x)))
}

with(breast_feeding.df, tapply(feed_length, education, mean))



HID <- read.csv('HappyIndex.csv', header=TRUE)
HID5 <- data.frame(Rank=HID[,1], Country=HID[,2], HPI=HID[,11],
                   LifeExpect=HID[,4], Wellbeing=HID[,5])
head(HID5)
str(HID5)

library(dplyr)
Wellbeing.grouped.df <- HID5 %>%
  mutate(Group = cut(Wellbeing, c(2, 4, 6, 8), labels=c("low", "medium", "high")))
Wellbeing.grouped.aov <- aov(HPI ~ Group, data=Wellbeing.grouped.df)
summary(Wellbeing.grouped.aov)
Wellbeing.grouped.thk <- TukeyHSD(Wellbeing.grouped.aov, conf.level=0.95)
Wellbeing.grouped.thk
plot(Wellbeing.grouped.thk, las=1)
