
library(dagitty)
library(ggdag)

set.seed(300)

# DAG: Bivariate --------------------------------------------------------------------
dag_bivariate <- dagitty::dagitty(
  "dag{
  
  mios_total -> mcarm_total 
  
  mios_total [exposure]
  mcarm_total [outcome]
  
  }")
ggdag::ggdag(dag_bivariate)


# DAG: Mediation "Identity"   -------------------------------------------------
dag_mediation_ab <- dagitty::dagitty(
  "dag{
  
  mios_total -> mcarm_total 
  mios_total -> identity
  identity -> mcarm_total
  
  mios_total [exposure]
  mcarm_total [outcome]
  
  }")
ggdag::ggdag(dag_mediation_ab)


# DAG: Intervening Variables   -------------------------------------------------
dag_intervening <- dagitty::dagitty(
  "dag{
  
  mios_total -> mcarm_total 
  mios_total -> identity -> mcarm_total
  mios_total -> unmet_needs -> mcarm_total
  
  mios_total [exposure]
  mcarm_total [outcome]
  
  }")
ggdag::ggdag(dag_intervening)


# DAG: Antecdents   -------------------------------------------------
dag_antecedents <- dagitty::dagitty(
  "dag{

  mios_total <- mios_ptsd_symptoms_total -> mcarm_total 
  mios_total -> mcarm_total 
  
  
  mios_total [exposure]
  mcarm_total [outcome]
  
  }")
ggdag::ggdag(dag_antecedents)




# DAG:    -------------------------------------------------
dag_military_biis <- dagitty::dagitty(
  "dag{

  
  mios_total -> military_identity -> mcarm_total
  military_identity -> biis -> mcarm_total
  mios_total -> mcarm_total 
  
  
  mios_total [exposure]
  mcarm_total [outcome]
  
  }")
ggdag::ggdag(dag_military_biis)


# DAG:    -------------------------------------------------
dag_model_1 <- dagitty::dagitty(
  "dag{

  
  mios -> military -> biis
  mios -> civilian -> biis
  military -> biis -> mcarm
  biis -> scc -> mcarm
  mios -> scc
  mios -> mcarm 
  mios <- ptsd -> mcarm 
  
  
  mios [exposure]
  mcarm [outcome]
  
  }")
ggdag::ggdag(dag_model_1)
ggdag_paths(dag_model_1)
ggdag_adjustment_set(dag_model_1)
adjustmentSets(dag_model_1)



# DAG 2:    -------------------------------------------------
dag_model_2 <- dagitty::dagitty(
  "dag{

  
  mios -> military -> biis
  mios -> civilian -> biis
  military -> biis -> mcarm
  biis -> scc -> mcarm
  mios -> scc
  mios -> mcarm 
  mios <- ptsd -> mcarm 
  
  mios_event <-> ptsd_event
  mios <-> ptsd

  ptsd_event -> ptsd
  ptsd_event -> mios
  mios_event -> ptsd
  mios_event -> mios
  ptsd -> mcarm

  
  mios [exposure]
  mcarm [outcome]
  
  }")
ggdag::ggdag(dag_model_2)
ggdag_paths(dag_model_2)
ggdag_adjustment_set(dag_model_2)
adjustmentSets(dag_model_2)


bigger_dag <- dagify(mcarm ~ x + a + b,
                     x ~ a + b,
                     exposure = "x",
                     outcome = "mcarm"
)
ggdag::ggdag(bigger_dag)
ggdag_paths(bigger_dag)




# exampl ------------------------------------------------------------------

bigger_dag <- dagify(y ~ x + a + b,
                     x ~ a + b,
                     exposure = "x",
                     outcome = "y"
)
ggdag::ggdag(bigger_dag)




dagitty::paths(dag_full_model)
ggdag::tidy_dagitty(dag_full_model)
set.seed(12)
ggdag::ggdag(dag_full_model) + theme_dag_gray()
ggdag::ggdag_paths(dag_full_model)
dagitty::adjustmentSets(dag_full_model)
?adjustmentSets()


# DAG: No events ----------------------------------------------------------




dag_full_model <- dagitty::dagitty(
  "dag{
  mios_screener <-> mios_criterion_a
  mios_total <-> mios_ptsd_symptoms_total
  
  mios_criterion_a -> mios_ptsd_symptoms_total
  mios_criterion_a -> mios_total
  mios_screener -> mios_ptsd_symptoms_total
  mios_screener -> mios_total
  
  military_exp_combat -> mios_screener
  military_exp_combat -> mios_criterion_a
  
  mios_ptsd_symptoms_total -> mcarm_total
  mios_total -> mcarm_total 
  
  mios_total -> wis_private_total
  mios_total -> wis_public_total
  
  mios_total -> biis_total
  biis_total -> mcarm_total
  
  wis_private_total <-> wis_public_total
  wis_private_total -> mcarm_total
  wis_public_total -> mcarm_total
  
  mios_total [exposure]
  mcarm_total [outcome]
  }")

dagitty::paths(dag_full_model)
ggdag::tidy_dagitty(dag_full_model)
set.seed(12)
ggdag::ggdag(dag_full_model) + theme_dag_gray()
ggdag::ggdag_paths(dag_full_model)
dagitty::adjustmentSets(dag_full_model)
?adjustmentSets()







# -------------------------------------------------------------------------


military_exp_combat -> mios_screener
military_exp_combat -> mios_criterion_a

mios_total -> mcarm_total 





