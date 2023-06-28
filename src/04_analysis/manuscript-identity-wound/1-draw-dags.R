
library(dagitty)
library(ggdag)

set.seed(100)


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
  Worship -> CivId <- JobMil -> WIS -> BIIS -> MCARM
  MilFam -> CivId -> BIIS
  Combat -> MedDis -> DisAble
  
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

  MI [exposure]
  WIS [outcome]

  }")
ggdag::ggdag(dag_full) + ggdag::theme_dag_blank()
ggdag::tidy_dagitty(dag_full)
ggdag::ggdag_adjustment_set(dag_full) + ggdag::theme_dag_blank()
ggdag::tidy_dagitty(dag_full)

# Adjustment Sets
dagitty::adjustmentSets(dag_full)

# Instrument variables 
dagitty::instrumentalVariables(dag_full, outcome = 'WIS')

# Parents
dagitty::parents(dag_full, 'WIS')

# Exogenous Varibales
dagitty::exogenousVariables(dag_full)

# Dagitty Ancestors: 
dagitty::ancestors(dag_full, 'WIS')

# Children
dagitty::children(dag_full, 'WIS')

dagitty::vanishingTetrads(dag_full)

dagitty::adjustedNodes(dag_full) <- c("Era", "PTSD", "Sex")
ggdag::ggdag(dag_full) + ggdag::theme_dag_blank()

## 2 Adjustment sets:
## { Era, PTSD, Sex }
## { PMIE, PTSD, Trauma }

## Instrumental suggests that combat, disabilitary, PMIE, and Trama
## are instrumental variables to Era, PTSD, and SEX.

# Ancestors WIS, bIPF, YoS, YSep, Sex, Rank, Race, PTSD, 
# Trauma, Combat, PMIE, MilFam, MI, Era, Branch

# -------------------------------------------------------------------------
