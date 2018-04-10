head(InsectSprays, 4)
table(InsectSprays$spray)
dt <- unstack(InsectSprays)
round(sapply(dt, mean), 1)

boxplot(count~spray, data=InsectSprays,
        xlab='Type of Insect Spray',
        ylab='Number of dead insects',
        col=2:7)
abline(h=mean(InsectSprays$count), col="grey")


aov.out <- aov(count~spray, data=InsectSprays)
summary(aov.out)

anova(lm(count~spray, data=InsectSprays))

print(model.tables(aov.out, "means"), digits=3)
plot.design(InsectSprays)

thk <- TukeyHSD(aov.out, conf.level=0.95); thk
plot(thk, las=1)


library(HSAUR3)
head(schooldays, 2)
library(Rmisc)
sum <- summarySE(schooldays, measurevar = "absent", groupvars = c("race", "school"))
sum
library(ggplot2)
pd = position_dodge(0.3)
ggplot(sum, aes(x=school, y=absent, color=race)) + 
  geom_errorbar(aes(ymin=absent-se, ymax=absent+se), width=0.2, size=0.7, position=pd) + 
  geom_point(shape=16, size=3, position=pd) + 
  scale_color_manual(values=c("red", "blue")) + 
  theme(legend.position = c(0.13, 0.85))

aov2 <- aov(absent ~ race*school, data=schooldays)
summary(aov2)

print(model.tables(aov2, "means"), digits=4)
plot.design(absent ~ race+school, data=schooldays)

with(schooldays, interaction.plot(x.factor=school, trace.factor=race, response=absent, col=2:3))


cdt <- read.csv("ComparingColleges.csv", header=TRUE)
attach(cdt); dim(cdt)
head(cdt)
table(cdt$School_Type)
Y <- cbind(SAT,Acceptance,StudentP,PhDP,GradP,Top10P)
fit <- manova(Y ~ School_Type)
summary(fit, test="Pillai")
detach(cdt)
