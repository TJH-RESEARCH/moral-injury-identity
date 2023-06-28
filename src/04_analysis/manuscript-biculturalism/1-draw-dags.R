### Military-Civilian Biculturalism?: 
### Bicultural Identity and the Adjustment of Separated Service Members

# DAG Basic -------------------------------------------------------------------

dag_basic <- dagitty::dagitty(
  "dag{

  
  WIS -> Compart
  WIS -> Conflict
  Civilian_ID -> Compart
  Civilian_ID -> Conflict
  
  WIS [exposure]
  Civilian_ID [exposure]
  Compart [outcome]
  Conflict [outcome]

  }")
set.seed(104)
ggdag::ggdag(dag_basic, edge_type = 'link_arc', text_size = 4, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_basic,text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()



# DAG Big -------------------------------------------------------------------

dag_big <- dagitty::dagitty(
  "dag{


  WIS -> Compart
  WIS -> Conflict
  Civilian_ID -> Compart
  Civilian_ID -> Conflict

  WIS -> Compart
  WIS -> Conflict
  Civilian_ID -> Compart
  Civilian_ID -> Conflict
  
  YrsServe -> YrsSep
  YrsServe -> WIS
  YrsServe -> Rank -> WIS
  YrsSep -> WIS
  YrsSep -> Civilian_ID
  
  MilFam -> WIS
  
  Rank -> WIS
  Race -> WIS
  Race -> Rank
  
  Sex -> Rank
  Sex -> WIS

    
     WIS [exposure]
  Civilian_ID [exposure]
  Compart [outcome]
  Conflict [outcome]

  }")
set.seed(104)
ggdag::ggdag(dag_big, 
             edge_type = 'link_arc', 
             text_size = 3.5, text_col = "#0072B2", node = F) + ggdag::theme_dag()
ggdag::ggdag_adjustment_set(dag_big,text_size = 4,node = F, text_col = "#0072B2") + ggdag::theme_dag()
