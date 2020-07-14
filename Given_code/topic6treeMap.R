library(ggraph)
library(igraph)

flare1<-flare
flare1$vertices$mylabels=flare$vertices$shortName
graph <- graph_from_data_frame(flare1$edges, vertices = flare1$vertices)

ggraph(graph, 'treemap', weight = 'size') + 
  geom_node_tile(aes(fill = depth), size = 0.25)+
  geom_node_text(aes(label=mylabels), size=3)

devtools::install_github("d3TreeR/d3TreeR")

library(treemap)
library(d3treeR)
data(GNI2014)
d3tree2(treemap(GNI2014,
        index=c("continent", "iso3"),
        vSize="population",
        vColor="GNI",
        type="value",
        format.legend = list(scientific = FALSE, big.mark = " ")),
rootname = "World")
