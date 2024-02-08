
library(igraph)
library(ggraph)

NUM_EDGES <- 759
NUM_NODES <- 250

# Create a sample weighted graph
set.seed(42)
nodes <- data.frame(id = 1:NUM_NODES)
edges <- data.frame(from = sample(1:NUM_NODES, NUM_EDGES, replace = TRUE),
                    to = sample(1:NUM_NODES, NUM_EDGES, replace = TRUE),
                    weight = runif(NUM_EDGES))

graph <- graph_from_data_frame(edges, directed = FALSE, vertices = nodes)

# Create a layout based on edge weights
weights <- edges$weight
scaled_weights <- weights / max(weights)  # Scale weights to [0, 1]

# Use layout_nicely and adjust node positions based on scaled weights
layout_weights <- layout_nicely(graph) + scaled_weights * 0.1  # Adjust the scaling factor as needed

# Visualize the graph
ggraph(graph, layout = layout_weights) +
  geom_edge_link(aes(edge_alpha = weight), edge_colour = "blue", edge_linetype = 1) +
  geom_node_point() +
  theme_void()
