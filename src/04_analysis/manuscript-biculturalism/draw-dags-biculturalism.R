
library(dagitty)
library(ggdag)

set.seed(1)

# DAG a -------------------------------------------------------------------


dag_a <- dagitty::dagitty(
  "dag{

  
  Iconf -> MCARM
  SCC -> MCARM
  Icomp -> MCARM
  
  WIS -> Icomp
  WIS -> Iconf
  CivID -> Icomp
  CivID -> Iconf
  
  Icomp [exposure]
  Iconf [exposure]
  MCARM [outcome]
  

  }")
ggdag::ggdag(dag_a, edge_type = 'link_arc') + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_a) + ggdag::theme_dag()

# DAG b -------------------------------------------------------------------

dag_b <- dagitty::dagitty(
  "dag{

  
  Iconf -> MCARM
  SCC -> MCARM
  Icomp -> MCARM
  
  
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
set.seed(101)
ggdag::ggdag_adjustment_set(dag_b) + ggdag::theme_dag()





# -------------------------------------------------------------------------
dag_id <- dagitty::dagitty(
  "dag{
  
   MI -> MCARM
  MI -> WIS -> MCARM
  MI -> CivID -> MCARM
  MI -> SCC -> MCARM
  
  WIS -> Iconf <- CivID
  WIS -> Icomp <- CivID
  Iconf -> MCARM
  Iconf -> SCC
  Icomp -> MCARM
  
  bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  MCARM <- bIPF -> CivID
  
  PTSD <- PMIE 
  PTSD <-> MI
  PTSD -> MCARM
  MI -> DisAble <- PTSD
  Trauma -> DisAble -> MCARM
  Trauma -> MedDis
  Trauma -> MI
  MI -> WIS <- PTSD
  
  
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
  

  
  Icomp [exposure]
  Iconf [exposure]
  MCARM [outcome]

  }")

ggdag::ggdag(dag_id) + ggdag::theme_dag_blank()
ggdag::tidy_dagitty(dag_id)
ggdag::ggdag_adjustment_set(dag_id) + ggdag::theme_dag_blank()
ggdag::tidy_dagitty(dag_id)





# New ---------------------------------------------------------------------



# DAG a -------------------------------------------------------------------


dag_a <- dagitty::dagitty(
  "dag{

  
  Iconf -> MCARM
  Iconf -> SCC -> MCARM
  Icomp -> MCARM
  
  WIS -> Icomp
  WIS -> Iconf
  CivID -> Icomp
  CivID -> Iconf
  
  Icomp [exposure]
  Iconf [exposure]
  MCARM [outcome]
  

  }")
ggdag::ggdag(dag_a, edge_type = 'link_arc') + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_a) + ggdag::theme_dag()

