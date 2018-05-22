# Exercise 17

# Assignment 1
library(igraph)
gt <- graph_from_literal(A-+B, A-+C, A-+D,
                         B-+A, B-+D, B-+E,
                         C-+B, C-+D, D-+B, D-+C,
                         E-+B, E-+C)
igraph.options(vertex.size=35, edge.arrow.size=0.4, edge.color=1)
plot(gt, layout=layout.auto, vertex.color='cyan')


# Assignment 2
bsk <- read.table('edgesdata3.txt', header=T)
bsk.network <- graph.data.frame(bsk, directed=FALSE)

# Remove nodes with less than 3 edges
bad.vs <- V(bsk.network)[degree(bsk.network)<3]
bsk.network <- delete.vertices(bsk.network, bad.vs)

# Set vertex color based on name
V(bsk.network)$color <- ifelse(V(bsk.network)$name=='CA', 'blue', 'red')

# Set edge color based on the edge column
E(bsk.network)$color <- ifelse(E(bsk.network)$grade==9, "red", "grey")

# Set edge color based on the spec column
E(bsk.network)$color <- ifelse(E(bsk.network)$spec=='X', "red", ifelse(E(bsk.network)$spec=='Y', "blue", "grey"))

# Set vertex size based on amount of connecting edges
V(bsk.network)$size <- degree(bsk.network)/10

par(mai=c(0,0,1,0)) 			
plot(bsk.network,			
     layout=layout.fruchterman.reingold,	# the layout method. see the igraph documentation for details
     main='My graph',	#specifies the title
     vertex.label.dist=0.5,			#puts the name labels slightly off the dots
     vertex.frame.color='blue', 		#the color of the border of the dots 
     vertex.label.color='black',		#the color of the name labels
     vertex.label.font=2,			#the font of the name labels
     vertex.label=V(bsk.network)$name,		#specifies the lables of the vertices. in this case the 'name' attribute is used
     vertex.label.cex=1			#specifies the size of the font of the labels. can also be made to vary
)

# Assignment 3
library(geomnet)
data(bikes, package= 'geomnet')

library(ggnetwork)
tripnet <- fortify(as.edgedf(bikes$trips), bikes$stations[,c(2,1,3:5)])
tripnet$Metro <- FALSE
idx <- grep("Metro", tripnet$from_id)
tripnet$Metro[idx] <- TRUE

library(ggmap)
map <- get_map(location = c(left = -77.22257, bottom = 39.05721,
                            right = -77.11271, top = 39.14247))


ggmap(map) + 
  geom_net(data = tripnet, labelon = FALSE, layout.alg = NULL, ealpha = 0.4,
           aes(from_id = from_id, to_id = to_id, 
               x = long, y = lat,
               linewidth = n / 15, colour = Metro
           )
  )

