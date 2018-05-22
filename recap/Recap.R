# ======================================== #
#               Data types
# ======================================== #
# === Vectors === #
# Vectors are ordered collection containing the same data type
c(1,2,3)
c(1,2,3)^2
c("Swe", "Eng")
c(TRUE, FALSE)
c(1, "Swe")     # All values will be converted to character types
# Indexing vectors
x <- c('a', 'b', 'c')
x[c(1,1,3)]     # Vectors can be indexed with vectors

# === Scalars === #
# In R, single values are called scalars
15
"Swe"
TRUE

# === Matrices === #
# Matrices are two dimensional array of elements
x <- matrix(c(1,2,3,4,5,6,7,8,9), nrow=3, byrow=TRUE)

# Finding dimensions of a matrix
dim(x)

# Indexing matrices
x[3,2]     

# Setting and getting col and row names of matrices
colnames(x) <- c("Grade", "Temp", "Hometown")
rownames(x) <- c("Person 1", "Person 2", "Person 3")
colnames(x)
rownames(x)

# Matrices can be plotted easily with barplot
barplot(x, legend=TRUE, col=1:3)
barplot(x, beside=TRUE, legend=TRUE, col=1:3)

# =============== Arrays =============== #
# Arrays are like matrices, but can contain more dimensions
# dim = (height, width, depth)
x <- array(1:18, dim=c(3,3,2))

# Finding dimensions of arrays
dim(x)

# Arrays can be indexed
x[3,1,2]

# =============== Lists =============== #
# Lists are like vectors, but can contain different data types
x <- list(1, "Swe", TRUE)
# We have to use bracket square operator to retrieve values from lists
x[[1]]

# =============== Data Frame =============== #
# A data frame is a list of vectors of equal length
Name <- c("Earth", "Mars", "Pluto")
Diameter <- c(14, 16, 11)
Planets <- data.frame(Name, Diameter)

# Sorting a data frame
Planets[order(Planets$Diameter),]

# =============== Factors =============== #
# Factors take on a limited number of different values. Always use this for categorial values
x <- rep(1:5, 4)
x <- factor(x, levels=1:5, labels=c('a', 'b', 'c', 'd', 'e'))

# Frequency within factors can be plotted
plot(x, col=2:4)

# =============== Data Table =============== #
# Data tables are better when working with HUGE data. Like 100GB
# Data tables are not native R data types.
library(data.table)

# Reads the .csv file and returns it as a data.table
x <- fread("practice/RealEstate.csv", stringsAsFactors=TRUE)  

# Getting certain rows from data table
x[Bedrooms==4 & Bathrooms > 4]

# Getting a certain column from data table as vector
x[, Price]

# Getting one/several columns from data table as data table
x[, .(Bedrooms, Price)]

# Sorting a data table
x[Bedrooms==4 & Bathrooms > 4][order(Size)]

# Perform operations on data tables
# x[which-row-numbers, function-to-perform, to-group-by]
x[, mean(Price), Location]
x[Bedrooms==3, mean(Price), Location]
x[1:500, sum(Size), Location]
x[, .(Mean_Price_Per_Bathroom=mean(Price/Bathrooms), Total_Size=sum(Size), Count=.N ), by=Location] #.N is the total row count for that group

# We can create/update columns with the := operator
x[, Price_Per_Bathroom:=Price/Bathrooms]
# Or several at the same time
x[, c("Price_Per_Bathroom", "Price_Per_Bedroom"):=.(Price/Bathrooms, Price/Bedrooms)]

# We can create pivot tables. This groups according to formula and performs a function for every group
dcast(x, Location~Status, fun.aggregate = sd, value.var="Price", na.rm=TRUE)

# ======================================== #
#                  Manipulating data
# ======================================== #

# ========== apply family ========== #
# Apply family function can be used instead of for loops
apply(faithful, 2, mean)      # Perform function mean over all columns in data faithful
apply(faithful, 1, sd)        # Perform function mean over all rows in data faithful
lapply(faithful, mean)        # Perform mean for every value in faithful.
# since faithful has two values, namely two lists with values,
# lapply will return the mean for both of those lists
sapply(faithful, mean)        # As lapply, but returns data as a data frame

# This will calculate the mean of the length of teeth, grouped by the dose received by test subjects
tapply(ToothGrowth$len, ToothGrowth$dose, mean)
# More convenient way to work with tapply
with(ToothGrowth, tapply(len, dose, mean))

# Aggregate works like tapply, but accepts a list of columns to group data by
with(ToothGrowth, aggregate(len, list(supp=supp, dose=dose), sd))

# ========== Manipulating data with dplyr ========== #
library(dplyr)
# dplyr is an SQL similar method of manipulating data. 
# It works atleast with data frames and data tables, maybe more
# We can select data
USArrests %>% select(Murder, Assault)

# We can filter on data
USArrests %>% filter(UrbanPop > 80 & Rape < 40)


# ======================================== #
#                  Utilities
# ======================================== #
length(x)       # Returns length of input
class(x)        # Returns class of input
head(x)         # Returns first five values of x
str(x)          # Check the structure of x
table(x)        # Counts occurences of every value in x
order(x)        # Returns which order every index should be in
?mean           # Get help for a method
help(package='ggplot2')           # Get help for a package
rank(x)         # Tells you which position every value is in in the sequence
unique(x)       # Returns all unique values in the sequence
min(x)          # Returns minimum value of x
max(x)          # Returns maximum value of x
range(x)        # Returns the max and the min of x
quantile(x)   

# ========== Generating data ========== #
x = 1:10          # Sequence
seq(0, 100, 10)   # Sequence with specific gap between numbers
rep(x, 10)        # Repeat something
rev(x)            # Reverse something
rbind(1:10, 11:20)  # Creates a matrix from a set of vectors by putting them row by row
cbind(1:10, 11:20)  # Creates a matrix from a set of vectors by putting them column by column

pnorm(0)          # What is the probability of getting one, given the normal distribution
qnorm(0.5)        # What value do we need to have, to atleast 50% of all values? Integral below curve

runif(5)          # Generates 5 values according to the uniform distribution (everything as likely)


# ========== Assignment operators ========== #
# Local scope
x <- 1
x = 1
1 -> x
# Global scope
x <<- 1
1 ->> x


# ========== normal loops and statements ========== #
for(i in 1:10) {
  cat(paste(i, ': '))
  if(i >= 8) 
    cat("Value is 8 or bigger\n")
  else if(i >= 3) 
    cat("Value is between 3 and 8\n")
  else 
    cat(paste("Hello from iteration ", i, '\n'))
}

# Creating a function
x <- function(a, b) {
  a + b
}; x(1,4)

# You cannot access variables from functions if they do not use the global scope assignment operator
a <- 1; x <- function(a) {
  a <- a
}; x(5); a

# You have to use the global scope assignment operator to assign to global scope
a <- 1; x <- function(a) {
  a <<- a
}; x(5); a

# To return things from functions, use the return() method
x <- function() {
  return(25)
}; x()


# ========== input/output ========== #
print("This will print a new line")
cat("This will print without a new line")
paste("This will be concatenated", "with this string")

# Reads a .csv file and returns it as a data.frame
read.csv("practice/RealEstate.csv", header=TRUE)         # header=TRUE --> first row contains column names

# A quicker version of read.csv that instead returns a data.frame. Good for huge data sets
library(data.table)
fread("practice/RealEstate.csv", stringsAsFactors=TRUE)

# We can read .RDS files which loads a serialized R object
x <- readRDS('exercises/6_exercise/KOR_adm1.rds')
# We can also save an R object as an .RDS file
save(x, 'filepath')


# ======================================== #
#               Mathematics
# ======================================== #

# =============== Arithmatics =============== #
8 + 5
8 - 5
8 * 5
8 / 5
8 ^ 5
8 %/% 5   # Integer division
8 %% 5    # Remainder integer division

# =============== Mathematical functions =============== #
log(13)
log10(13)
log(13, base=7)
exp(13)    # e ^ x
sin(13)
cos(13)
tan(13)
asin(0.7)
acos(0.7)
atan(13)
sqrt(13)
factorial(13)
sum(1:10)



# ======================================== #
#               Basic plots
# ======================================== #

# =============== general plot =============== #
# Generic function for plotting R objects
plot(USArrests)
# types p=points, l=line, b=both, h=histogram, 
plot(1:10, 21:30, type="l")
# We can make y axis labels horizintal with las=1
plot(1:10, 21:30, type="l", las=1)

# =============== adding points =============== #
points(2, 30)   # Individial points 
points(1:9, seq(28, 24, -0.5))   # A set of points


# =============== adding lines =============== #
# We can draw k*x + m curves
abline(26, 0.3)     # 23 = intercept, -0,5 = slope

#We can draw straight lines
abline(h = 24)      # h = horizontal
abline(v = 6)      # v = vertical

# =============== adding text =============== #
text(8, 21, "hejsan")
text(rep(8,4), seq(22,28,2), "Hej")

# =============== barplot =============== #
# We can plot data frames
barplot(
  cars$dist,
  col='cornsilk',
  names.arg=cars$speed,        # Sets labels for x values
  horiz=FALSE,
  xlab="speed",
  ylab="Stopping distance",
  main='This is the title'
)

# =============== boxplot =============== #
# Boxplots shows statistical summaries for different groups in data
# Data is defined as first input like this: continous value ~ group
boxplot(len ~ supp, data=ToothGrowth, notch=TRUE)
# notch = should there be a notch at the mean?


# =============== piechart =============== #
pie(rep(1, 24), col=rainbow(24), radius=1)

# We can let the labels for every piece
x <- c(0.1, 0.4, 0.2, 0.3)
pie(x, labels=paste(x, '%'))

# We can draw 3D piecharts
# Has similar API as pie() method. Here we can also separate pieces with explode param
library(plotrix)
pie3D(x, labels=paste(x, '%'), explode=0.1)

# =============== histograms =============== #
# histograms counts occurences of values within certain groups
x <- c(rep(1,5), rep(2,4), rep(3,3), rep(4,1))
hist(x)
# We can decide how many breaking points there should be with breaks
hist(x, breaks=4)

# =============== scatterplots =============== #
# We can make scatter plots
symbols(USArrests$Murder, USArrests$Assault, circles=USArrests$UrbanPop, inches=0.2, 
        fg='red', bg=rainbow(50))
# circles = relative sizes of circle
# inches = maximum size of circles. This rescales all circles
# fg = shape border color
# bg = shape background color

# We can plot different shapes. There are more comples ones which requires multidimensional data
# See help
symbols(USArrests$Murder, USArrests$Assault, squares = USArrests$UrbanPop, inches=0.2)


# =============== managing legend =============== #
legend('topleft', title='Information', legend=c("group 1", "group 2"), fill=1:2, cex=1)
# title = legend title
# legend = labels
# fill = label colors
# cex = size of legend

# =============== labels =============== #
# You set labels by using these parameters in the different plot methods
# xlab="This will be the x label"
# ylab="This will be the y label"
# main='This will be the title'

# =============== global setup =============== #
# Sets the palette. The palette decides how many the default colors are.
# If we plot something with 10 groups, but palette only has 8 colors,
# there will be groups with similar color
# This is seldomly used, as you can specify colors directly inline in every case
palette(rainbow(10))


# ======================================== #
#                  ggplot
# ======================================== #
# The base method, all ggplots starts with ggplot()
# Think of this method as the base class, it is useless on its own
# All piped method calls inherits all data that ggplot() receives
# We can give new data to any ggplot-method to extend the default
library(ggplot2)
ggplot(USArrests)

# =============== Aesthetics =============== #
# aes() = Aesthetic wrapper. 
# This helps display the data relative each other depending on columns in the data
# Available parameters:
# x, y, color, size, fill
# Available aesthetics are often listed under the specific gg-submethods help page
ggplot(USArrests, aes(Murder, Assault))

# =============== adding points =============== #
# We can add points with colors
ggplot(USArrests, aes(Murder, Assault)) + 
  geom_point(col='blue') + 
  
  # We can add points with aesthetics relative to each other depending on a data column
  ggplot(USArrests, aes(Murder, Assault)) + 
  geom_point(aes(color=UrbanPop, size=Rape))

# =============== adding lines =============== #
# We can add lines, connecting all data points
ggplot(USArrests, aes(Murder, Assault)) + 
  geom_line(col="red")

# =============== adding smoothing lines =============== #
# Draws a smooth line. Helps seeing patters when there is to many data points
ggplot(USArrests, aes(Murder, Assault)) + 
  stat_smooth(col='red')

# =============== adding text =============== #
# We can add text in the plots
# The text is defined using the label aes parameter
ggplot(USArrests, aes(Murder, Assault)) + 
  geom_point(col='blue') + 
  geom_text(aes(label=row.names(USArrests)))


# =============== adding error bars =============== #
x <- lm(Employed ~ GNP, data=longley)
ggplot(x, aes(x=longley$GNP, y=x$fitted.values)) +
  geom_line() + 
  geom_segment(
    aes(xend=longley$GNP, y=longley$Employed+x$residuals, yend=longley$Employed-x$residuals),
    col="red") +
  geom_point(aes(y = longley$Employed+x$residuals), col="red")


# =============== making histograms =============== #
# Histograms shows frequence of continous values within certain bins
# With this, we can show distribution of a continous value
ggplot(diamonds, aes(x=carat)) + 
  geom_histogram()
# We can decide how many bins there should be with bins parameter
ggplot(diamonds, aes(x=carat)) + 
  geom_histogram(bins=10)


# =============== adding bars =============== #
# geom_col decides height of bars with a row value in the data
# With this, we can do the same as a line plot, but with bars instead
ggplot(sleep, aes(x=ID, y=extra, fill=group)) + 
  geom_col()

# geom_bar decides height of bars based onoccurences of the same data
# With this, we can for example show how many of different groups exists
ggplot(mpg, aes(x=class)) + 
  geom_bar(position='dodge')
# We can group bars with fill
ggplot(mpg, aes(x=class, fill=manufacturer)) + 
  geom_bar()
# We can make bars not stack
ggplot(mpg, aes(x=class, fill=manufacturer)) + 
  geom_bar(position='dodge')


# =============== adding error bars =============== #
# Error bars can be used to enhance information on bar plots 
x <- Rmisc::summarySE(diamonds, measurevar='price', groupvars=c('cut', 'color'))
ggplot(data=x, aes(x=cut, y=price)) +
  geom_col(aes(fill=color), position=position_dodge()) + 
  geom_errorbar(
    aes(ymin=price-se, ymax=price+se, group=color),
    position=position_dodge(0.9), width=0.3
  )


# =============== making boxplots =============== #
ggplot(ToothGrowth, aes(x = factor(dose), y = len)) + 
  geom_boxplot(aes(fill=supp))
# fill = makes groups in the data


# =============== Layout several parallel plots =============== #
# We can create several plots in parallell horisontally
ggplot(boot::cane, aes(x=r/n, fill=block)) + 
  geom_histogram(color='black') + 
  facet_grid(block ~ .)
# We can create several plots in parallell vertically
ggplot(boot::cane, aes(x=r/n, fill=block)) + 
  geom_histogram(color='black') + 
  facet_grid(. ~ block)

# We can also use qplot for facets
qplot(supp, len, facets=~dose, data=ToothGrowth) + geom_boxplot()


# =============== Make pretty =============== #
# We can set labels
ggplot(USArrests, aes(Murder, Assault)) + 
  xlab('This is the x label') + 
  ylab('THis is the y label') + 
  ggtitle('This is the title of the graph')

# We can make background white
ggplot(USArrests, aes(Murder, Assault)) + 
  geom_point(col='red') + 
  theme_bw()

# There exists a lot of premade theme_* methods

# We can use the base theme() method to set visual parameters
# read more in help 
ggplot(USArrests, aes(Murder, Assault)) + 
  geom_point(col='red') + 
  theme(axis.title.x = element_text(color='blue'))

# =============== setting colors =============== #
# We can set the values of aes parameters after the plot if we want more control
# It well spread across the whole graph. Legend, bars, dots etc
scale_color_manual(values(c("red", "blue")))
scale_fill_manual(values=c("green", "yellow"))
# There are more functions on the form scale_*_manual and scale_*_*


# ======================================== #
#                  googleVis
# ======================================== #
# googleVis allows us to create interactive charts
# All googleVis methods return an object that should be plotted using plot()
library(googleVis)

# =============== Motion chart =============== #
# Motion charts allows us to inspect data that varies over time
# The data need to have atleast four columns of data, so two can be plotted
# idvar = figures out which rows describes the same data
# timevar = figures out at which time each row describes data
x <- gvisMotionChart(Fruits,
                     idvar='Fruit',
                     timevar='Year'); plot(x)

#=============== Bubble chart =============== #
# Pretty much a scatterplot with more information as you hover every scatter
x <- gvisBubbleChart(Fruits, idvar='Fruit', xvar='Sales', yvar='Expenses', 
                     colorvar='Year', sizevar='Profit'); plot(x)


#=============== Table =============== #
x <- gvisTable(Population, option=list(page='enable'), 
               formats=list( Population='####', '% of World Population'='#.##%')); plot(x)

#=============== Organizational chart =============== #
# Renders a tree structure 
x <- gvisOrgChart(Regions, options=list(
  width=600, height=300, size='large', allowCollapse=TRUE
)); plot(x)


# ======================================== #
#                  ggvis
# ======================================== #
# ggvis helps us draw interactive graphs. We can create
# sliders, checkboxes, dropdowns, text input, numeric input etc
# It works a lot like ggplot. ggvis is the base bethod and all data it receives,
# is passed on to its "children"
library(ggvis)

# =============== Adding points =============== #
# We can choose to pass parameters to the base method or to the child method
mtcars %>% ggvis(
  x = ~wt, y = ~mpg,
  fill:='red', stroke:='black',
  opacity:=input_slider(0, 1, label='opacity') 
) %>% 
  layer_points( size:=input_slider(10, 100, label='point size') )

# =============== Adding smooth lines =============== #
mtcars %>% ggvis(
  x = ~wt, y = ~mpg,
  fill:='red', stroke:='black',
  opacity:=input_slider(0, 1, label='opacity') 
) %>% layer_smooths()

# =============== Adding bars =============== #
# Bar chart without y parameter counts amount of rows for each x
cocaine %>% ggvis(
  x = ~state,
  fill:=input_select(c('red', 'blue'), label='Fill color')
) %>% layer_bars()

# Bar chart with y parameter sums all y values for every x
cocaine %>% ggvis(
  x = ~state, y=~weight,
  fill:=input_select(c('red', 'blue'), label='Fill color')
) %>% layer_bars()

# =============== Adding interactive controls =============== #
# input_slider
# input_checkbox
# input_checkboxgroup
# input_numeric
# input_radiobuttons
# input_select
# input_text


# ======================================== #
#                  Maps
# ======================================== #

# =============== maps package =============== #
# This allows us to draw base maps.
# We can find what databases are available with help(package='maps')
# We can use the same methods to handle labels and legend as for R default plot() method
library(maps); library(mapdata)
map("world", region=c('Sweden', 'Iceland', 'Italy', 'Germany'), col=rainbow(4), fill=TRUE)
# The worldHires database is has higher resolution
map("worldHires", region=c('Sweden', 'Iceland', 'Italy', 'Germany'), col=rainbow(4), fill=TRUE)

# We can add cities to the map
map.cities(world.cities, country=c('Sweden', 'Germany'), capitals=TRUE, label = TRUE)

# We can draw axes on maps with longitude and latitude
map.axes()

# =============== googleVis maps =============== #
library(googleVis)
# We can plot one or several points on a standard GoogleMap
x <- data.frame(LatLong=c("36.372:127.363", "39.990:116.305"), Tip=c('KAIST', 'Peking University'))
x <- gvisMap(x, locationvar = 'LatLong', tipvar = 'Tip', options=list(
  width=600, height=500, showTip=TRUE, showLine=TRUE
)); plot(x)

# We can use a gvisGeoMap which is more like a hoverabe map with information
x <- data.frame(Country=Population$Country, 
                Population.in.millions=round(Population$Population/1e6, 0),
                Rank=paste(Population$Country, 'Rank: ', Population$Rank))
x <- gvisGeoMap(x, locationvar='Country', 
                numvar='Population.in.millions', hovervar = 'Rank', 
                options=list(datamode='regions', width=800, height=600))
plot(x)

# We can create tables which displayes information
x <- gvisTable(Exports, options=list(width=300, height=400)); plot(x)

# We can combine several googleVis plots into one googleVis
x <- gvisGeoMap(Exports, locationvar="Country", numvar='Profit', options=list(
  width=500, height=340
))
y <- gvisTable(Exports, options=list(width=300, height=400))
x <- gvisMerge(x, y, horizontal = TRUE); plot(x)

# We can plot a gvisGeoChart which is similar to a gvisGeoMap, but not flash based
x <- gvisGeoChart(CityPopularity, locationvar='City', colorvar = 'Popularity', options=list(
  region='US', height=350, displayMode='markers', 
  colorAxis="{values:[200,300,500,600,700],
  colors:[\'blue',\'cyan',\'green',\'yellow',\'magenta',\'red']}"
)); plot(x)

x <- gvisGeoChart(CityPopularity, locationvar='City', colorvar = 'Popularity', options=list(
  region='US', height=350, displayMode='markers', 
  colorAxis="{values:[200,700],
  colors:[\'blue',\'red']}"
)); plot(x)


# =============== spatial data maps =============== #
# Plotting spatial data takes A LOT of time on the computer I wrote this
library(sp)
x <- readRDS('exercises/6_exercise/KOR_adm1.rds')
x$dvs <- as.factor(1:length(x$NAME_1))
spplot(x, 'dvs', col.regions=rainbow(length(x$NAME_1)), col='grey')


# =============== ggmaps =============== #
# Plots with the help of online maps, and with the API of ggplot
# It fetches maps from online by the location specified
library(ggplot2); library(ggmap)

# qmap is the Quick Map Plot. Kind if a shortcut
x <- qmap(location="Lund University", zoom=14, maptype="toner", source="stamen"); plot(x)

# qmplot is also a Quick Map Plot, but has better documentation
x <- crime[,c(1:5, 16,17)]; x <- subset(x, offense=='murder')
qmplot(lon, lat, data=x, colour=I('red'), size=I(1), darken=0.1)

# =============== 3d maps =============== #
# We can plot 3D globe maps with threejs library
library(threejs)
x <- maps::world.cities[order(maps::world.cities$pop, decreasing=TRUE),]
x$percent.of.max <- 100*x$pop / max(x$pop)
globejs(lat=x$lat, long=x$long, value=x$percent.of.max, atmosphere = TRUE)


# ======================================== #
#                  Colors
# ======================================== #
# We can use colors when we plot. Colors can be specified with strings or hex
# There also exists color ramp functions which can interpolate values to create color palettes
# There is more informaiton about several color palettes here
?topo.colors

# This creates a function
# Some plotting methods accepts such a function directly
colorRampPalette(c("green", "red"))

# When we call the function with a parameters, we recieve so many colors
colorRampPalette(c("green", "red"))(10)

# We can index a color out of that
colorRampPalette(c("green", "red"))(10)[3]

# ======================================== #
#               Statistics
# ======================================== #

# =============== Basic statistics =============== #
mean(1:10)          # Mean of values
sd(1:10)            # Standard deviation of values. How much does the values differ from the mean
var(1:10)           # Variance of values. Square of standard devience
median(1:10)        # The median of values
sd(1:10)/10         # Standard error
cor(USArrests)      # Calculates correlation between columns. 1 = positive correlation. -1 = negative correlation
cov(USArrests)      # Another way to calculate relation between data, but harder to interpret thar correlation


# =============== Convenient statistics =============== #
# summarySE calculates statistics for a column, grouped by a set of columns
# It calculates count, mean, standard deviation, standard error and 95 % confidence interval
library(Rmisc)
summarySE(diamonds, measurevar='price', groupvar=c('cut', 'color'))

# ggpairs calculates covariance between columns and presents results as a plot
library(GGally)
ggpairs(diamonds[,c(1,6,7)])

# chart.Correlation plots a correlation matrix for numeric values
library(PerformanceAnalytics)
chart.Correlation(USArrests)

# barplot quickly gives us an overview over how data is distributed in different groups
boxplot(absent~race+school, data=HSAUR3::schooldays)

# Calculate distribution of continous variables group by a variable
library(psych)
a <- describeBy(x[, 3:8], x$School_Type); a
a$`Lib Arts` %>% select(vars, n, mean, sd, median, min, max, range, se)


# ======================================== #
#           Hypothesis Testing
# ======================================== #
# Hypothesis testing is used to determine the probability that a hypothesis is true
# The null hypothesis is ALWAYS that there is NO significant difference between the data
# The alternate hypothesis is that there IS a significant difference between the data
# alpha = the level of significance 
# If p < 0.05, we can usually say that the values are significantly different,
# Then we can discard the null hypothesis

# =============== Two sample t-test =============== #
# t-tests compares means between two groups and looks if they are significantly different
# numeric~grouping. 
# expend in this case is the numeric column, which is used to calculate the means
# stature in this case is the column that is used to group the rows. It must have exactly two values
t.test(expend~stature, data=ISwR::energy)


# ======================================== #
#             Contingency tables
# ======================================== #
# Contingency tables are used to count occurences within data. They make it possible
# to find out occurences based on grouping. The table will have as many dimensions as 
# grouping variables we use

# xtabs accepts a formula on the form numeric~grouping. If you leave numeric empty, it will count rows

# =============== One way contingency tables =============== #
# One way tables are when the contingency table has one dimension
xtabs(~cyl, data=mtcars)              # Counts row count per unique value of cyl
xtabs(hp~cyl, data=mtcars)            # Sums all hp for every unique value of cyl

# =============== Two way contingency tables =============== #
# Two way tables is when the contingency table has two dimension
xtabs(hp~cyl+gear, data=mtcars)       # Sums all hp for every unique combination of cyl and gear

# =============== Three way contingency tables =============== #
# Three way table is when the contingency table has three dimensions
x <- xtabs(Freq ~ Hair+Eye+Sex, data=data.frame(HairEyeColor)); x
# It can be hard to reason about this output. We can pretty print like this
ftable(x)

# =============== Inspecting contingency tables =============== #
x <- xtabs(hp~cyl+gear, data=mtcars)
addmargins(x)                         # Adds sum count for every row and column in x
addmargins(x, 1)                      # Adds sum count for every column in x
addmargins(x, 2)                      # Adds sum count for every row in x

prop.table(x)                         # Calculates percentage for every cell
prop.table(x, 1)                      # Calculates row percentage for every cell 
prop.table(x, 2)                      # Calculates column percentage for every cell


# =============== Plotting contingency tables =============== #
# We can print contingency tables of any dimension in a visually consumable way with ftable
ftable(x)

# One way contingency can easily be plotted with barplots
x <- xtabs(~cyl, data=mtcars)
barplot(x, col=2:4, legend=TRUE, beside=TRUE)

# One and Two way Contingency can easily be plotted with balloonplots
library(gplots)
x <- xtabs(~cyl+gear, data=mtcars)
balloonplot(t(x), label=TRUE)
# And also doubledecker plots
doubledecker(x)

# One, Two and Three way contingency can easily be plotted with mosaic plots
library(grid); library(vcd)
x <- xtabs(Freq ~ Hair+Eye+Sex, data=data.frame(HairEyeColor))
mosaic(x, shade=TRUE)


# ======================================== #
#             Chi square tests
# ======================================== #
# Chi square tests is a form of hypothesis testing. Null hypothesis is always that the 
# data is equally distributed
# Chi square tests are used to see whether an observed frequency distribution 
# differs from a theoretical distribution. 
# With this, we can see if a data is significantly different from each other
# We can call this a Test of Goodness of Fit

# If the p-value < 0.05 we can discard the null hypothesis which means that the 
# we can assume that the data is not equally distributed

# The Chi-square value is often times called X^2

# Expected frequency: E = n/# of categories (perfectly even distribution)

# =============== One way chi square tests =============== #
# One way chi square tests are used on one way contingency tables
# Degree of freedom: df = #categories - 1
x <- xtabs(count~spray, data=InsectSprays)
chisq.test(x)
# p-value =2.2e-16 is way smaller than 0.05, so the data is not equally distributed


# =============== Two way chi square tests =============== #
# Two way chi square tests are used on two way contingency tables
# Degree of freedom: df = #rows-1 * #columns-1
x <- xtabs(Freq ~ Hair+Eye, data=data.frame(HairEyeColor))
chisq.test(x)
# For two way chi square tests, we can also use CrossTable which provides a lot more information
library(gmodels)
CrossTable(x, prop.c=FALSE, prop.chisq = FALSE, prop.t=FALSE, expected=TRUE, format="SPSS")

# =============== Three way chi square tests =============== #
# Three way chi sqaure tests are used on three way contingency tables
# Degree of freedom: df = #dimension1-1 * #dimension2-1 * #dimension3-1
x <- xtabs(Freq ~ Hair+Eye+Sex, data=data.frame(HairEyeColor))
mantelhaen.test(x)


# =============== Finding critical chi squared =============== #
# This returns the critical chi squared value
# 0.95 = accuracy
# 5 = degree of freedom
qchisq(0.95, 5)

# =============== Hanging chi gram plot =============== #
# This plots the standard residual for every group.
# It visualizes the how every group differers from the expected
# For one dimensional data
x <- xtabs(count~spray, data=InsectSprays)
n <- sum(InsectSprays$count)
categories.count <- length(unique(InsectSprays$spray))
e <- rep(n/categories.count, categories.count)
cgram <- (x-E)/sqrt(E)
barplot(cgram, col=ifelse(cgram>0, "red", "blue"))

# For more than one dimensional data, we can use a convenient method
x <- xtabs(Freq ~ Hair+Eye, data=data.frame(HairEyeColor))
library(grid); library(vcd)
assoc(x, shade=TRUE)


# ======================================== #
#                  Regression
# ======================================== #
# =============== Linear regression =============== #
# Linear regression creates models which we can use to predict continous values

# =============== Univariate linear regression =============== #
# lm accepts a formula as its first argument. It is on the form y ~ x
x <- lm(Employed ~ GNP, data=longley); x

x# =============== Multivariate linear regression =============== #
# For multivariate regression, the formula should be on the form y ~ x1 + x2 + x3 + ... xn
x <- lm(Employed ~ GNP + Armed.Forces, data=longley); x

# =============== Logistic regression =============== #
# Logistic regression creates models which we can use to predict the possibility of something
# Odds = p(success) / p(failure)
# Oddsratio for coefficient B1 = e^B1
# The odds ratio tells us that for every one increase in B1, the odds for y = 1 increases by odds ratio times

# =============== Univariate logistic regression =============== #
# Logit(P) = B0 + B1*x. 0 =< P =< 1 
# To get x where p=0.5, -B0/B1

# glm accepts a formula as its first argument. It is on the form y ~ x
x <- glm(badh ~ age, data=LOGIT::badhealth, family=binomial); x
# To calculate the probability of an x, given an univariate logistic 
# regression model use this function
predict.logistic.uni = function(glm, x) {
  return(1/(1+exp(-glm$coefficients[1]-glm$coefficients[2]*x)))
}

# =============== Multivariate logistic regression =============== #
# Logit(P) = B0 + B1*x1 + B2*x2 + ...Bn*xn. 0 =< P =< 1 
# glm accepts a formula as its first argument. It is on the form y ~ x1 + x2 + ... xn
x <- glm(badh~numvisit+age, family=binomial, data=LOGIT::badhealth); x
# To calculate the probability of an x, given an multivariate logistic
# regression model, use this function
predict.logistic.multi = function(glm, x) {
  coefs = glm$coefficients[c(-1)]
  logitP = sum(c(glm$coefficients[1], coefs*x))
  return(1/(1+exp(-logitP)))
}

# We can test the goodness of fit for a logistic regression model 
# If the p-value < 0.05 it means that the model is not a good fit
library(vcdExtra)
HLtest(model=x)


# =============== Inspecting regression models =============== #
# We can inspect a regression model with summary()
# This tells us many things:
# __p-value___
# if p-value < 0.05 the model/relation is significantly correlated
# __Coefficient of determination___
# Also known as R^2. A value between 0 and 1. 
# The larger the value, the better. A value of one means the regression fits the data perfectly
summary(x)

# We can plot the coefficients of a regression model to understand them better
library(coefplot)
coefplot(x)

# A regression models has a few useful parameters aswell. These can be inspected with autocomplete
x$fitted.values
x$residuals
x$coefficients


# ======================================== #
#     Analysis of variance(ANOVA/MANOVA)
# ======================================== #
# ANOVA is used to to investigate relationship between categorial 
# independent variables and continous dependent variables

# ANOVA tests tells us if there is atleast one group which is not like the others
# we do not know if all groups are different thought.
# To get more detailed insight, we have to perform a POST HOC test such as Tukey test

# =============== One way ANOVA =============== #
# One way ANOVA is used to determine if there is a significant difference
# between the means of two or more independent groups
# aov() accepts a forumla as its first input. It is on the form y ~ x
# y is a continous variable
# x is a categorial variable with atleast two groups 
x <- aov(count~spray, data=InsectSprays); x
summary(x)

# It is a good idea to calculate the means and plot the data for better insight
with(InsectSprays, tapply(count, spray, mean))      # Calculate means
plot.design(count~spray, data=InsectSprays)         # Plotting
boxplot(count~spray, data=InsectSprays)             # Plotting

# =============== Two way ANOVA =============== #
# aov accepts a formula as its first input. It is on the form y ~ xn
# We can use it in two ways, either we can use the the x's by themselves
# or make an extra x, which is a combination between two x. We call this interaction

# The plus sign adds another x without any interaction
x <- aov(absent~race+school, data=HSAUR3::schooldays); x
summary(x)

# The star sign adds another x with interaction between the surrounding x's
x <- aov(absent~race*school, data=HSAUR3::schooldays); x
summary(x)

# It is a good idea to calculate the means and plot the data for better insight
model.tables(x, "means")                            # Calculate means
# This how the means differs 
with(HSAUR3::schooldays, interaction.plot(
  x.factor=school, trace.factor=race, response=absent, col=2:3
))


# =============== Post Hoc Test =============== #
# Post Hoc Test tells us how all data differs from eachother
# It accepts an aov as its first input
# Inspect the p adj columns. Every row where p < 0.05 are significantly different
p <- TukeyHSD(x, conf.level=0.95); p
# We can plot the result for easier consumption
plot(p, las=1)


# =============== MANOVA =============== #
# MANOVA is used to analyze data that has two or more dependant variables 
# and one or more dependant variable

# =============== One way MANOVA =============== #
# One way MANOVA has one independant variable and several dependant
# Therefore, the formula is on the form Y1 + Y2 + ... Yn ~ x
# It is important that Y is a column, therefore we must put it in with the help of cbind
x <- read.csv('practice/ComparingColleges.csv', header=TRUE)
Y <- with(x, cbind(SAT, Acceptance, StudentP, PhDP, GradP, Top10P))
x <- manova(Y ~ School_Type, data=x); x
summary(x)
# If p-value < 0.05 it means that there is significant difference in the groups,
# for atleast one of the Y values we used. We do not know which

# If we use summary.aov on the MANOVA model, we will get the p-value for each Y value
summary.aov(x)

# To further learn about the differences, we have to manually calculate the means and look at them
plot.design(x$Top10P ~ x$School_Type)
plot.design(x$PhDP ~ x$School_Type)
plot.design(x$StudentP ~ x$School_Type)