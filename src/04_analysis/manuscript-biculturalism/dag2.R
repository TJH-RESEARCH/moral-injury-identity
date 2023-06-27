
# DAG Basic -------------------------------------------------------------------

dag_basic <- dagitty::dagitty(
  "dag{

  
  Iconf -> MCARM
  Iconf -> SCC -> MCARM
  Icomp -> MCARM
  
  
  WIS -> Icomp
  WIS -> Iconf
  CivID -> Icomp
  CivID -> Iconf
  
  
  MCARM [outcome]

  }")
set.seed(104)
ggdag::ggdag(dag_basic, edge_type = 'link_arc', text_size = 4, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_basic,text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()



# DAG Big -------------------------------------------------------------------

dag_big <- dagitty::dagitty(
  "dag{

  
  Iconf -> MCARM
  Iconf -> SCC -> MCARM
  Icomp -> MCARM
  
  
  WIS -> Icomp
  WIS -> Iconf
  CivID -> Icomp
  CivID -> Iconf
  
  Age -> Era -> Combat
  Age -> YoS -> YSep
  YoS -> WIS
  YoS -> Rank -> WIS
  YSep -> WIS
  YSep -> CivID
  
  Rank -> MCARM
  
  PMIE <- Combat -> Trauma
  
  MilFam -> WIS
  
  Rank -> WIS
  Race -> WIS
  Race -> Rank
  
  Sex -> Rank
  Sex -> WIS
  Sex -> PMIE
  Sex -> Trauma
  

  MCARM [outcome]

  }")
set.seed(104)
ggdag::ggdag(dag_big, edge_type = 'link_arc', text_size = 4, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_big,text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()


# DAG MI -------------------------------------------------------------------

dag_mi <- dagitty::dagitty(
  "dag{

  
  Iconf -> MCARM
  Iconf -> SCC -> MCARM
  Icomp -> MCARM
  
  
  WIS -> Icomp
  WIS -> Iconf
  CivID -> Icomp
  CivID -> Iconf
  
  Age -> Era -> Combat
  Age -> YoS -> YSep
  YoS -> WIS
  YoS -> Rank -> WIS
  YSep -> WIS
  YSep -> CivID
  
  Rank -> MCARM
  
  PMIE <- Combat -> Trauma
  
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
  
  Trauma -> DisAble -> MCARM
   
  MI -> MCARM
  MI -> WIS -> MCARM
  MI -> CivID -> MCARM
  MI -> SCC -> MCARM
  
  bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  MCARM <- bIPF -> CivID
  PTSD <- PMIE 
  PTSD <-> MI
  PTSD -> MCARM
  MI -> DisAble <- PTSD
  Trauma -> MI
  MI -> WIS <- PTSD
  
  MI [exposure]
  MCARM [outcome]

  }")
set.seed(104)
ggdag::ggdag(dag_mi, edge_type = 'link_arc', text_size = 4, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_mi,text_size = 4,node = F, text_col = "#0072B2",shadow = T) + ggdag::theme_dag()
dag_mi
dag_mi %>% tidy_dagitty() %>% arrange(to, name) %>% print(n = 100)
dag_mi %>% dagitty::adjustmentSets()





# DAG id -------------------------------------------------------------------

dag_id <- dagitty::dagitty(
  "dag{

  
  Iconf -> MCARM
  Iconf -> SCC -> MCARM
  Icomp -> MCARM
  
  
  WIS -> Icomp
  WIS -> Iconf
  CivID -> Icomp
  CivID -> Iconf
  
  Age -> Era -> Combat
  Age -> YoS -> YSep
  YoS -> WIS
  YoS -> Rank -> WIS
  YSep -> WIS
  YSep -> CivID
  
  Rank -> MCARM
  
  PMIE <- Combat -> Trauma
  
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
  
  Trauma -> DisAble -> MCARM
   
  MI -> MCARM
  MI -> WIS -> MCARM
  MI -> CivID -> MCARM
  MI -> SCC -> MCARM
  
  bIPF <- MI <- PMIE  <-> Trauma -> PTSD -> bIPF -> WIS -> MCARM
  MCARM <- bIPF -> CivID
  PTSD <- PMIE 
  PTSD <-> MI
  PTSD -> MCARM
  MI -> DisAble <- PTSD
  Trauma -> MI
  MI -> WIS <- PTSD
  
  WIS [exposure]
  CivID [exposure]
  MCARM [outcome]

  }")
set.seed(104)
ggdag::ggdag(dag_id, edge_type = 'link_arc', text_size = 4, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_id,text_size = 4,node = F, text_col = "#0072B2",shadow = T) + ggdag::theme_dag()
dag_id
dag_id %>% tidy_dagitty() %>% arrange(to, name) %>% print(n = 100)
dag_id %>% dagitty::adjustmentSets()


