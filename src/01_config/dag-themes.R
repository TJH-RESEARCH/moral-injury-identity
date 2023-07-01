
# DAG THEMES

# Saves the function with preset theme for DAGs: `ggdag_custom()`


# Library -----------------------------------------------------------------
library(ggdag)

# ggdag_custom() -----------------------------------------------------------------
ggdag_custom <-
  function(data_dag) {
    set.seed(104)
    ggdag::ggdag(data_dag, 
                 edge_type = 'link_arc', 
                 text_size = 4, 
                 text_col = "#0072B2", 
                 node = F) + 
      ggdag::theme_dag()
  }


# ggdag_adjustment_set_custom ---------------------------------------------

ggdag_adjustment_set_custom <-
  function(data_dag) {
    set.seed(104)
    ggdag::ggdag_adjustment_set(data_dag,
                                text_size = 4,
                                node = F, 
                                text_col = "#0072B2") + 
      ggdag::theme_dag()
  }
