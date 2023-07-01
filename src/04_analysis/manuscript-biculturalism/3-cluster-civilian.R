
# CLUSTER CIVILIAN IDENTITY


# Library -----------------------------------------------------------------
library(viridis)

# Visualize 1 ---------------------------------------------------------------
## Visually, you can see three clusters, some above 12, some at 12, some below:

figure_civilian_cluster_init <- 
  data %>% 
  mutate(civilian_cluster = 
           case_when(
             civilian_commit_total > 12 ~ 'High Identity',
             civilian_commit_total == 12 ~ 'Medium Identity',
             .default = 'Low Identity'
           ),
         civilian_cluster = factor(civilian_cluster)
  ) %>% 
  mutate(Cluster = factor(civilian_cluster),
         `Civilian Identity` = civilian_commit_total) %>% 
  ggplot(aes(`Civilian Identity`, 
             y = 1, 
             color = Cluster,
             shape = Cluster)) +
  geom_point(position = 'jitter', alpha = .65, size = 2) + 
  theme_fonts +
  ylab(label = ' ') +
  theme_bw() +
  scale_color_viridis(discrete = T, direction = -1) +
  labs(title = 'Civilian Identity', 
       subtitle = 'At most, three clusters appear in the data') +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank()) +
  theme_fonts

## Print:
figure_civilian_cluster_init

## Save:
ggsave(plot = figure_civilian_cluster_init, 
       filename = 'output/figures/figure-civilian-custer-init.png',
       device = 'png')



# Group Size --------------------------------------------------------------
## these natural groups have unbalanced sizes
data %>% 
  mutate(civilian_cluster = case_when(civilian_commit_total > 12 ~ 'high_civ', civilian_commit_total == 12 ~ 'med_civ', .default = 'low_civ'),
         civilian_cluster = factor(civilian_cluster)
  ) %>% 
  count(civilian_cluster)



# k-means ----------------------------------------------------------------------
## Unbalanced group size. Use k-means to make more precise split in groups, 
##   and use two means (k = 2) to lump the 13 in low category with the medium.

civ_kmeans <- kmeans(data$civilian_commit_total, 2)

## Print:
civ_kmeans$cluster

## Save:f
data <- 
  data %>% 
  mutate(civilian_cluster = civ_kmeans$cluster,
         civilian_cluster = factor(civilian_cluster,
                                   levels = c(2,1),
                                   labels = c('Lower Civilian Identity', 'Higher Civilian Identity')
         )
  )

## Count:
data %>% count(civilian_cluster)


# Visualize 1 ---------------------------------------------------------------
## Visually, you can see three clusters, some above 12, some at 12, some below:

figure_civilian_cluster_final <- 
  data %>% 
  mutate(Cluster = factor(civilian_cluster),
         `Civilian Identity` = civilian_commit_total) %>% 
  ggplot(aes(`Civilian Identity`, 
             y = 1, 
             color = Cluster,
             shape = Cluster)) +
  geom_point(position = 'jitter', alpha = .65, size = 2) + 
  theme_fonts +
  ylab(label = ' ') +
  theme_bw() +
  scale_color_viridis(discrete = T, direction = -1) +
  labs(title = 'Civilian Identity Cluters', 
       subtitle = 'K-means clustering into two categories') +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank()) +
  theme_fonts

## Print:
figure_civilian_cluster_final

## Save:
ggsave(plot = figure_civilian_cluster_final, 
       filename = 'output/figures/figure-civilian-custer-final.png',
       device = 'png')
rm(figure_civilian_cluster_final)


# Table: Group Differences ------------------------------------------------

table_civ_cluster_mean_civ_id <-
  data %>% 
  select(civilian_cluster, civilian_commit_total) %>% 
  group_by(civilian_cluster) %>% 
  summarise(n = n(), 
            mean = mean(civilian_commit_total), 
            sd = sd(civilian_commit_total)) %>% 
  rename(`Civilian Cluster` = civilian_cluster,
         M = mean, 
         SD = sd)

## Print Table
table_civ_cluster_mean_civ_id

## Write Table
table_civ_cluster_mean_civ_id %>% write_csv('output/tables/table_civ_cluster_mean_civ_id.csv')
rm(table_civ_cluster_mean_civ_id)

