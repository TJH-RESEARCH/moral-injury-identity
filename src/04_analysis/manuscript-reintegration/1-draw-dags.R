library(dagitty)
library(ggdag)

# DAG Basic -------------------------------------------------------------------

dag_basic <- dagitty::dagitty(
  "dag{

  
  Conflict -> MCARM
  Compart -> MCARM
  
  MI -> WIS
  MI -> CivilianID
  
  WIS -> Compart
  WIS -> Conflict
  CivilianID -> Compart
  CivilianID -> Conflict
  
  MI [exposure]
  MCARM [outcome]

  }")
set.seed(20)
ggdag::ggdag(dag_basic, edge_type = 'link_arc', text_size = 4, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_basic,text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()




# DAG B -------------------------------------------------------------------

dag_b <- dagitty::dagitty(
  "dag{


  Conflict -> MCARM
  Compart -> MCARM
  
  MI -> WIS
  MI -> CivilianID
  
  WIS -> Compart
  WIS -> Conflict
  CivilianID -> Compart
  CivilianID -> Conflict
  
  YrsServe -> YrsSep
  YrsServe -> WIS
  YrsServe -> Rank -> WIS
  YrsSep -> WIS
  YrsSep -> CivilianID
  
  MilFam -> WIS
  
  Rank -> WIS
  Race -> WIS
  Race -> Rank
  
  Sex -> Rank
  Sex -> WIS

  
  MI [exposure]
  MCARM [outcome]
  

  }")
set.seed(104)
ggdag::ggdag(dag_b, 
             edge_type = 'link_arc', 
             text_size = 3.5, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_b,text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()





# DAG Y = Civilian Identity & WIS -------------------------------------------------------------------

dag_civ_wis <- dagitty::dagitty(
  "dag{


  Conflict -> MCARM
  Compart -> MCARM
  
  MI -> WIS
  MI -> CivilianID
  
  WIS -> Compart
  WIS -> Conflict
  CivilianID -> Compart
  CivilianID -> Conflict
  
  YrsSep <- Age -> YrsServe
  
  YrsServe -> YrsSep
  YrsServe -> WIS
  YrsServe -> Rank -> WIS
  YrsSep -> WIS
  YrsSep -> CivilianID
  
  MilFam -> WIS
  
  Rank -> WIS
  Race -> WIS
  Race -> Rank
  
  Sex -> Rank
  Sex -> WIS
  
  MI -> MCARM <- PTSD
  
  CivilianID <- bIPF <- MI <- PMIE <-> Trauma -> PTSD -> bIPF -> WIS
  PTSD <- PMIE <- Era -> Trauma -> MedDis
  Trauma <- Sex -> PMIE
  WIS <- PTSD <-> MI
  Combat -> MedDis -> DisAble -> MCARM
  
  Era -> Combat -> DisAble <- Trauma <- Combat -> PMIE
  WIS <- Era <- Age
  Worship -> CivilianID <- JobMil -> WIS
  Branch -> WIS <- MilFam -> CivilianID

  MI [exposure]
  CivilianID [outcome]
  WIS [outcome]

  }")
set.seed(104)
ggdag::ggdag(dag_civ_wis, 
             edge_type = 'link_arc', 
             text_size = 3.5, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_civ_wis, text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()
adjustmentSets(dag_civ_wis)

# Adjust and Plot
ggdag::tidy_dagitty(dag_civ) %>% 
  ggdag::adjust_for(var = c('DisAble', 
                            'Era', 
                            'PTSD', 
                            'Sex')
  ) %>% 
  ggdag::ggdag_adjustment_set(text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()




# DAG Y = MCARM -------------------------------------------------------------------

dag_mcarm <- dagitty::dagitty(
  "dag{


  Conflict -> MCARM
  Compart -> MCARM
  
  MI -> WIS
  MI -> CivilianID
  
  WIS -> Compart
  WIS -> Conflict
  CivilianID -> Compart
  CivilianID -> Conflict
  
  YrsSep <- Age -> YrsServe
  
  YrsServe -> YrsSep
  YrsServe -> WIS
  YrsServe -> Rank -> WIS
  YrsSep -> WIS
  YrsSep -> CivilianID
  
  MilFam -> WIS
  
  Rank -> WIS
  Race -> WIS
  Race -> Rank
  
  Sex -> Rank
  Sex -> WIS
  
  MI -> MCARM <- PTSD
  
  CivilianID <- bIPF <- MI <- PMIE <-> Trauma -> PTSD -> bIPF -> WIS
  PTSD <- PMIE <- Era -> Trauma -> MedDis
  Trauma <- Sex -> PMIE
  WIS <- PTSD <-> MI
  Combat -> MedDis -> DisAble -> MCARM
  
  Era -> Combat -> DisAble <- Trauma <- Combat -> PMIE
  WIS <- Era <- Age
  Worship -> CivilianID <- JobMil -> WIS
  Branch -> WIS <- MilFam -> CivilianID

  MI [exposure]
  MCARM [outcome]

  }")
set.seed(104)
ggdag::ggdag(dag_mcarm, 
             edge_type = 'link_arc', 
             text_size = 3.5, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_mcarm,text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()


  

# Adjustment Sets ---------------------------------------------------------
adjustmentSets(dag_civ)
adjustmentSets(dag_mcarm)

# { DisAble, Era, PTSD, Sex } works for both!



# Increased precision? ----------------------------------------------------

## Adjust the model and plot the DAG to look for precision paths
ggdag::tidy_dagitty(dag_mcarm) %>% 
  ggdag::adjust_for(var = c('DisAble', 
                            'Era', 
                            'PTSD', 
                            'Sex')
  ) %>% 
  ggdag::ggdag_adjustment_set(text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()


## Not for MCARM. Nothing going only into Y except the mediators
##   and IV. 
