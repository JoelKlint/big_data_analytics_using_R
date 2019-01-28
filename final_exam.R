# Final exam

library(tm); library(wordcloud)
data(SOTU)
#library(NLP); 
corp <- tm_map(SOTU, removePunctuation)
corp <- tm_map(corp, content_transformer(tolower))
corp <- tm_map(corp, removeNumbers)
corp <- tm_map(corp, function(x)removeWords(x, stopwords()))
rword <- c('also', 'can', 'new', 'now', 'one', 'take', 'will')
corp <- tm_map(corp, removeWords, rword)
tmx <- TermDocumentMatrix(corp)
tmx <- as.matrix(tmx)
vx <- sort(rowSums(tmx), decreasing = TRUE)
df <- data.frame(word=names(vx), freq=vx)
wordcloud(df$word, df$freq, random.order=FALSE, min.freq=15)

barplot(head(vx, 15), names.arg=names(head(vx, 15)), xlab='Frequency', horiz=TRUE, cex.names=0.8, las=2)




# 3
data(readingSkills, package='party')
library(randomForest)
skills_rf <- randomForest(nativeSpeaker ~ ., data=readingSkills, importance=TRUE, 
                        method='class', proximity=TRUE)
#oob = out of bag
print(skills_rf)
importance(skills_rf)
varImpPlot(skills_rf, scale=TRUE, main='Variable importance')




# 4
library(igraph)
nets <- c('Anna', 'Brian', 'David', 'Elsa', 'Jane', 'John')
N <- array(c(0,0,0,0,0,0,
             1,0,1,0,1,0,
             0,1,0,1,1,0,
             1,1,0,0,0,0,
             0,0,0,0,0,0,
             0,0,1,1,0,0
             ),
           dim=c(6,6), dimnames=list(nets, nets))
g <- graph.adjacency(N)

V(g)$color <- ifelse(V(g)$name=='John', 'gray', 'white')
V(g)$size <- 30
E(g)$color <- 'black'
E(g)$arrow.size <- 0.3
V(g)$label.color <- 'black'
plot(g)



# 5
data(stackloss)
library(NbClust)
NbClust(stackloss, method='complete', index='hartigan')$Best.nc

hcst <- hclust(dist(stackloss, method='euclidian'), method='complete')
plot(hcst, labels=rownames(stackloss), cex=0.8)
rect.hclust(hcst, 3)


# 6
library(arules)
data(Adult)
itemFrequencyPlot(Adult, topN=10, type="relative")

library(arulesViz)
rules <- apriori(Adult, parameter=list(support=0.1, confidence=0.8, maxlen=10)); rules
rules.sorted <- sort(rules, by='support', decreasing = TRUE)
plot(rules.sorted[1:10], method="graph", measure='confidence', shading='lift', 
     control=list(type='items'))
# We observe that sex and relationship are not included in the top rules
# We observe that the strongest rules for capital gains and loss is with native country and race

# 8
library(psych); library(ca)
data(rareplants, package='DAAG')
plants_ca <- ca(rareplants)
names(plants_ca)
summary(plants_ca)
plot(plants_ca, mass=TRUE, contrib='absolute', map='rowgreen', arrows=c(FALSE, TRUE))


# 9
library(igraph); library(igraphdata); 
data(kite)
kc <- cluster_fast_greedy(kite)
sizes(kc)
plot(kc, kite)
plot_dendrogram(kc)


# 10
library(bnlearn)
head(asia, 3)


bnh <- hc(asia, score='bic')
bnfit <- bn.fit(bnh, data=asia, method='bayes')

nodes <- nodes(bnh)
edges <- arcs(bnh)
library(igraph)
net <- graph.data.frame(edges,directed=T,vertices=nodes)


bnh <- hc(asia, score='bic')
bnfit <- bn.fit(bnh, data=asia, method='bayes')
bnfit$Pressure



tuberculosis <- cpquery(bnfit, event=(T=='yes'), evidence=list(A='yes', S='no'), method="lw", n=10^7)
cancer <- cpquery(bnfit, event=(L=='yes'), evidence=list(A='yes', S='no'), method="lw", n=10^7)
bron <- cpquery(bnfit, event=(B=='yes'), evidence=list(A='yes', S='no'), method="lw", n=10^7)
dys <- cpquery(bnfit, event=(D=='yes'), evidence=list(A='yes', S='no'), method="lw", n=10^7)


tuberculosis <- cpquery(bnfit, event=(T=='yes'), evidence=list(A='yes', S='no', D='no', L='no', B='no'), method="lw", n=10^7)
cancer <- cpquery(bnfit, event=(L=='yes'), evidence=list(A='yes', S='no', T='no'), method="lw", n=10^7)
bron <- cpquery(bnfit, event=(B=='yes'), evidence=list(A='yes', S='no', D='no', T='no', L='no'), method="lw", n=10^7)




