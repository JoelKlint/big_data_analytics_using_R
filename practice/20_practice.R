# === (20) Bayesian Network === #

#page 5
# install.packages("bnlearn")
library(bnlearn)
head(coronary)
str(coronary)

#page 6
bn.hc <- hc(coronary, score="bic")
bn.hc

#page 7
plot(bn.hc, main="Hill-Climbing algorithm")
edges <- arcs(bn.hc)
nodes <- nodes(bn.hc)
library(igraph)
net <- graph.data.frame(edges,directed=T,vertices=nodes)
plot(net,vertex.label=V(net)$name,vertex.size=30,
     edge.arrow.size=0.3, vertex.color="cornsilk")

#page 8
x <- coronary
sum(x$Pressure==">140" & x$Smoking=="yes")/sum(x$Smoking=="yes")
prop.table(table(x[,c("Pressure","Smoking")]), margin=2) #column fraction
bnh <- hc(coronary, score="bic")
bnfit <- bn.fit(bnh, data=coronary, method="bayes")
bnfit$Pressure

#page 9
cpquery(bnfit, event=(Proteins=="<3"), evidence=(Smoking=="no"), method="ls", n=10^7)
cpquery(bnfit, Proteins=="<3", list(Smoking="no"), method="lw", n=10^7)
cpquery(bnfit, Proteins=="<3", (Smoking=="no" & Pressure==">140"), n=10^7)
cpquery(bnfit, event=(Pressure==">140"), list(Proteins="<3"), method="lw", n=10^7)

#page 10
library(lattice)
bn.fit.barchart(bnfit$Pressure, main="Pressure Against Smoking",
                xlab="Pr(Pressure|Smoking)", ylab="")
bnfit$Pressure

#page 11
library(bnlearn)
str(marks)
head(marks)

#page 12
bnhc <- hc(marks, score="bic-g")
bnhc

#page 13
library(igraph)
edges=arcs(bnhc)
nodes=nodes(bnhc)
net <- graph.data.frame(edges,directed=T,vertices=nodes)
plot(net,vertex.label=V(net)$name,vertex.size=40,
     edge.arrow.size=0.3,vertex.color="cyan",
     edge.color="black")

#page 14
# install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(marks,pch=21,histogram=TRUE)

#page 15
# install.packages("deal")
library(deal)
data(ksl); head(ksl,2); str(ksl)

#page 16
ksl.nw <- network(ksl)          # specify prior network
ksl.prior <- jointprior(ksl.nw) # make joint prior distribution
ksl.nw <- learn(ksl.nw,ksl,ksl.prior)$nw
ksl.nw

#page 17
result <- heuristic(initnw=ksl.nw, data=ksl, prior=ksl.prior,
                    restart=2, degree=10, trace=FALSE)
win.graph(width=7,height=7)
plot(getnetwork(result))

#page 18
library(igraph)
mx <- matrix(c(0,0,1,0,0,0,0,0,0, 0,0,0,1,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,
               0,0,1,0,0,0,0,0,0, 1,0,0,0,0,1,0,0,0, 0,0,0,0,0,0,1,0,0,
               0,0,0,0,0,0,0,1,0, 1,1,0,1,1,1,0,0,0, 1,1,0,0,1,1,1,0,0),
             nrow=9, byrow=T, dimnames=list(NULL,names(ksl)))
knet <- graph.adjacency(mx)
V(knet)$color <- c(rep("cornsilk",4),rep("cyan",5))
plot(knet,edge.arrow.size=0.4,edge.color="gray47",vertex.label.color="black",
     vertex.label.cex=1.2,vertex.size=30,layout=layout.circle)
