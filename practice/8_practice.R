# === (8) Tabular Data and Chi-Square Tests === #

#page 3
#(2) Two-Way Frequency Table
ps <- array(c(49,23,52,64,16,33), dim=c(2,3),
            dimnames=list(c('Male','Female'),c('Baseball','Soccer','Basketball')))
tab2 <- as.table(ps)
addmargins(tab2)
prop.table(tab2, 1)
prop.table(tab2, 2)
barplot(tab2, beside=TRUE, legend=TRUE, col=c('cyan', 'magenta'),
        xlab='Preferred sport', ylab='Frequency')

#page 5
install.packages("vcd")
hec <- data.frame(HairEyeColor)
head(hec, 2)
tab3 <- xtabs(Freq ~ Hair+Eye+Sex, data=hec)
tab3
ftable(tab3)
library(grid)
library(vcd)
mosaic(tab3, shade=TRUE)

#page 7
##Chi-Square Test of Goodness-of-Fit
O = c(169,58,56,18,253,45,38,90)
tc = c("Frequency")
tr = c("Chinese","Indian","Korean","Maori","NZ European",
       "Other European","Pacific","Other")
mo = matrix(O, dimnames=list(tr,tc))
as.table(mo)
chisq.test(mo)
# What is the critical chisq value?
k = 8; df = k - 1; a = 0.05;
qchisq(1-a, df)

prop.table(mo)
n = sum(O); E = rep(n/k, k)
cgram <- (O-E)/sqrt(E)
barplot(cgram, col=ifelse(cgram>0, "red", "blue"), names.arg=tr)


#page 10
# create table
dt1 <- array(c(11,23,22, 33,14,13, 7,9,14), dim=c(3,3),
             dimnames=list("Residence City"=c("Boston","Montreal","Montpellier"),
                           "Favorite Baseball Team"=c("Blue Jays","Red Socks","Yankees")))
(dt1 <- as.table(dt1))
library(grid)
library(vcd)
mosaic(dt1, gp=shading_max)


#page 12
install.packages("gmodels")
library(gmodels)


#page 13
# Read data
dt2 <- read.csv("SurveyData.csv",header=T)
#univ : 1 = Y Univ, 2 = K Univ
University <- factor(dt2$univ,levels=1:2,labels=c("Y","K"))
#c4 : I accept quickly a new fashion. (negative 1-5 positive)
FashionAcceptance <- factor(dt2$c4)
tb2 <- table(University,FashionAcceptance)
tb2
addmargins(tb2)

#page 14
install.packages("gplots")

#page 17
#read data
bs <- read.csv("BoyScout.csv",header=T); bs
bs$Socio <- ordered(bs$Socio,
                    levels=c("Low","Medium","High"))