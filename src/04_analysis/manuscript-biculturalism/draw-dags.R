
library(dagitty)
library(ggdag)

set.seed(100)


# Simple Dag --------------------------------------------------------------


dag_simple <- dagitty::dagitty(
  "dag{

  WIS -> MCARM
  CivID -> MCARM
  WIS -> BIIS
  CivID -> BIIS
  BIIS -> MCARM
  BIIS -> SCC -> MCARM
  
  BIIS [exposure]
  MCARM [outcome]

  }")
ggdag::ggdag(dag_simple)
ggdag::tidy_dagitty(dag_simple)
ggdag::ggdag_adjustment_set(dag_simple)


# Simple Dag --------------------------------------------------------------


dag_simple_MI <- dagitty::dagitty(
  "dag{

  MI -> WIS
  MI -> CivID
  MI -> SCC
  WIS -> MCARM
  CivID -> MCARM
  WIS -> BIIS
  CivID -> BIIS
  BIIS -> MCARM
  BIIS -> SCC -> MCARM
  
  BIIS [exposure]
  MCARM [outcome]

  }")
ggdag::ggdag(dag_simple_MI)
ggdag::tidy_dagitty(dag_simple_MI)
ggdag::ggdag_adjustment_set(dag_simple_MI)






# -------------------------------------------------------------------------
dag_full <- dagitty::dagitty(
  "dag{
  
  MCARM <- WIS <- bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  YSep <- Age -> YoS -> Rank <- Race -> WIS <- YSep <- YoS -> WIS <- Era -> Combat -> DisAble <- Trauma <- Combat -> PMIE
  WIS <- PTSD <-> MI -> WIS <- Rank
  PTSD <- PMIE <- Era -> Trauma -> MedDis
  Branch -> WIS <- MilFam
  Race -> Rank <- Sex -> WIS <- Era <- Age
  MI <- Trauma <- Sex -> PMIE
  MI -> MCARM <- PTSD
  Worship -> CivID <- JobMil -> WIS -> BIIS -> MCARM
  MilFam -> CivID -> BIIS
  Combat -> MedDis -> DisAble
  
   MI -> WIS
  MI -> CivID
  MI -> SCC
  WIS -> MCARM
  CivID -> MCARM
  WIS -> BIIS
  CivID -> BIIS
  BIIS -> MCARM
  BIIS -> SCC -> MCARM
  
  
  Reserve
  SexOr
  Pols
  Educ
  SCC
  USid
  MedDis
  OtherDis -> MCARM
  Unmet -> MCARM <- Educ
  
  DisAble -> Empld -> MCARM
  MI -> DisAble <- PTSD

  BIIS [exposure]
  MCARM [outcome]
  

  }")
ggdag::ggdag(dag_full)
ggdag::tidy_dagitty(dag_full)
ggdag::ggdag_adjustment_set(dag_full)
ggdag::tidy_dagitty(dag_full)

# Adjustment Sets
dagitty::adjustmentSets(dag_full)

# Instrument variables 
dagitty::instrumentalVariables(dag_full, outcome = 'MCARM')

# Parents
dagitty::parents(dag_full, 'MCARM')

# Exogenous Varibales
dagitty::exogenousVariables(dag_full)

# Dagitty Ancestors: 
dagitty::ancestors(dag_full, 'MCARM')

# Children
dagitty::children(dag_full, 'MCARM')

dagitty::vanishingTetrads(dag_full)

dagitty::adjustedNodes(dag_full) <- c("CivID", "WIS")
ggdag::ggdag(dag_full)

## 1 Adjustment set:
## { CivID, WIS }

## Instrumental

# Ancestors 

# -------------------------------------------------------------------------
