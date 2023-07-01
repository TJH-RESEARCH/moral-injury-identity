library(dagitty)
library(ggdag)
source(here::here('src/01_config/dag-themes.R'))

# DAG Basic -------------------------------------------------------------------

dag_basic <- dagitty::dagitty(
  "dag{

  
  Conflict -> MCARM
  Compart -> MCARM
  
  MI -> MCARM
  MI -> WIS
  MI -> CivilianID
  
  WIS -> Compart
  WIS -> Conflict
  CivilianID -> Compart
  CivilianID -> Conflict
  
  MI [exposure]
  MCARM [outcome]

  }")

ggdag::tidy_dagitty(dag_basic)
ggdag_custom(dag_basic)
ggdag_adjustment_set_custom(dag_basic)




# DAG B -------------------------------------------------------------------

dag_b <- dagitty::dagitty(
  "dag{


  Conflict -> MCARM
  Compart -> MCARM
  
  MI -> MCARM
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
ggdag_custom(dag_b)
ggdag_adjustment_set_custom(dag_b)





# DAG Y = Civilian Identity & WIS -------------------------------------------------------------------

dag_civ_wis <- dagitty::dagitty(
  "dag{


  Conflict -> MCARM
  Compart -> MCARM
  
  MI -> MCARM
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
ggdag_custom(dag_civ_wis)
ggdag_adjustment_set_custom(dag_civ_wis)
adjustmentSets(dag_civ_wis)

# Adjust and Plot
ggdag::tidy_dagitty(dag_civ) %>% 
  ggdag::adjust_for(var = c('DisAble', 
                            'Era', 
                            'PTSD', 
                            'Sex')
  ) %>% 
  ggdag_adjustment_set_custom()




# DAG Y = MCARM -------------------------------------------------------------------

dag_mcarm <- dagitty::dagitty(
  "dag{


  Conflict -> MCARM
  Compart -> MCARM
  
  MI -> MCARM
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
ggdag_custom(dag_mcarm)
ggdag_adjustment_set_custom(dag_mcarm)


  

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
  ggdag_adjustment_set_custom(text_size = 4)


## Adjust the model and plot the DAG to look for precision paths
ggdag::tidy_dagitty(dag_civ_wis) %>% 
  ggdag::adjust_for(var = c('Era', 
                            'PTSD', 
                            'Sex')
  ) %>% 
  ggdag_adjustment_set_custom(text_size = 4)

## Not for MCARM. Nothing going only into Y except the mediators
##   and IV. 
