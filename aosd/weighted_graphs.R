
library(igraph)
library(ggraph)




weights <- replace(results$Statistic, is.nan(results$Statistic),1000)
weights <- weights / max(weights)
nodes <- data.frame(id = 1:12, description = patches$area, category = patches$specie)
edges <- data.frame(from = results$Species_1,
                    to = results$Species_2,
                    weight = weights)

graph <- graph_from_data_frame(edges, directed = FALSE, vertices = nodes)


# Use layout_nicely and adjust node positions based on scaled weights
layout_weights <- layout_nicely(graph)
# Visualize the graph with node descriptions
# Visualize the graph with colorized nodes
ggraph(graph, layout = layout_weights) +
  geom_edge_link(aes(edge_alpha = weight), edge_colour = "grey", edge_linetype = 1) +
  geom_node_point(aes(fill = category), size = 5, shape = 21) +
  geom_node_text(aes(label = description), nudge_x = 0.1, nudge_y = 0.1, size = 3) +
  scale_fill_manual(values = c("beech" = "red", "oak" = "green", "pine" = "blue", "spruce" = "black")) +  # Adjust colors as needed
  theme_void()


plot_graph <- function(results, patches){
  print(results)
  weights <- replace(results$Statistic, is.nan(results$Statistic),1e15)
  weights <-  1 / weights
  weights <- weights / max(weights)
  nodes <- data.frame(id = 1:12, description = patches$area, category = patches$specie)
  edges <- data.frame(from = results$Species_1,
                      to = results$Species_2,
                      weight = weights)

  graph <- graph_from_data_frame(edges, directed = FALSE, vertices = nodes)

  print(weights)
  # Use layout_nicely and adjust node positions based on scaled weights
  layout_weights <- layout_nicely(graph)
  # Visualize the graph with node descriptions
  # Visualize the graph with colorized nodes
  graph <- ggraph(graph, layout = layout_weights) +
    geom_edge_link(aes(edge_alpha = weight), edge_colour = "grey", edge_linetype = 1) +
    geom_node_point(aes(fill = category), size = 5, shape = 21) +
    geom_node_text(aes(label = description), nudge_x = 0.1, nudge_y = 0.1, size = 3) +
    scale_fill_manual(values = c("beech" = "#a6cee3", "oak" = "#1f78b4", "pine" = "#b2df8a", "spruce" = "#33a02c")) +
    theme_void() +
    ggtitle("Weighted Graph of McNemar Test Results")

  return(graph)
}
