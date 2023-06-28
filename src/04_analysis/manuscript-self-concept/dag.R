
# DAG SCC Mediate -------------------------------------------------------------------

dag_basic_mediate <- dagitty::dagitty(
  "dag{

  
  Conflict -> MCARM
  Conflict -> SCC ->MCARM
  Compart -> MCARM
  
  MI -> WIS -> Compart
  WIS -> Conflict
  MI -> Civilian_ID -> Compart
  Civilian_ID -> Conflict
  
  Compart [exposure]
  Conflict [exposure]
  MCARM [outcome]
  

  }")
set.seed(11)
ggdag::ggdag(dag_basic_mediate, edge_type = 'link_arc', text_size = 4, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_basic_mediate, text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()

