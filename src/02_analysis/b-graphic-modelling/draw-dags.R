library(tidyverse)
library(ggdag)
library(dagitty)


dag_1 <- 
  dagify('ID' ~ 'MI',
         exposure = 'MI', 
         outcome = 'ID')


coordinates(dag_1) <- list(
  x = c(MI = 0, ID = 1),
  y = c(MI = 0, ID = 0)
)

(plot_1_adj <-
    ggdag(dag_1) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 1')
)

#ggsave(here::here('output/dags/dag-1.jpeg'), plot = dag_1_adj)



# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------

dag_2 <- 
  
  dagify('ID' ~ 'MI' + 'PTSD' + 'Combat',
         'PTSD' ~ 'Combat',
         'MI' ~ 'Combat',
         exposure = 'MI', 
         outcome = 'ID')


coordinates(dag_2) <- list(
  x = c(MI = 0, PTSD =  0, ID = 1, Combat = -1),
  y = c(MI = 1, PTSD = -1, ID = 0, Combat = 0)
)

(plot_dag_2 <-
    ggdag(dag_2) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 2')
)

#ggsave(here::here('output/dags/dag-2.jpeg'), plot = plot_dag_2)
plot(dag_2)

(dag_2_adj <- 
    ggdag_adjustment_set(dag_2, 
                         text_size = 3,
                         shadow = T,
                         text_col = 'black',
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjustment Sets: DAG 2')
)

#ggsave(here::here('output/dags/dag-2-adj.jpeg'), plot = dag_2_adj)




# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------


dag_3 <- 
  dagify('ID' ~ 'MI' + 'PTSD' + 'Combat' + 'Gender' + 'Race' + 'Era',
         'PTSD' ~ 'Combat' + 'Era' + 'Gender' + 'Race',
         'MI' ~ 'Combat' + 'Era' + 'Gender' + 'Race',
         'Combat' ~ 'Era' + 'Gender' + 'Race',
         exposure = 'MI', 
         outcome = 'ID')


coordinates(dag_3) <- list(
  x = c(Combat = 0, Era = .64, Race = .32, Gender = .31, MI = .5, PTSD =  .5, ID = 1),
  y = c(Combat = 0,  Era =  -.43, Race = -.40, Gender =  .36, MI = 1, PTSD = -1, ID = 0)
)

(plot_dag_3 <-
    ggdag(dag_3) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 4')
)

#ggsave(here::here('output/dags/dag-3.jpeg'), plot = plot_dag_3)


(dag_3_adj <- 
    ggdag_adjustment_set(dag_3, 
                         text_size = 3,
                         shadow = T,
                         text_col = 'black',
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjustment Sets: DAG 4')
)

#ggsave(here::here('output/dags/dag-4-adj.jpeg'), plot = dag_4_adj)



# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------


dag_4 <- 
  dagify(
         
         
         'Era' ~ 'Age',
         'Rank' ~~ 'Education',
         
         'Income' ~~ 'Rank' + 'Education',
         'n_child' ~ 'Marital',
         
         'MOS' ~    'Branch' + 'Gender' + 'Race' + 'Marital' + 'n_child',
         
         'Combat' ~ 'Branch' + 'Gender' + 'Race' + 'Marital' + 'n_child' + 'Era' + 'MOS' + 'Rank',
         
         'Leadership' ~~ 'Cohesion',
         
         'PTSD' ~ 'Combat' + 'Era' + 'Gender' + 'Race' + 'MOS' + 'Cohesion' + 'Leadership',
         'MI' ~ 'Combat' + 'Era' + 'Gender' + 'Race' + 'Cohesion' + 'Leadership' + 'MOS',
         
         
         'ID' ~ 'MI' + 'PTSD' + 'Combat' + 'Era' + 'Gender' + 'Race' + 'Education' + 'Rank' + 'Income' + 'Marital' + 'n_child',
         
         'Particpate' ~ 'Branch' + 'Era' + 'MOS' + 'Gender' + 'Race' + 'Marital' + 'n_child' +  'Rank' + 'Age' + 'Income' + 'Education',
         
         
         exposure = 'MI',
         outcome = 'ID')



(plot_dag_4 <-
    ggdag(dag_4) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 7')
)

#ggsave(here::here('output/dags/dag-7.jpeg'), plot = plot_dag_4)


(dag_4_adj <-  
    ggdag_adjustment_set(dag_4, 
                         text_size = 3,
                         shadow = T,
                         text_col = 'black',
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjustment Sets: DAG 4')
)

adjustmentSets(dag_4)

dag_4_participate <- adjust_for(dag_4, 'Particpate')

(dag_4_adj <-  
    ggdag_adjustment_set(dag_4_participate, 
                         text_size = 3,
                         shadow = T,
                         text_col = 'black',
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjustment Sets: DAG 4 - Controlled for Participation')
)



#ggsave(here::here('output/dags/dag-7-adj.jpeg'), plot = dag_4_adj)


# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------




plot_dag_2
plot_dag_3
plot_dag_3
plot_dag_4

dag_2_adj
dag_3_adj
dag_3_adj
dag_4_adj

