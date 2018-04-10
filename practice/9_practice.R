# === (9) Regression Analysis === #

#page 4
# Plot with prediction
with(longley,plot(GNP,Employed,pch=21,bg='cyan'))
ur <- lm(Employed ~ GNP, data=longley)
lines(longley$GNP,ur$fitted.values,col='red')

#page 5
#install.packages("nycflights13")
library(nycflights13)
library(dplyr)
flights_df <- as.data.frame(flights)
base_dat <- flights_df %>% filter(origin=="JFK", dep_delay>0, arr_delay>0)
form <- dep_delay ~ arr_delay + distance + air_time
mfit1 <- lm(form, data=base_dat)
summary(mfit1)

#page 7
#install.packages("coefplot")
library(coefplot)
coefplot(mfit1)

#page 8
#install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
cordat <- base_dat %>%
  select(dep_delay, arr_delay, distance, air_time)
head(cordat, 2)
chart.Correlation(cordat)


#page 10
##[Sample Data] Probability of passing an exam versus hours of study
Hours <- c(0.50,0.75,1.00,1.25,1.50,1.75,1.75,2.00,2.25,2.50,
           2.75,3.00,3.25,3.50,4.00,4.25,4.50,4.75,5.00,5.50)
Pass <- c(0,0,0,0,0,0,1,0,1,0, 1,0,1,0,1,1,1,1,1,1)
passhour <- data.frame(Hours, Pass)
head(passhour,3); tail(passhour,3)
table(passhour$Pass)

out1 <- glm(Pass ~ Hours, family = binomial, data = passhour)
summary(out1)

b <- coef(out1)
x <- 1:5; P <- 1.0/(1 + exp(-(b[1] + b[2])) )
cat("Probabilities of passing exam: \n", 
    round(P, 3), "for", x, "hours of study")


#page 12
b = coef(out1)
x = 1:5; P = 1.0/(1+exp(-b[1]-b[2]*x))
cat("Probabilities of passing exam:\n",
    round(P,3),"\nfor",x,"hours study")
H <- -b[1] / b[2]
cat("Boundary to pass exam:", H)
plot(Pass ~ Hours, pch=20, col="blue",
     main="Fitted Logistic Regression Line with observed data")
lines(Hours, out1$fitted, type="l", col="red")


#page 14
install.packages("LOGIT")

#page 17
install.packages("vcdExtra")
