# Exercise 10

# Assignment 1
HID <- read.csv('HappyIndex.csv', header=TRUE)
HID5 <- data.frame(Rank=HID[,1], Country=HID[,2], HPI=HID[,11],
                   LifeExpect=HID[,4], Wellbeing=HID[,5])
head(HID5)
str(HID5)

library(dplyr)
Wellbeing.grouped.df <- HID5 %>%
  mutate(Group = cut(Wellbeing, c(0, 4.575, 5.408, 6.225, Inf), labels=1:4))
Wellbeing.grouped.aov <- aov(HPI ~ Group, data=Wellbeing.grouped.df)
summary(Wellbeing.grouped.aov)
Wellbeing.grouped.thk <- TukeyHSD(Wellbeing.grouped.aov, conf.level=0.95)
Wellbeing.grouped.thk
plot(Wellbeing.grouped.thk, las=1)
# 2-1, 3-1, 4-1, 4-2 significant

HPI.grouped.df <- HID5 %>%
  mutate(Group = cut(HPI, c(0, 21.18, 26.41, 31.55, Inf), labels=1:4))
HPI.grouped.aov <- aov(Wellbeing ~ Group, data=HPI.grouped.df)
summary(HPI.grouped.aov)
HPI.grouped.thk <- TukeyHSD(HPI.grouped.aov, conf.level=0.95)
HPI.grouped.thk
plot(HPI.grouped.thk, las=1)
# 3-1, 4-1, 3-2, 4-2 significant
