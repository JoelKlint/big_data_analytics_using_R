# Exercise 19

# Assignment 1
library(bnlearn)
bnh <- hc(asia, score='bic')
bnfit <- bn.fit(bnh, data=asia, method='bayes')
  
nodes <- nodes(bnh)
edges <- arcs(bnh)
library(igraph)
net <- graph.data.frame(edges,directed=T,vertices=nodes)

# Assignment 2
library(lattice)
bn.fit.barchart(bnfit$X, main='Conditional probabilities for variable X')

# Assignment 3
tuberculosis <- cpquery(bnfit, event=(T=='yes'), evidence=list(A='yes', S='no'), method="lw", n=10^7)
cancer <- cpquery(bnfit, event=(L=='yes'), evidence=list(A='yes', S='no'), method="lw", n=10^7)
bron <- cpquery(bnfit, event=(B=='yes'), evidence=list(A='yes', S='no'), method="lw", n=10^7)

#a
if(tuberculosis > cancer && tuberculosis > bron) {
  print("TRUE")
} else {
  print("FALSE")
}

#b
if(cancer > tuberculosis) {
  print("TRUE")
} else {
  print("FALSE")
}

#c
if(bron > cancer && bron > tuberculosis) {
  print("TRUE")
} else {
  print("FALSE")
}

#d
if(tuberculosis > bron) {
  print("TRUE")
} else {
  print("FALSE")
}

# Assignment 4
library(igraph)
plot(net,vertex.label=V(net)$name,vertex.size=30,
     edge.arrow.size=0.3, vertex.color="cornsilk")

