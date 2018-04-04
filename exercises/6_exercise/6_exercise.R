# Assignment 1
library(maps)
library(mapdata)
map('world','UK', xlim=c(-15,5),ylim=c(48,61))
map('world', 'Ireland', add=TRUE)
map('world', 'Isle of Man', add=TRUE)
map('world', 'Isle of Wight', add=TRUE)
map('world', 'Wales', add=TRUE)
map.cities(world.cities, country='UK', capitals=TRUE)

# Assignment 2
library(googleVis)
AndrewMap <- gvisMap(Andrew, 'LatLong', 'Tip', options=list(
  showTip=TRUE, showLine=TRUE, enableScrollWheel=TRUE, mapType='hybrid', 
  useMapTypeControl=TRUE, width=800,height=400))
plot(AndrewMap)

# Assignment 3-1
library(sp)
gadm <- readRDS("KOR_adm1.rds")
n <- length(gadm$NAME_1)
gadm$dvs <- factor(1:n, labels = gadm$NAME_1)
spplot(gadm, "dvs", col.regions=rainbow(n), col="grey", 
       main="Administrative Divisions of South Korea")

# Assignment 3-2
populations=c(3498529,1591625,2096727,2484557,1514370,
              1550806,1469214,12716780,2700398,3373871,
              2943069,641597,1864791,1903914,243048,
              9930616,1172304)
gadm$populations <- populations
spplot(gadm, "populations", col.regions = cm.colors(length(populations)), 
       main="Regional Population (2016)")