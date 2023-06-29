
# Create military-civilian identity clusters



# Select Data -------------------------------------------------------------

data_cluster_wis <-
  data %>% 
  dplyr::select(
    wis_total,
    civilian_commit_total
  ) %>% 
  mutate(wis_total = scale(wis_total),
         civilian_commit_total= scale(civilian_commit_total))



# Visualize Data ----------------------------------------------------------

data_cluster_wis %>% 
  mutate(high_wis = wis_total > mean(wis_total),
         low_wis  = wis_total <= mean(wis_total),
         high_civ = civilian_commit_total > mean(civilian_commit_total),
         low_civ  = civilian_commit_total <= mean(civilian_commit_total),
  ) %>% 
  ggplot(aes(civilian_commit_total, 
             wis_total, 
             color = high_wis,
             shape = high_civ)) +
  geom_point()



# Hierarchical Clustering -------------------------------------------------

clusters <- hclust(dist(data_cluster_wis))
plot(clusters)
clusterCut2 <- cutree(clusters, 2)
clusterCut3 <- cutree(clusters, 3)
clusterCut4 <- cutree(clusters, 4)
clusterCut5 <- cutree(clusters, 5)

data_cluster_wis %>% 
  mutate(cluster2 = factor(clusterCut2),
         cluster3 = factor(clusterCut3),
         cluster4 = factor(clusterCut4),
         cluster5 = factor(clusterCut5)) %>% 
  count(cluster2)

data_cluster_wis %>% 
  mutate(cluster = factor(clusterCut5)) %>% 
  ggplot(aes(wis_total, 
             civilian_commit_total, 
             color = cluster,
             shape = cluster)) +
  geom_point(position = 'jitter', size = 2)

## The 3 or 4 clusters are reasonable -- they seem to fit the data
## but for ANOVA analysis, the groups are WAY unbalanced in size.
## Are they unbalanced in variance on BIIS?

data %>% 
  mutate(cluster2 = factor(clusterCut2),
         cluster3 = factor(clusterCut3),
         cluster4 = factor(clusterCut4),
         cluster5 = factor(clusterCut5)) %>% 
  group_by(cluster3) %>% 
  summarise(sd = sd(biis_total), n = n())

## The variance is not that unequal, but it will be magnified
## by the unequal size. 


# K-Means Clustering ----------------------------------------------------------


results_kmeans_4 <- factoextra::eclust(data_cluster_wis, 
                                     "kmeans", 
                                     k = 4)

results_kmeans_3 <- factoextra::eclust(data_cluster_wis, 
                                     "kmeans", 
                                     k = 3)


# The k-means groups are much more equal in size.
# The variance in BIIS is also fairly equal

data %>% 
  mutate(cluster3 = factor(results_kmeans_3$cluster),
         cluster4 = factor(results_kmeans_4$cluster)) %>% 
  group_by(cluster4) %>% 
  summarise(sd = sd(biis_total), 
            n = n(), 
            mean_wis = mean(wis_total),
            mean_civ = mean(civilian_commit_total))


data %>% 
  mutate(cluster3 = factor(results_kmeans_3$cluster),
         cluster4 = factor(results_kmeans_4$cluster)) %>% 
  ggplot(aes(wis_total,
             civilian_commit_total,
             color = cluster4)) +
  geom_point()

# The main problem I have is, while this fit ANOVA assumptions, 
# it lumps together the outlying points with the others



# dbscan ------------------------------------------------------------------

libray(dbscan)
dbscan::dbscan(as.matrix(data_cluster_wis), minPts=5, eps=32)
# not a good tool for this data. unable to separate the data.
