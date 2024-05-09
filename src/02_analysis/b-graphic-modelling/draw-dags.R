


# Library -----------------------------------------------------------------
library(dagitty)
library(ggdag)



# 1. Basic DAG ---------------------------------------------------------------
dag_basic <- 
  
  dagify('ID' ~ 'MI' + 'MilID',
         'MilID' ~ 'MI',
         exposure = 'MI', 
         outcome = 'ID')


ggdag::tidy_dagitty(dag_basic)

coordinates(dag_basic) <- list(
  x = c(MI = 0, MilID = .5, ID = 1),
  y = c(
    MI = 1,
    MilID = 1.5,
    ID = 1
  )
)

(plot_basic <-
    ggdag(dag_basic) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 5) +
    theme_dag() +
    labs(title = 'Graphical Model: Basic')
)

ggsave(here::here('output/figures/graphical-models/dag_basic.jpeg'),
       plot = plot_basic)

#adjustmentSets(dag_basic)

(plot_basic_adj_set <- 
    ggdag_adjustment_set(dag_basic) + 
    theme_dag() +
    labs(title = 'Graphical Model: Basic')
)

ggsave(here::here('output/figures/graphical-models/dag_basic_adj_set.jpeg'))







# 2. Combat and PTSD -----------------------------------------------------
dag_2 <- 
  
  dagify('ID' ~ 'MI' + 'PTSD',
         'PTSD' ~ 'Combat',
         'MI' ~ 'Combat',
         
         exposure = 'MI', 
         outcome = 'ID')


ggdag::tidy_dagitty(dag_2)

coordinates(dag_2) <- list(
  x = c(Combat = .5, MI = .75, PTSD = .75, ID = 1),
  y = c(
    PTSD = 1.03,
    ID = 1,
    MI = .97, 
    Combat = 1
  )
)

(plot_dag_2 <-
    ggdag(dag_2) +
    geom_dag_point(colour = 'white', fill = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 5) +
    theme_dag() +
    labs(title = 'Graphical Model: Trauma and PMIEs')
)

ggsave(here::here('output/figures/graphical-models/dag_2.jpeg'),
       plot = plot_dag_2)


adjustmentSets(dag_2)

(plot_plot_dag_2_adj_set <-
    ggdag_adjustment_set(dag_2) + theme_dag() +
    labs(title = 'Graphical Model: Trauma and PMIEs')
)

ggsave(here::here('output/figures/graphical-models/dag_2_adj_set.jpeg'),
       plot = plot_plot_dag_2_adj_set)





# 3. Demographics -----------------------------------------------------
dag_3 <- 
  
  dagify('ID' ~ 'MI' + 'PTSD' + 'Race' + 'Branch' + 'Era' + 'Sex' + 'nDply' + 'YrsSrv',
         'PTSD' ~ 'Combat',
         'MI' ~ 'Combat',
         'Combat' ~ 'Branch' + 'Era' + 'nDply' + 'YrsSrv',
         'nDply' ~ 'YrsSrv',
         
         exposure = 'MI', 
         outcome = 'ID')


ggdag::tidy_dagitty(dag_3)

coordinates(dag_3) <- list(
  x = c(Combat = .5, MI = .75, PTSD = .75, Branch = .75, Era = .75, nDply = .75, YrsSrv = .75, Race = 1, Sex = 1, ID = 1),
  y = c(
    MI = 1.02, 
    PTSD = 1.01,
    ID = 1,
    Combat = 1,
    Branch = .99, 
    Sex = .98,
    Era = .98,
    nDply = .97,
    YrsSrv = .96,
    Race = 1.02
  )
)

(plot_dag_3 <-
    ggdag(dag_3) +
    geom_dag_point(colour = 'white', fill = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 5) +
    theme_dag() +
    labs(title = 'Graphical Model: Trauma and PMIEs')
)

ggsave(here::here('output/figures/graphical-models/dag_3.jpeg'),
       plot = plot_dag_3)


adjustmentSets(dag_3)



(plot_dag_3_adj_set <-
    ggdag_adjustment_set(dag_3) + theme_dag() +
    labs(title = 'Graphical Model')
)


ggsave(here::here('output/figures/graphical-models/dag_3_adj_set.jpeg'),
       plot = plot_dag_3_adj_set)




