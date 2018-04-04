# === (7) Maps in R === #

#page 2
install.packages("maps")
spark_install(version = "2.1.0")

#page 4
install.packages("mapdata")

#page 5
#[Example 2] Neighboring Countries of Korea
map('worldHires',xlim=c(120,145),ylim=c(32,44))
cols = c("cyan","magenta","green","yellow","red")
country = c("South Korea","North Korea","Japan","China","USSR")
for(i in 1:5)
  map("worldHires", region=country[i], col=cols[i], add=TRUE, fill=TRUE)
title(main='Neighboring Countries of Korea', xlab="Longitude (E)", ylab="Latitude (N)")
map.axes()

#page 7
library(googleVis)
xy=c("36.372:127.363","39.990:116.305")
z=c("KAIST: Daejeon, Korea",
    "Peking Univ: Beijing, China")
cit = data.frame(LatLong=xy,Tip=z)
Map <- gvisMap(cit, "LatLong", "Tip", options=list(
  showTip=TRUE, showLine=TRUE, width=600, height=500))
plot(Map)

#page 9
WP=data.frame(Country=Population$Country,
              Population.in.millions=round(Population$Population/1e6,0),
              Rank=paste(Population$Country, "Rank:", Population$Rank))
G5 <- gvisGeoChart(WP, "Country", "Population.in.millions",
                   "Rank",options=list(dataMode="regions", width=800, height=600))
plot(G5)

#page 13
library(googleVis)
CityPopularity
Geo <- gvisGeoChart(CityPopularity,
                    locationvar='City',
                    colorvar='Popularity',
                    options=list(region='US',height=350,
                                 displayMode='markers',
                                 colorAxis="{values:[200,300,400,500,600,700],
                                 colors:[\'blue',\'cyan',\'green',\'yellow',\'magenta',\'red']}"
                    ))
plot(Geo)


#page 15
install.packages("sp")
library(sp)
gadm <- readRDS("KOR_adm1.rds")
plot(gadm)

#page 17
library(sp)
pop <- read.csv("AreaSexualMap.csv",header=T); pop
pop_s = pop[order(pop$Code),]
interval = c(0,25,50,75,100,125,150,175,200,225,250,275,300,1200)
pop_c = cut(pop_s$Risk, breaks=interval)
gadm$pop = as.factor(pop_c)
n <- length(gadm$NAME_1); dvs <- 1:n
gadm$dvs <- as.factor(dvs)
spplot(gadm, 'pop', col.regions=rainbow(n),
       main="Regional Sexting Distribution Risk")

#page 18
install.packages("ggmap")

#page 20
library(maps)
data(world.cities)
cities <- world.cities[order(world.cities$pop, decreasing=TRUE)[1:1000],]
head(cities,20)

#page 21
value  <- 100*cities$pop / max(cities$pop)
col <- colorRampPalette(c("cyan","lightgreen"))(10)[floor(10*value/100)+1]
library(igraph)
library(threejs)
globejs(lat=cities$lat, long=cities$long, value=value, color=col, atmosphere=TRUE)


###### Lecture
library(maps)
map("usa", col="blue")
map("world", fill=TRUE, col="turquoise")
map("world", regions="Sweden")

library(mapdata)
map('worldHires', 'sweden')
