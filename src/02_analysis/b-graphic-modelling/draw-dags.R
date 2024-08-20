library(tidyverse)
library(ggdag)
library(dagitty)


dag_1 <- dagify('MI' ~ 'PMIE' + 'Identity', 
                'PTSD' ~ 'Criterion_A' + 'Identity',
                'Identity' ~ 'PMIE' + 'Criterion_A' + 'Combat',
                'PTSD' ~~ 'MI',
                'Criterion_A' ~~ 'PMIE',
                'Criterion_A' ~ 'Combat',
                'PMIE' ~ 'Combat',
                exposure = 'PMIE', outcome = 'MI')

coordinates(dag_1) <- list(
  x = c(Combat = -.5, PMIE = 0, Criterion_A = 0, Identity = .5, PTSD = 1, MI = 1),
  y = c(Combat =  .5, PMIE = 0, Criterion_A = 1, Identity = .5, PTSD = 1, MI = 0)
)

(plot_1 <-
    ggdag(dag_1) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 1')
)


ggsave(here::here('output/dags/dag-1.jpeg'), plot = plot_1)


adjustmentSets(dag_1, effect = 'total')
adjustmentSets(dag_1, effect = 'direct')

(dag_1_adj <- 
    ggdag_adjustment_set(dag_1, 
                         text_size = 3,
                         shadow = T,
                         text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjustment Sets: DAG 1')
)

ggsave(here::here('output/dags/dag-1-adj.jpeg'), plot = dag_1_adj)


# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
## Add branch and MOS

dag_2 <- dagify('MI' ~ 'PMIE' + 'Identity' + 'MOS' + 'Branch', 
                'PTSD' ~ 'Criterion_A' + 'Identity' + 'MOS' + 'Branch',
                'Identity' ~ 'PMIE' + 'Criterion_A'  + 'Combat' + 'MOS' + 'Branch',
                'PTSD' ~~ 'MI',
                'Criterion_A' ~~ 'PMIE',
                'Criterion_A' ~ 'Combat',
                'PMIE' ~ 'Combat',
                'Combat' ~ 'Branch' + 'MOS',
                exposure = 'PMIE', outcome = 'MI')

coordinates(dag_2) <- list(
  x = c(Branch = 0, MOS = 0, Combat = -.5, PMIE = 0, Criterion_A = 0, Identity = .5, PTSD = 1, MI = 1),
  y = c(Branch = 3, MOS = -2, Combat =  .5, PMIE = 0, Criterion_A = 1, Identity = .5, PTSD = 1, MI = 0)
)

(plot_2 <-
    ggdag(dag_2) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 2')
)


ggsave(here::here('output/dags/dag-2.jpeg'), plot = plot_2)


#adjustmentSets(dag_2, effect = 'total')
#adjustmentSets(dag_2, effect = 'direct')

(dag_2_adj <- 
    ggdag_adjustment_set(dag_2, 
                         text_size = 3,
                         shadow = T,
                         text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjustment Sets: DAG 2')
)

ggsave(here::here('output/dags/dag-2-adj.jpeg'), plot = dag_2_adj)


# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
## Add demographic predictors of branch and MOS


dag_3 <- dagify('MI' ~ 'PMIE' + 'Identity' + 'MOS' + 'Branch' + 'Gender' + 'Race', 
                'PTSD' ~ 'Criterion_A' + 'Identity' + 'MOS' + 'Branch' + 'Gender' + 'Race',
                'Identity' ~ 'PMIE' + 'Criterion_A'  + 'Combat' + 'MOS' + 'Branch' + 'Race' + 'Gender' + 'Era' + 'YrsServe' + 'Rank',
                'PTSD' ~~ 'MI',
                'Criterion_A' ~~ 'PMIE',
                'Criterion_A' ~ 'Combat',
                'PMIE' ~ 'Combat',
                'Combat' ~ 'Branch' + 'MOS' + 'Era' + 'YrsServe',
                'Era' ~ 'Age',
                'YrsServe' ~ 'Age',
                'Rank' ~ 'YrsServe' + 'Education',
                'MOS' ~ 'Gender' + 'Race',
                'Branch' ~ 'Gender' + 'Race',
                'Participate' ~ 'Gender' + 'Race' + 'Branch' + 'Era' + 'Age' + 'MOS' + 'Rank' + 'Education',
                exposure = 'PMIE', outcome = 'Identity')

coordinates(dag_3) <- list(
  x = c(Age = -1.5, YrsServe = -1.5, Rank = - 1.25, Education = -1.25, Era = -1, Participate =  -1, Race = -.5, Gender = -.5, Branch = 0, MOS = 0, Combat = -.5, PMIE = 0, Criterion_A = 0, Identity = .5, PTSD = 1, MI = 1),
  y = c(Age =   1, YrsServe = 0,  Rank = 1.5, Education = -.5, Era = 1, Participate =  0, Race =   2.5, Gender =   -1.5, Branch = 3, MOS = -2, Combat =  .5, PMIE = 0, Criterion_A = 1, Identity = .5, PTSD = 1, MI = 0)
)

(plot_3 <-
    ggdag(dag_3) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 3: Demographics')
)


ggsave(here::here('output/dags/dag-3.jpeg'), plot = plot_3)



adjustmentSets(dag_3, effect = 'total')
adjustmentSets(dag_3, effect = 'direct')


(dag_3_participate <- 
    ggdag_adjust(dag_3,
                 var = c('Participate', 'Combat', 'Criterion_A', 'MOS', 'Branch', 'Race', 'Gender', 'Era', 'YrsServe', 'Rank'),
                 text_size = 3,
                 text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjusting for Collider Biased Introduced by Participation')
)

ggsave(here::here('output/dags/dag-3-participate.jpeg'), plot = dag_3_participate)

(dag_3_direct <- 
    ggdag_adjust(dag_3,
                 var = c('Participate', 'Combat', 'Criterion_A', 'MOS', 'Branch', 'Race', 'Gender', 'Era', 'YrsServe', 'Rank', 'Identity'),
                 text_size = 3,
                 text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Getting the direct effect')
)

ggsave(here::here('output/dags/dag-3-direct.jpeg'), plot = dag_3_direct)


