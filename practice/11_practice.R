# === (11) What Makes People Happy === #

#page 3
load('HappyTrendData.RData')
str(happy_trend)

#Visualization
fit <- lm(Happy~Time, data=happy_trend)
plot(happy_trend, type='l', col='blue', lwd=2,
     ylab='Google Search Relevance')
lines(happy_trend[,1],fit$fitted.values, col='red',lty=3,lwd=2)
legend('topleft', col=c('blue','red'),
       lty=c(1,3), lwd=c(2,2), bty="n",
       legend=c('Happy released by Pharrell Williams','Trend'))


#page 5
HID <- read.csv('HappyIndex.csv', header=TRUE)
dim(HID); names(HID)

HID5 <- data.frame(Rank=HID[,1], Country=HID[,2], HPI=HID[,11],
                   LifeExpect=HID[,4], Wellbeing=HID[,5])
head(HID5)

#page 6
HID3 <- HID5[, -c(4,5)]
RankHPI <- HID3[order(HID3$Rank, decreasing=FALSE),]
library(googleVis)
GC <- gvisGeoChart(HID5, locationvar='Country', colorvar='HPI',
                   options=list(width=800,height=500,
                                backgroundColor='lightblue'))
GT <- gvisTable(RankHPI,options=list(width=250,height=500))
plot(gvisMerge(GC, GT, horizontal=TRUE))


#page 7
win.graph(7,10)
par(mar=c(4.5,6.5,0.2,0.5))
barplot(RankHPI$HPI,
        names.arg=RankHPI$Country,
        horiz=TRUE, col='lightyellow',
        las=1, cex.names=0.6,
        xlab="Happy Planet Index")


#page 9
HIW <- HID5[,-c(3,4)] #Exclude HPI and LifeExpect columns
RHIW <- HIW[order(HIW$Wellbeing,decreasing=TRUE),]
WDX <- data.frame(Rank=1:dim(HIW)[1], Country=RHIW[,2],
                  Wellbeing=RHIW[,3])


#page 10
library(googleVis)
GC <- gvisGeoChart(WDX, locationvar='Country', colorvar='Wellbeing',
                   options=list(width=800,height=500,
                                backgroundColor='lightblue',
                                colorAxis="{values:[2.9,4.1,5.4,6.6,7.8],
                                colors:[ \'magenta',\'orange',\'bisque',\'aquamarine',\'green']}"))
GT <- gvisTable(WDX,options=list(width=300,height=500))


#page 11
win.graph(8,6)
WDX20 <- subset(WDX, Rank<21)
dotchart(WDX20$Wellbeing, labels=WDX20$Country, cex=1.2,
         pch=3, pt.cex=2, xlab='Wellbeing Score', color=1:5, lcolor='lightgray',
         main='Top 20 Countries With the Highest Wellbeing')
grid(NULL,NA,lty=1)


#page 12
fitw <- lm(HPI ~ Wellbeing, data=HID5)
#Visualization
par(bg='lightyellow')
title = paste('HPI = ',round(fitw$coefficients[1],3),
              '+', round(fitw$coefficients[2],3), 'x Wellbeing')
plot(HID5$Wellbeing, HID5$HPI,
     pch=21, bg='cyan', xlab='Wellbeing Score',
     ylab='Happy Planet Index (2016)', main=title)
lines(HID5$Wellbeing, fitw$fitted.values, col="red")


#page 14
library(googleVis)
GC <- gvisGeoChart(WDL, locationvar='Country', colorvar='LifeExpect',
                   options=list(width=800,height=500,
                                colorAxis="{values:[48,57,66,75,84],
                                colors:[ \'magenta',\'orange',\'bisque',\'aquamarine',\'green']}"))
GT <- gvisTable(WDL,options=list(width=300,height=500))
plot(gvisMerge(GC,GT,horizontal=TRUE))


#page 15
win.graph(8,6)
WDL20 <- subset(WDL, Rank<21)
dotchart(WDL20$LifeExpect, labels=WDL20$Country, cex=1.2,
         pch=3, pt.cex=2, xlab='Life Expectancy (Year)', color=1:5,
         lcolor='lightgray',
         main='Top 20 Countries With the Highest Life Expectancy')
grid(NULL,NA,lty=1)


#page 16
fit1 <- lm(HPI ~ LifeExpect, data=HID5)
title = paste('HPI = ',round(fit1$coefficients[1],3),
              '+', round(fit1$coefficients[2],3), 'x LifeExpect')
plot(HID5$LifeExpect, HID5$HPI,
     pch=21, bg='cyan', xlab='Life Expectancy (year)',
     ylab='Happy Planet Index (2016)', main=title)
lines(HID5$LifeExpect, fit1$fitted.values, col="red")


#page 18
library(dplyr)
Mean_by_Cluster <- HIDC %>%
  select(HPI, LifeExpect, Wellbeing, Cluster) %>%
  group_by(Cluster) %>%
  summarise(mean_HPI=mean(HPI), mean_LifeExpect=mean(LifeExpect),
            mean_Wellbeing=mean(Wellbeing))
Mean_by_Cluster


#page 19
win.graph(4,7)
## Boxplots of HPI, Life expectancy, and Wellbeing by Cluster
cols <- c("purple","blue","green","olivedrab1","red")
par(mfrow=c(3,1),mar=c(2,4,1,1))
boxplot(HPI~Cluster, boxwex=0.75,xlab="Cluster",
        ylab="Happy Planet Index",col=cols, data=HIDC)
boxplot(LifeExpect~Cluster, boxwex=0.75, xlab="Cluster",
        ylab="Life Expectancy",col=cols, data=HIDC)
boxplot(Wellbeing~Cluster, boxwex=0.75,xlab="Cluster",
        ylab="Wellbeing", col=cols, data=HIDC)
par(mfrow=c(1,1))


#page 20
library(rworldmap)
map_data <- joinCountryData2Map(na.omit(HIDC), joinCode="NAME",
                                nameJoinColumn="Country", 
                                nameCountryColumn="Country")
win.graph(8,6)
mapCountryData(map_data, nameColumnToPlot="Cluster",
               colourPalette="rainbow",
               catMethod='categorical',
               mapTitle="Clusters by HPI, Life expectancy, and Wellbeing")
