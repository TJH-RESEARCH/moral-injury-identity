
library(dagitty)
library(ggdag)

set.seed(100)


# -------------------------------------------------------------------------
dag_xm <- dagitty::dagitty(
  "dag{
  
  MCARM <- WIS <- bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  YSep <- Age -> YoS -> Rank <- Race -> WIS <- YSep <- YoS -> WIS <- Era -> Combat -> DisAble <- Trauma <- Combat -> PMIE
  WIS <- PTSD <-> MI -> WIS <- Rank
  PTSD <- PMIE <- Era -> Trauma -> MedDis
  Branch -> WIS <- MilFam
  Race -> Rank <- Sex -> WIS <- Era <- Age
  MI <- Trauma <- Sex -> PMIE
  MI -> MCARM <- PTSD
  Worship -> CivId <- JobMil -> WIS -> BIIS -> MCARM
  MilFam -> CivId -> BIIS
  Combat -> MedDis -> DisAble
  
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

  MI [exposure]
  WIS [outcome]

  }")
ggdag::ggdag(dag_xm)
ggdag::tidy_dagitty(dag_xm)
ggdag::ggdag_adjustment_set(dag_xm)
ggdag::tidy_dagitty(dag_xm)

# Adjustment Sets
dagitty::adjustmentSets(dag_xm)

# Instrument variables 
dagitty::instrumentalVariables(dag_xm, outcome = 'WIS')

# Parents
dagitty::parents(dag_xm, 'WIS')

# Exogenous Varibales
dagitty::exogenousVariables(dag_xm)

# Dagitty Ancestors: 
dagitty::ancestors(dag_xm, 'WIS')

# Children
dagitty::children(dag_xm, 'WIS')

dagitty::vanishingTetrads(dag_xm)

dagitty::adjustedNodes(dag_xm) <- c("Era", "PTSD", "Sex")
ggdag::ggdag(dag_xm)

## 2 Adjustment sets:
## { Era, PTSD, Sex }
## { PMIE, PTSD, Trauma }

## Instrumental suggests that combat, disabilitary, PMIE, and Trama
## are instrumental variables to Era, PTSD, and SEX.

# Ancestors WIS, bIPF, YoS, YSep, Sex, Rank, Race, PTSD, 
# Trauma, Combat, PMIE, MilFam, MI, Era, Branch

# -------------------------------------------------------------------------
dag_my <- dagitty::dagitty(
  "dag{
  
  MCARM <- WIS <- bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  YoS -> Rank <- Race -> WIS <- YSep <- YoS -> WIS <- Era -> Combat -> DisAble <- Trauma <- Combat -> PMIE
  WIS <- PTSD <-> MI -> WIS <- Rank
  PTSD <- PMIE <- Era -> Trauma
  Branch -> WIS <- MilFam
  Race -> Rank <- Sex -> WIS <- Era
  MI <- Trauma <- Sex -> PMIE
  MI -> MCARM <- PTSD
  CivId <- JobMil -> WIS -> BIIS -> MCARM
  MilFam -> CivId -> BIIS
  DisAble -> Empld -> MCARM
  MI -> DisAble <- PTSD

  MI [exposure]
  WIS [mediator]
  MCARM [outcome]
  
  }")
ggdag::ggdag(dag_my)
ggdag::ggdag_paths(dag_my)
ggdag::ggdag_parents(dag_my, "MCARM")

ggdag::ggdag_adjustment_set(dag_my)

ggdag::tidy_dagitty(dag_my)
dagitty::adjustmentSets(dag_my)
dagitty::ancestors(dag_my, 'WIS')
dagitty::parents(dag_my, 'WIS')
dagitty::children(dag_my, 'WIS')
dagitty::exogenousVariables(dag_my)
