
# COMBINE MILITARY AND CIVILIAN IDENTITY CLUSTERS


# Make combined groups with new labels ------------------------------------
data <-
  data %>% 
  mutate(mil_civ_cluster = 
         paste(wis_cluster, civilian_cluster),
         mil_civ_cluster = factor(mil_civ_cluster,
         labels = c('Integrated', 'Separated', 'Assimilated', 'Marginalized')))

## Count
data %>% count(mil_civ_cluster) %>% print()


# Table: Combined ---------------------------------------------------------

data %>% 
  select(mil_civ_cluster | civilian_commit_total | starts_with('wis') & ends_with('total')  | biis_harmony | biis_blendedness) %>% 
  group_by(mil_civ_cluster) %>% 
  summarise(n = n(), across(everything(), ~ mean(.x)))



# Plot: Bar --------------------------------------------------------------------

data %>% 
  select(mil_civ_cluster | civilian_commit_total | starts_with('wis') & ends_with('total')  | biis_harmony | biis_blendedness) %>% 
  group_by(mil_civ_cluster) %>% 
  summarise(across(everything(), ~ mean(.x))) %>% 
  #mutate(across(!wis_cluster, ~ scale(.x))) %>%
  ungroup() %>% 
  pivot_longer(cols = !mil_civ_cluster) %>%
  ggplot(aes(name, value, fill = value)) + 
  geom_bar(stat="identity") + #make the bars
  facet_wrap(~ mil_civ_cluster, nrow=1) + #place the factors in separate facets
  coord_flip() +
  theme_bw() +
  labs(title = 'Warrior Identity', 
       subtitle = 'Scaled means for WIS subscales by cluster')



# Plot Clusters -----------------------------------------------------------

figure_mil_civ_clusters <-
  data %>% 
  ggplot(aes(x = wis_total, 
             y = civilian_commit_total,
             color = mil_civ_cluster,
             shape = mil_civ_cluster)) +
  geom_point(position = 'jitter') +
  theme_bw() +
  scale_color_viridis(discrete = T, direction = -1) +
  labs(title = 'Military-Civilian Clusters', 
       subtitle = '',
       x = 'Military Identity',
       y = 'Civilian Identity') +
  guides(shape = guide_legend(title = "Cluster"),
         color = guide_legend(title = "Cluster")) +
  theme_fonts

## Print:
figure_mil_civ_clusters

## Save:
ggsave(plot = figure_mil_civ_clusters, 
       filename = 'output/figures/figure-mil-civ-clusters.png',
       device = 'png')
rm(figure_mil_civ_clusters)


# Box Plot: Blendedness -------------------------------------------------------------------------
figure_boxplot_blended <-
  data %>% 
  ggplot(aes(biis_blendedness, mil_civ_cluster)) +
  geom_boxplot() +
  labs(title = 'Box Plot: Identity Blendedness by Cluster', 
       subtitle = '',
       x = 'Identity Blendedness',
       y = 'Cluster') +
  theme_fonts +
  theme_bw()

## Print:
figure_boxplot_blended

## Save:
ggsave(plot = figure_boxplot_blended, 
       filename = 'output/figures/figure-boxplot-blendedness.png',
       device = 'png')
rm(figure_boxplot_blended)
  

# Box Plot: Harmony -------------------------------------------------------------------------
figure_boxplot_harmony <-
  data %>% 
  ggplot(aes(biis_harmony, mil_civ_cluster)) +
  geom_boxplot() +
  labs(title = 'Box Plot: Identity Harmony by Cluster', 
       subtitle = '',
       x = 'Identity Harmony',
       y = 'Cluster') +
  theme_fonts +
  theme_bw()

## Print:
figure_boxplot_harmony

## Save:
ggsave(plot = figure_boxplot_harmony, 
       filename = 'output/figures/figure-boxplot-harmony.png',
       device = 'png')
rm(figure_boxplot_harmony)


# Table: Military x Civilian Clusters ------------------------------------------------------------

table_military_civilian_clusters <-
  data %>% 
  select(civilian_commit_total | starts_with('wis') & ends_with('total') | mil_civ_cluster | biis_harmony | biis_blendedness) %>% 
  group_by(mil_civ_cluster) %>% 
  summarise(n = n(), across(everything(), ~ mean(.x))) %>% 
  right_join(


# Table: Standard Deviation -------------------------------------------------------------------
  data %>% 
  select(civilian_commit_total | starts_with('wis') & ends_with('total') | mil_civ_cluster | biis_harmony | biis_blendedness) %>% 
  group_by(mil_civ_cluster) %>% 
  summarise(across(everything(), ~ sd(.x))),

  by = ('mil_civ_cluster' = 'mil_civ_cluster')
  ) %>% 
  rename(
    `Civilian Identity` = civilian_commit_total.x,
    Centrality = wis_centrality_total.x,
    Connection = wis_connection_total.x,
    Family = wis_family_total.x,
    Interdependence =  wis_interdependent_total.x,
    `Private Regard` = wis_private_regard_total.x, 
    `Public Regard` = wis_public_regard_total.x, 
    Skills = wis_skills_total.x,
    `Civilian Identity_sd` = civilian_commit_total.y,
    Centrality_sd = wis_centrality_total.y,
    Connection_sd = wis_connection_total.y,
    Family_sd = wis_family_total.y,
    Interdependence_sd =  wis_interdependent_total.y,
    `Private Regard_sd` = wis_private_regard_total.y, 
    `Public Regard_sd` = wis_public_regard_total.y, 
    Skills_sd = wis_skills_total.y)

## Print:  
table_military_civilian_clusters %>% print()

## Save
table_military_civilian_clusters %>% 
  write_csv('output/tables/table-military-civilian-clusters.csv')


# Plot Groups: Bar --------------------------------------------------------------------

figure_military_civilian_cluster_means <-
  data %>% 
  select(civilian_commit_total | starts_with('wis') & ends_with('total') & !wis_total | mil_civ_cluster) %>% 
  group_by(mil_civ_cluster) %>% 
  summarise(across(everything(), ~ mean(.x))) %>% 
  rename(Skills = wis_skills_total, 
         `Civilian Identity` = civilian_commit_total, 
         `Public Regard` = wis_public_regard_total, 
         `Private Regard` = wis_private_regard_total, 
         Interdependence =  wis_interdependent_total,
         Family = wis_family_total,
         Connection = wis_connection_total,
         Centrality = wis_centrality_total) %>% 
  #mutate(across(!mil_civ_cluster, ~ scale(.x))) %>%
  ungroup() %>% 
  pivot_longer(cols = !c(mil_civ_cluster)) %>%
  ggplot(aes(name, value, fill = value)) + 
  geom_bar(stat="identity") + #make the bars
  facet_wrap(~ mil_civ_cluster, nrow=1) + #place the factors in separate facets
  coord_flip() +
  theme_bw() +
  theme_fonts +
  labs(x = 'Strength of Identity', y = 'Facet of Identity') +
  labs(title = 'Military-Civilian Bicultural Clusters', 
       subtitle = 'Means across identity subscales') +
  theme(legend.position = 'none')

## Print:
figure_military_civilian_cluster_means

## Save:
ggsave(plot = figure_military_civilian_cluster_means, 
       filename = 'output/figures/figure-military-civilian-cluster-means.png',
       device = 'png')

       