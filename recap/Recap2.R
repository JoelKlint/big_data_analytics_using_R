# Author: Joel Klint

# ======================================== #
#               Trees
# ======================================== #

# =============== Regression trees =============== #
# Used to predict continous variable from one or more continous or categorial variables
# Lecture 12 slide 4
library(rpart)
data(bodyfat, package="TH.data")
rfit <- rpart(DEXfat ~ age+waistcirc+hipcirc+elbowbreadth+kneebreadth,
              data=bodyfat, method="anova", control=rpart.control(minsplit=10))


# You can predict with a regression tree
DEXfat_pred <- predict(rfit, newdata=bodyfat)
xlim <- range(bodyfat$DEXfat)
plot(DEXfat_pred ~ DEXfat, data=bodyfat, xlab='Observed', ylab='Predicted',
     ylim=xlim, xlim=xlim, pch=12, bg='cyan')
abline(a=0, b=1, col='red')

# You can plot trees to inspect them
plot(rfit, uniform=TRUE)
text(rfit, use.n=TRUE, all=TRUE, cex=0.8)

# You can plot trees more beautiful with partykit
library(grid); library(partykit)
plot(as.party(rfit), tp_args=list(id=FALSE))

# =============== Classification trees =============== #
# Used to predict categorial variable from one or more continous or categorial variables
# Lecture 12 slide 9
data(GlaucomaM, package='TH.data')
library(rpart)
# ctree is the best way to create a classification tree
cfit <- ctree(Class ~ ., data=GlaucomaM)

# You can also create a classification tree with rpart.
cfit2 <- rpart(Class ~ ., data=GlaucomaM, method='class')

# You can plot trees to inspect them
plot(cfit, uniform=TRUE)

# You can plot trees more beautiful with partykit
library(grid); library(partykit)
plot(as.party(cfit2), tp_args=list(id=FALSE))

# =============== Qualitative interaction trees =============== #
# Used to see how interaction among variables are.
# Lecture 12 slide 15


# ======================================== #
#               Random forests
# ======================================== #
# Random forests create a bunch of trees at random. These are then used to provide
# a single prediction.

# =============== Random forest regression =============== #
# Lecture 13 slide 3
data(Boston, package='MASS')
train <- sample(1:nrow(Boston), 300)
library(randomForest)
rf <- randomForest(medv ~ ., data=Boston, importance=TRUE, subset=train)

# We can inspect the error in relative to the amount of trees
plot(rf, main='Error relative to amount of trees')

# We can extract variable importance
importance(rf)# TODO: How do I interpret this?
# %IncMSE --> How much the error will go up if this variable is removed --> You want big
# IncNodePurity --> Not sure, but I think this is the error of the node --> You want small

varImpPlot(rf, scale=TRUE, main='Variable importance')

# We can also create regression with tree function
mtree <- tree(medv ~ ., data=Boston, subset=train, na.action=na.omit)
plot(mtree); text(mtree)


# =============== Random forest classification =============== #
# Lecture 13 slide 10

library(randomForest)
iris_rf <- randomForest(Species ~ ., data=iris, importance=TRUE, 
                        method='class', proximity=TRUE)

# Plot errors relative to trees
plot(iris_rf, col=1:4, lty=c(1,1,1,1), main='Iris random forest errors')
legend('topright', colnames(iris_rf$err.rate), col=1:4, 
       lty=c(1,1,1,1), bty='n', y.intersp=0.5)

# We can inspect the predicted groups on a 2D plot
cls <- as.factor(iris_rf$predicted)
ggplot(iris, aes(Petal.Length,Petal.Width,color=cls)) +
  geom_point() + stat_ellipse() + theme_bw() +
  theme(legend.justification=c(1,0),legend.position=c(1,0))


# ======================================== #
#               Clustering
# ======================================== #
# Group data

u="http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"
wine <- read.csv(u)
colnames(wine) <- c("Cultivar","Alcohol","Malic.acid","Ash",
                    "Alcalinity.of.ash","Magnesium","Total.phenols","Flavanoids",
                    "Nonflavanoid.phenols","Proanthocyanins","Color.intensity","Hue",
                    "OD280.OD315.of.diluted.wines","Proline")
Wine <- wine[,-1] #exclude the first column

# =============== Optimal number of clusters =============== #
# Lecture 14, slide 3
# It is impossible to say the ideal number of clusters,
# it depends on the parameters and functions used for evaluation

# NbClust spits out the number directly
library(NbClust)
NbClust(Wine, method='complete', index='hartigan')$Best.nc
NbClust(Wine, method='complete', index='kl')$Best.nc

# gap is another metric. The point is to take the amount of clusters
# which minimizes the gap value
library(cluster)
Gap <- clusGap(Wine, FUNcluster=pam, K.max=15)
Gap_df <- as.data.frame(Gap$Tab); Gap_df
library(ggplot2)
ggplot(Gap_df, aes(x=1:nrow(Gap_df))) +
  geom_line(aes(y=gap),color="red") +
  geom_point(aes(y=gap),color="red") +
  geom_errorbar(aes(ymin=gap-SE.sim,ymax=gap+SE.sim),color="red") +
  labs(x="Number of Clusters",y="Gap")

# =============== K means clustering =============== #
# k-means does not work with categorical data
# k-means is weak for outliers
clusterCount = 3
kc <- kmeans(mtcars, centers=clusterCount, nstart=4)

# Silhouette plots describe the goodness of the clustering
# you want to have high numbers
# Lecture 14 slide 11
sobj <- silhouette(kc$cluster, dmatrix=as.matrix(dist(mtcars)))
summary(sobj)
plot(sobj, col=2:4)

# Cluster plots
clusplot(mtcars, kc$cluster, color=TRUE, shade=TRUE, labels=2)


# =============== K mediods clustering =============== #
# lecture 14 slide 13
library(cluster)
pamx <- pam(mtcars, 3)
summary(pamx)

# We can plot a k-mediods cluster.
# we then get the clusterplot and silhouette plot
plot(pamx)


# =============== Clara clustering =============== #
# lecture 14 slide 15
clx3 <- clara(xclara, 3)

# Visualize clustering results
library(factoextra)
fviz_cluster(clx3, geom='point', frame.type='norm')


# =============== Hierchical clustering =============== #
hcst <- hclust(dist(USArrests, method='euclidian'), method='complete')
plot(hcst, labels=rownames(USArrests), cex=0.8)
rect.hclust(hcst, 3)

# We can cut the tree into groups of data
cn <- cutree(hcst, k=3)
table(cn)
aggregate(USArrests, FUN=mean, by=list(cn))
# What we see is the mean of every variable, for every group


# ======================================== #
#             Association rules
# ======================================== #
# Assiciation rules helps us learn how data is connected to each other.
# A rule could for example be, if a customer buys milk, they also buy eggs
# lecture 15

# =============== Most frequent items =============== #
library(arules)
data(Groceries)
fItem <- eclat(Groceries, parameter=list(supp=0.05, maxlen=15))
sort_gItem <- sort(fItem, by='support')

# We can also plot the frequencies
itemFrequencyPlot(Groceries, topN=15, type='absolute')

# =============== Finding rules =============== #
# Lecture 15 slide 10
# This finds all rules that meet the support, conf and maxlen criterias
rules <- apriori(Groceries, parameter=list(supp=0.001, conf=0.9, maxlen=4))
lift_rules <- sort(rules, by='lift')
inspect(lift_rules[1:5])

# We can also look for rules with specific items on left or right side
rules <- apriori(Groceries, parameter=list(supp=0.0015, conf=0.3),
                 appearance=list(default='lhs', rhs='bottled beer'))
beer_rules <- sort(rules, by='lift')
inspect(beer_rules)

# =============== Visualizing rules =============== #
library(arules); library(arulesViz)
rules <- apriori(Groceries, parameter=list(supp=0.0015, conf=0.3),
                 appearance=list(default='lhs', rhs='bottled beer'))
plot(rules, method='graph', measure='confidence', shading='lift',
     control=list(type='items'))



# ======================================== #
#             Text mining
# ======================================== #
# Lecture 17

# =============== Get text =============== #
# Download and clean text
url <- 'https://www.voanews.com/a/text-of-trump-speech-to-south-korean-national-assembly-/4106294.html'
library(XML); library(bitops); library(RCurl)
htm <- getURL(url)
doc <- htmlParse(htm, asText = TRUE)
ptx <- xpathSApply(doc, "//p", xmlValue)
star <- paste(ptx, collapse = '\n')

# Load into R structure
library(NLP); library(tm)
corp <- Corpus(VectorSource(star))
corp <- tm_map(corp, removePunctuation)
corp <- tm_map(corp, tolower)
corp <- tm_map(corp, removeNumbers)
corp <- tm_map(corp, removeWords, stopwords('english'))
corp <- tm_map(corp, removeWords, c('can','far','live','now','one','say','will'))
corp <- tm_map(corp, PlainTextDocument)

dtm <- DocumentTermMatrix(corp)
Freq <- sort(colSums(as.matrix(dtm)), decreasing = TRUE)

# =============== Word cloud =============== #
library(RColorBrewer); library(wordcloud)
wf <- data.frame(Word=names(Freq), Freq=Freq)
wordcloud(words=wf$Word, freq=wf$Freq, min.freq=3, random.order=FALSE,
          rot.per=0.35, colors=brewer.pal(8,'Dark2'))

# =============== Plot word frequency =============== #
library(ggplot2)
ggplot(subset(wf, Freq>5), aes(Word,Freq)) + 
  geom_bar(stat='identity', fill='green') + theme_bw() + 
  theme(axis.text.x=element_text(angle=0, hjust=1)) + coord_flip()


# =============== Comparision cloud =============== #
# Plots two wordclouds next to each other
# Lecture 17 slide 8
library(tm); library(wordcloud)
data(SOTU)
library(NLP); 
corp <- tm_map(SOTU, removePunctuation)
corp <- tm_map(corp, content_transformer(tolower))
corp <- tm_map(corp, removeNumbers)
corp <- tm_map(corp, function(x)removeWords(x, stopwords()))
tmx <- TermDocumentMatrix(corp)
tmx <- as.matrix(tmx)
colnames(tmx) <- c('SOTU 2010', 'SOTU 2011')
comparison.cloud(tmx, colors=c('red', 'blue'), max.words=60)

# =============== Comonality cloud =============== #
# Only plot words that appear in both texts, with their combined frequency
# Lecture 17 slide 8
commonality.cloud(tmx, max.words=50, random.order=FALSE)


# ======================================== #
#         Social network analysis
# ======================================== #
# Lecture 18

# =============== igraph =============== #
library(igraph)
gt <- graph_from_literal(A-+B, A-+C, A-+D, B-+E, B-+F, C-+G)
igraph.options(vertex.size=35, edge.arrow.size=0.4, edge.color=1)
plot(gt, layout=layout.auto, vertex.color='cyan')

# We can create a graph from a data frame with describes the edges
url <- 'http://www.dimiter.eu/Data_files/edgesdata3.txt'
dat <- read.table(url, header=TRUE)
gdf <- graph.data.frame(dat)
plot(gdf, edge.arrow.size=0.2, vertex.label.cex=0.7, vertex.size=15,
     vertex.color='ivory', edge.arrow.size=0.5, edge.color='deepskyblue')

vcount(gt)
ecount(gt)

# You can add information about nodes from a separate data frame.
# See lecture 18 slide 7

# You can also create a graph from a matrix which describes the edges between nodes
# See lecture 18 slide 8


# =============== ggnetwork =============== #
# We can plot graphs created with igraph, and also graphs created with ggnetwork
library(ggnetwork)
data(flo, package='network')
gnet <- ggnetwork(flo)
library(ggplot2)
ggplot(gnet, aes(x, y, xend=xend, yend=yend)) + 
  geom_edges(alpha=0.5) + 
  geom_nodes(size=12, color='aliceblue') + 
  geom_nodetext(aes(label=vertex.names), fontface='bold') + 
  theme_blank()

# Fortify does not seem to work. If needed, it can be read about in lecture 18 slide 14

# geom_net is a ggplot2 method for plotting networks. Lecture 18 slide 15

# tkplot
library(igraph)
net <- graph.star(26, mode='undirected')
V(net)$name <- LETTERS[1:26]
V(net)$size <- ifelse(V(net)$name == 'A', 20, 10)
tkplot(net, edge.color='blue', vertex.label.color='black', vertex.label=V(net)$name,
       vertex.color=c('red', rep('cyan', 25)))

# tkplot does not seem to work on macos


# =============== qgraph =============== #
data(USairpollution, package='HSAUR3')
library(qgraph)
cor_usa <- cor_auto(USairpollution)
qgraph(cor_usa, layout='spring', color='cornsilk', posCol='red', negCol='blue')


# =============== Graph characteristics =============== #
# What these means can be read in lecture 19 slide 2
# There is more to read about
library(igraph)
gs <- graph.star(7, mode='undirected')
plot(gs, vertex.color=c('red', rep('cyan', 6)))

degree(gs)
betweenness(gs)
closeness(gs)
evcent(gs)$vect # Eigenvector


# =============== Graph partitioning =============== #
# Lecture 19 slide 8
library(igraph); library(igraphdata); 
data(karate)
kc <- cluster_fast_greedy(karate)
sizes(kc)
plot(kc, karate)
plot_dendrogram(kc)


# =============== Exponential random graph =============== #
# Lecture 19 slide 10
# Not really sure what this is

# =============== JavaScript network graphs =============== #
# Lecture 19 slide 14
# Just plotting when reading JSON and using JavaScript for plotting

# =============== Interactive 3D plots =============== #
# Lecture 19 slide 17


# ======================================== #
#             Baysian networks
# ======================================== #
# Lecture 20
# Coorelating things. Makes use able to reason about if one thing leads to another

library(bnlearn)
bn.hc <- hc(coronary, score='bic')

plot(bn.hc, main='Hill-Climbing algorithm')

edges <- arcs(bn.hc)
nodes <- nodes(bn.hc)
library(igraph)
net <- graph.data.frame(edges, directed=TRUE, vertices=nodes)
plot(net, vertex.label=V(net)$name, vertex.size=30, edge.arrow.size=0.3,
     vertex.color='cornsilk')

# =============== Conditional probability =============== #
bnh <- hc(coronary, score='bic')
bnfit <- bn.fit(bnh, data=coronary, method='bayes')
bnfit$Pressure

# We can also plot the conditional probabilities
library(lattice)
bn.fit.barchart(bnfit$Pressure, main='Pressure against smoking', 
                xlab='Pr(Pressure|Smoking)', ylab='')

# We can also create custom queries with cpquery
# What is the prob of a non-smoker has protein level lower than 3?
cpquery(bnfit, event=(Proteins=='<3'), evidence=(Smoking=='no'), method='ls', n=10^7)
cpquery(bnfit, Proteins=='<3', list(Smoking='no'), method='lw', n=10^7)


# =============== Correlation between continous nodes =============== #
# Lecture 20 slide 14
library(PerformanceAnalytics)
chart.Correlation(marks, pch=21, histogram=TRUE)


# =============== Hybrid networks =============== #
# Continous and categorical attributes
# Lecture 20 slide 16
library(deal)
data(ksl)
ksl.nw <- network(ksl)
ksl.prior <- jointprior(ksl.nw)
ksl.nw <- learn(ksl.nw, ksl, ksl.prior)$nw
ksl.nw
# This does not work

# We can increase the network score by doing local perbutations
# Lecture 20 slide 17
