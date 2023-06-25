

## Manuscript 3: Moral Injury and Reintegration: The Mediating Role of Identity
# "Project Big Model"



# Load Libraries ----------------------------------------------------------
library(dagitty)
library(ggdag)


# Set Seed ----------------------------------------------------------------
set.seed(100)


# Dag 1 --------------------------------------------------------------

# Start relatively simple, then add variables

## Dependent Variable: Reintegration (MCARM or M2CQ)
## Independent Variable: Moral Injury Symptoms (MI)

dag_1 <- dagitty::dagitty(
  "dag{

  MI -> MCARM
  MI -> WIS -> MCARM
  MI -> CivID -> MCARM
  MI -> SCC -> MCARM
  
  MI [exposure]
  MCARM [outcome]

  }")
ggdag::ggdag(dag_1) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_1) + ggdag::theme_dag()


# Dag 2 --------------------------------------------------------------

## Add bicultural identity integration

dag_2 <- dagitty::dagitty(
  "dag{

  MI -> MCARM
  MI -> WIS -> MCARM
  MI -> CivID -> MCARM
  MI -> SCC -> MCARM
  WIS -> BIIS <- CivID
  BIIS -> MCARM
  BIIS -> SCC -> MCARM
  
  
  MI [exposure]
  SCC [outcome]

  }")
ggdag::ggdag(dag_2) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_2) + ggdag::theme_dag()



e# Dag 3 --------------------------------------------------------------

## Add the PMIE and Trauma pathways

dag_3 <- dagitty::dagitty(
  "dag{

  MI -> MCARM
  MI -> WIS -> MCARM
  MI -> CivID -> MCARM
  MI -> SCC -> MCARM
  
  WIS -> BIIS <- CivID
  BIIS -> MCARM
  BIIS -> SCC
  
  bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  PTSD <- PMIE 
  PTSD <-> MI
  PTSD -> MCARM
  MI -> DisAble <- PTSD
  Trauma -> DisAble -> MCARM
  Trauma -> MedDis
  Trauma -> MI
  MI -> WIS <- PTSD
  
  MI [exposure]
  MCARM [outcome]

  }")
ggdag::ggdag(dag_3) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_3) + ggdag::theme_dag()



# Dag 4 --------------------------------------------------------------

## Show demographics

dag_4 <- dagitty::dagitty(
  "dag{

  MI -> MCARM
  MI -> WIS -> MCARM
  MI -> CivID -> MCARM
  MI -> SCC -> MCARM
  WIS -> BIIS <- CivID
  BIIS -> MCARM
  BIIS -> SCC -> MCARM
  
  
  MI [exposure]
  MCARM [outcome]

  }")
ggdag::ggdag(dag_4) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_4) + ggdag::theme_dag()






# -------------------------------------------------------------------------
dag_id <- dagitty::dagitty(
  "dag{
  
   MI -> MCARM
  MI -> WIS -> MCARM
  MI -> CivID -> MCARM
  MI -> SCC -> MCARM
  
  WIS -> BIIS <- CivID
  BIIS -> MCARM
  BIIS -> SCC
  
  bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  PTSD <- PMIE 
  PTSD <-> MI
  PTSD -> MCARM
  MI -> DisAble <- PTSD
  Trauma -> DisAble -> MCARM
  Trauma -> MedDis
  Trauma -> MI
  MI -> WIS <- PTSD
  
  bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  
  Age -> Era
  Age -> YoS -> YSep
  YoS -> WIS
  YoS -> Rank -> WIS
  YSep -> WIS
  YSep -> CivID
  
  Branch -> WIS
  Era -> WIS
  Era -> Combat -> DisAble
  Era -> DisAble <- Trauma <- Combat -> PMIE
  Era -> Trauma
  Era -> PMIE
  
  PMIE <- Combat -> Truma
  
  MilFam -> WIS
  
  Rank -> WIS
  Race -> WIS
  Race -> Rank
  
  Sex -> Rank
  Sex -> WIS
  Sex -> PMIE
  Sex -> Trauma
  
  Worship -> CivID 
  MilFam -> CivID
  JobMil -> CivID
  JobMil -> WIS
  
  Educ -> MCARM
  OtherDis -> MCARM
  Unmet -> MCARM
  DisAble -> Empld -> MCARM
  

  MI [exposure]
  MCARM [outcome]

  }")

ggdag::ggdag(dag_id) + ggdag::theme_dag_blank()
ggdag::tidy_dagitty(dag_id)
ggdag::ggdag_adjustment_set(dag_id) + ggdag::theme_dag_blank()
ggdag::tidy_dagitty(dag_id)



# -------------------------------------------------------------------------
dag_full <- dagitty::dagitty(
  "dag{
  
   MI -> MCARM
  MI -> WIS -> MCARM
  MI -> CivID -> MCARM
  MI -> SCC -> MCARM
  
  WIS -> BIIS <- CivID
  BIIS -> MCARM
  BIIS -> SCC
  
  bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  PTSD <- PMIE 
  PTSD <-> MI
  PTSD -> MCARM
  MI -> DisAble <- PTSD
  Trauma -> DisAble -> MCARM
  Trauma -> MedDis
  Trauma -> MI
  MI -> WIS <- PTSD
  
  bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  
  Age -> Era
  Age -> YoS -> YSep
  YoS -> WIS
  YoS -> Rank -> WIS
  YSep -> WIS
  YSep -> CivID
  
  Branch -> WIS
  Era -> WIS
  Era -> Combat -> DisAble
  Era -> DisAble <- Trauma <- Combat -> PMIE
  Era -> Trauma
  Era -> PMIE
  
  PMIE <- Combat -> Truma
  
  MilFam -> WIS
  
  Rank -> WIS
  Race -> WIS
  Race -> Rank
  
  Sex -> Rank
  Sex -> WIS
  Sex -> PMIE
  Sex -> Trauma
  
  Worship -> CivID 
  MilFam -> CivID
  JobMil -> CivID
  JobMil -> WIS
  
  Educ -> MCARM
  OtherDis -> MCARM
  Unmet -> MCARM
  DisAble -> Empld -> MCARM
  

  MI [exposure]
  MCARM [outcome]

  }")

ggdag::ggdag(dag_full) + ggdag::theme_dag_blank()
ggdag::tidy_dagitty(dag_full)
ggdag::ggdag_adjustment_set(dag_full) + ggdag::theme_dag_blank()
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


## Instrumental

# Ancestors 

# -------------------------------------------------------------------------


# Spares!
## Reserve
## SexOr
## Pols
## Educ
## USid
## MedDis




# NEW ---------------------------------------------------------------------


dag_a <- dagitty::dagitty(
  "dag{

  
  Iconf -> MCARM
  Iconf -> SCC -> MCARM
  Icomp -> MCARM
  Icomp -> SCC -> MCARM
  
  WIS -> Icomp
  WIS -> Iconf
  SCC 
  CivID -> Icomp
  CivID -> Iconf
  
  MCARM [outcome]

  }")
ggdag::ggdag(dag_a, edge_type = 'link_arc') + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_a) + ggdag::theme_dag()



dag_b <- dagitty::dagitty(
  "dag{

  
  Iconf -> MCARM
  Iconf -> SCC -> MCARM
  Icomp -> MCARM
  Icomp -> SCC -> MCARM
  
  MI -> WIS -> Icomp
  WIS -> Iconf
  MI -> SCC 
  MI -> CivID -> Icomp
  MI -> MCARM
  CivID -> Iconf
  
  MI [exposure]
  MCARM [outcome]

  }")
ggdag::ggdag(dag_b, edge_type = 'link_arc') + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_b) + ggdag::theme_dag()

