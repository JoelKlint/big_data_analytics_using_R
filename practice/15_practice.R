# === (15) Association Rule Learning === #

#page 6
#install.packages("arules")
library(arules)
data(Groceries)
dim(Groceries)
class(Groceries)
inspect(head(Groceries,4))

#page 7
fItem <- eclat (Groceries, parameter=list(supp=0.05,maxlen=15))
sort_fItem <- sort(fItem, by='support')
inspect(sort_fItem)

#page 8
itemFrequencyPlot(Groceries, topN=10, type="absolute")

#page 9
itemFrequencyPlot(Groceries, topN=15)

#page 11
rules <- apriori(Groceries,
                 parameter=list(supp=0.001,conf=0.9,maxlen=4))
rules
options(digits=4)
lift_rules <- sort(rules, by='lift') #high-lift rules
inspect(lift_rules[1:5])

#page 12
conf_rules <- sort(rules, by='confidence') #high-confidence rules.
inspect(conf_rules[1:5])

#page 13
tab <- crossTable(Groceries)
# Look at first 6 rows and columns
tab[1:6,1:6]
# Specify the rows and columns
tab['bottled beer','bottled beer']
tab['bottled beer','canned beer']

#page 14
rules <- apriori(Groceries, parameter=list(supp=0.0015,conf=0.3),
                 appearance=list(default="lhs",rhs='bottled beer'))
rules
beer_rules <- sort(rules, by='lift')
inspect(beer_rules)

#page 15
tab['bottled beer','red/blush wine']
tab['red/blush wine','red/blush wine']
48 / 189
tab['white wine','white wine']
tab['bottled beer','white wine']
22 / 187

#page 16
library(arules)
#install.packages("arulesViz")
library(arulesViz)
rules <- apriori(Groceries,parameter=list(supp=0.0015,conf=0.3),
                 appearance=list(default="lhs",rhs='bottled beer'))
plot(rules, method="graph", measure='confidence', shading='lift',
     control=list(type="items"))

#page 17
rule2 <- apriori(Groceries,parameter=list(supp=0.001,conf=0.5))
subrule2 <- head(sort(rule2, by='confidence'), 4)
subrule2
plot(subrule2, method='graph',interactive=TRUE, shading=NA)

#page 18
rules <- apriori(Groceries,parameter=list(supp=0.0015,conf=0.3),
                 appearance=list(default="lhs",rhs='bottled beer'))
plot(rules, method="grouped", control=list(type="items"))

#page 19
rules <- apriori(Groceries,parameter=list(supp=0.0015,conf=0.3),
                 appearance=list(default="lhs",rhs='bottled beer'))
plot(rules, method='paracoord',measure='lift', shading='confidence')

#page 20
library(RColorBrewer)
rules <- apriori (Groceries, parameter=list(supp=0.002,conf=0.3))
plot(rules,control=list(col=brewer.pal(11,"Spectral")))

#page 21
str(Titanic)
class(Titanic)
dim(Titanic)
head(as.data.frame(Titanic),10)

#page 22
url <- "http://www.rdatamining.com/data/titanic.raw.rdata"
download.file(url, destfile="titanic.raw.RData", mode="wb")
load("titanic.raw.RData")
head(titanic.raw,4)
summary(titanic.raw)

#page 23
library(arules)
rules <- apriori(titanic.raw,
                 parameter=list(minlen=2,supp=0.005,conf=0.8),
                 appearance=list(rhs=c("Survived=No","Survived=Yes"),
                                 default="lhs"), control=list(verbose=F))
quality(rules) <- round(quality(rules), digits=5)
rules.sorted <- sort(rules, by="lift")
inspect(rules.sorted)

#page 24
inspect(rules.sorted[1:2])

#page 25
library(arulesViz)
plot(rules)

#page 26
plot(rules, method="graph", measure='lift', shading='confidence')

#page 27
plot(rules, method='grouped',measure='lift', shading='confidence')