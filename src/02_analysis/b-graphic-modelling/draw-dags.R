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


adjustmentSets(dag_2, effect = 'total')
adjustmentSets(dag_2, effect = 'direct')

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
                'Identity' ~ 'PMIE' + 'Criterion_A'  + 'Combat' + 'MOS' + 'Branch' + 'Race' + 'Gender' + 'Era',
                'PTSD' ~~ 'MI',
                'Criterion_A' ~~ 'PMIE',
                'Criterion_A' ~ 'Combat',
                'PMIE' ~ 'Combat',
                'Combat' ~ 'Branch' + 'MOS' + 'Era',
                'Era' ~ 'Age',
                'MOS' ~ 'Gender' + 'Race',
                'Branch' ~ 'Gender' + 'Race',
                exposure = 'PMIE', outcome = 'MI')

coordinates(dag_3) <- list(
  x = c(Age = -1.5, Era = -1, Race = -.4, Gender = -.4, Branch = 0, MOS = 0, Combat = -.5, PMIE = 0, Criterion_A = 0, Identity = .5, PTSD = 1, MI = 1),
  y = c(Age =   .5, Era = 1, Race =   2.5, Gender =   -1.5, Branch = 3, MOS = -2, Combat =  .5, PMIE = 0, Criterion_A = 1, Identity = .5, PTSD = 1, MI = 0)
)

(plot_3 <-
    ggdag(dag_3) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 3')
)


ggsave(here::here('output/dags/dag-1.jpeg'), plot = plot_3)


adjustmentSets(dag_3, effect = 'total')
adjustmentSets(dag_3, effect = 'direct')

(dag_3_adj <- 
    ggdag_adjustment_set(dag_3, 
                         text_size = 3,
                         shadow = T, 
                         text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjustment Sets: DAG 3')
)

ggsave(here::here('output/dags/dag-1-adj.jpeg'), plot = dag_3_adj)


dag_3 %>% tidy_dagitty()


# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
## Add participation in the current study

dag_4 <- dagify('MI' ~ 'PMIE' + 'Identity' + 'MOS' + 'Branch' + 'Gender' + 'Race', 
                'PTSD' ~ 'Criterion_A' + 'Identity' + 'MOS' + 'Branch' + 'Gender' + 'Race',
                'Identity' ~ 'PMIE' + 'Criterion_A'  + 'Combat' + 'MOS' + 'Branch' + 'Race' + 'Gender' + 'Era',
                'PTSD' ~~ 'MI',
                'Criterion_A' ~~ 'PMIE',
                'Criterion_A' ~ 'Combat',
                'PMIE' ~ 'Combat',
                'Combat' ~ 'Branch' + 'MOS' + 'Era',
                'Era' ~ 'Age',
                'MOS' ~ 'Gender' + 'Race',
                'Branch' ~ 'Gender' + 'Race',
                'Participate' ~ 'Gender' + 'Race' + 'Branch' + 'Era' + 'Age' + 'MOS',
                exposure = 'PMIE', outcome = 'MI')

coordinates(dag_4) <- list(
  x = c(Age = -1.5, Era = -1, Participate =  -1, Race = -.4, Gender = -.4, Branch = 0, MOS = 0, Combat = -.5, PMIE = 0, Criterion_A = 0, Identity = .5, PTSD = 1, MI = 1),
  y = c(Age =   .5,  Era = 1, Participate =  0, Race =   2.5, Gender =   -1.5, Branch = 3, MOS = -2, Combat =  .5, PMIE = 0, Criterion_A = 1, Identity = .5, PTSD = 1, MI = 0)
)

(plot_4 <-
    ggdag(dag_4) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 3')
)


ggsave(here::here('output/dags/dag-4.jpeg'), plot = plot_4)


  
adjustmentSets(dag_4, effect = 'total')
adjustmentSets(dag_4, effect = 'direct')


(dag_4_participate <- 
    ggdag_adjust(dag_4,
                 var = c('Participate', 'Combat', 'Criterion_A', 'MOS', 'Branch', 'Race', 'Gender', 'Era'),
                 text_size = 3,
                 text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjusting for Collider Biased Introduced by Participation')
)


(dag_4_direct <- 
    ggdag_adjust(dag_4,
                 var = c('Participate', 'Combat', 'Criterion_A', 'MOS', 'Branch', 'Race', 'Gender', 'Era', "Identity"),
                 text_size = 3,
                 text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Getting the direct effect')
)


ggsave(here::here('output/dags/dag-4-adj.jpeg'), plot = dag_4_direct)





# Dag 5 -------------------------------------------------------------------
## I am worried that MOS is measured with too much error and we don't really
## have a good idea of what moral hazards different MOS groups are exposed to,
## and if I model MOS as being a factor of other demographics, then the 
## inclusion of these other demographics should account for a portion of the
## variance in MOS. For instance, Armey et al argue the racial variance in 
## combat deployment operates mostly (but not entirely) through MOS. 

## Moreover, I want to be parsimonious, and it would be an interesting idea
## to add years of service to the model. 

dag_5 <- dagify('MI' ~ 'PMIE' + 'Identity' + 'MOS' + 'Branch' + 'Gender' + 'Race', 
                'PTSD' ~ 'Criterion_A' + 'Identity' + 'MOS' + 'Branch' + 'Gender' + 'Race',
                'Identity' ~ 'PMIE' + 'Criterion_A'  + 'Combat' + 'MOS' + 'Branch' + 'Race' + 'Gender' + 'Era' + 'YrsServe',
                'PTSD' ~~ 'MI',
                'Criterion_A' ~~ 'PMIE',
                'Criterion_A' ~ 'Combat',
                'PMIE' ~ 'Combat',
                'Combat' ~ 'Branch' + 'MOS' + 'Era' + 'YrsServe',
                'Era' ~ 'Age',
                'YrsServe' ~ 'Age',
                'MOS' ~ 'Gender' + 'Race',
                'Branch' ~ 'Gender' + 'Race',
                'Participate' ~ 'Gender' + 'Race' + 'Branch' + 'Era' + 'Age' + 'MOS',
                exposure = 'PMIE', outcome = 'Identity')

coordinates(dag_5) <- list(
  x = c(Age = -1.5, YrsServe = -1.5, Era = -1, Participate =  -1, Race = -.5, Gender = -.5, Branch = 0, MOS = 0, Combat = -.5, PMIE = 0, Criterion_A = 0, Identity = .5, PTSD = 1, MI = 1),
  y = c(Age =   1, YrsServe = 0,  Era = 1, Participate =  0, Race =   2.5, Gender =   -1.5, Branch = 3, MOS = -2, Combat =  .5, PMIE = 0, Criterion_A = 1, Identity = .5, PTSD = 1, MI = 0)
)

(plot_5 <-
    ggdag(dag_5) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 3')
)


ggsave(here::here('output/dags/dag-5.jpeg'), plot = plot_5)



adjustmentSets(dag_5, effect = 'total')
adjustmentSets(dag_5, effect = 'direct')


(dag_5_participate <- 
    ggdag_adjust(dag_5,
                 var = c('Participate', 'Combat', 'Criterion_A', 'MOS', 'Branch', 'Race', 'Gender', 'Era', 'YrsServe'),
                 text_size = 3,
                 text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjusting for Collider Biased Introduced by Participation')
)


(dag_5_direct <- 
    ggdag_adjust(dag_5,
                 var = c('Participate', 'Combat', 'Criterion_A', 'MOS', 'Branch', 'Race', 'Gender', 'Era', "Identity"),
                 text_size = 3,
                 text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Getting the direct effect')
)


ggsave(here::here('output/dags/dag-5-adj.jpeg'), plot = dag_5_adj)


# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# What about the rank - education cluster?
## Like years of service, these are not necessarily pure "antecedents" or
## pre-treatment variables. They could plausibly be affected by morally injury
## and would thus need a longitudinal study to disambiguate. 
## But if we assume not, then here is the dag:
# But I do know that you need a college degree to be an officer, so
# I will model rank as a function of education

dag_6 <- dagify('MI' ~ 'PMIE' + 'Identity' + 'MOS' + 'Branch' + 'Gender' + 'Race', 
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

coordinates(dag_6) <- list(
  x = c(Age = -1.5, YrsServe = -1.5, Rank = - 1.25, Education = -1.25, Era = -1, Participate =  -1, Race = -.5, Gender = -.5, Branch = 0, MOS = 0, Combat = -.5, PMIE = 0, Criterion_A = 0, Identity = .5, PTSD = 1, MI = 1),
  y = c(Age =   1, YrsServe = 0,  Rank = 1.5, Education = -.5, Era = 1, Participate =  0, Race =   2.5, Gender =   -1.5, Branch = 3, MOS = -2, Combat =  .5, PMIE = 0, Criterion_A = 1, Identity = .5, PTSD = 1, MI = 0)
)

(plot_6 <-
    ggdag(dag_6) +
    geom_dag_point(fill = 'white', color = 'white') +
    geom_dag_edges() +
    geom_dag_text(color = 'black', size = 3) +
    theme_dag() +
    labs(title = 'DAG 6')
)


ggsave(here::here('output/dags/dag-6.jpeg'), plot = plot_6)



adjustmentSets(dag_6, effect = 'total')
adjustmentSets(dag_6, effect = 'direct')


(dag_6_participate <- 
    ggdag_adjust(dag_6,
                 var = c('Participate', 'Combat', 'Criterion_A', 'MOS', 'Branch', 'Race', 'Gender', 'Era', 'YrsServe', 'Rank'),
                 text_size = 3,
                 text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Adjusting for Collider Biased Introduced by Participation')
)


(dag_6_direct <- 
    ggdag_adjust(dag_6,
                 var = c('Participate', 'Combat', 'Criterion_A', 'MOS', 'Branch', 'Race', 'Gender', 'Era', 'YrsServe', 'Rank', 'Identity'),
                 text_size = 3,
                 text_col = 'black'
    ) + 
    theme_dag() +
    ggsci::scale_color_bmj() + 
    labs(title = 'Getting the direct effect')
)


#ggsave(here::here('output/dags/dag-6-adj.jpeg'), plot = dag_6_adj)

