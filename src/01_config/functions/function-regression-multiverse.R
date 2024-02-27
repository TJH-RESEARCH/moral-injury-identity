
# Creates a custom linear regression function that takes a list
# of independent variables as input.


lm_custom_multiverse <-
  function(data_multiverse, DV, data_set_number, IVs){
    
    IVs <- str_flatten_comma(IVs)
    IVs <- str_replace_all(IVs, ', ', ' + ')
    formula <- as.formula(paste(as.character(DV), " ~ ", IVs, sep = ""))
    
    data_set <-
      data_multiverse %>% filter(dataset_number == as.numeric(paste(data_set_number))) %>% 
      select(dataset_categorical) %>% unique()
    
    model <- 
      data_multiverse %>% 
      filter(dataset_number == as.numeric(paste(data_set_number))) %>% 
      lm(
        formula = formula,
        data = .
      )
    
    tidy <- model %>% 
      lm.beta::lm.beta() %>% 
      broom::tidy(conf.int = TRUE, 
                  conf.level = 0.95) %>% 
      mutate(p.value = round(p.value, 3),
             std_estimate = round(std_estimate, 3),
             std.error = round(std.error, 3),
             estimate = round(estimate, 3),
             dataset = data_set
               )
    
    model <-
      list(
        summary = model,
        f = round(summary(model)$fstatistic, 3),
        adj_R_squared = round(summary(model)$adj.r.squared[[1]], 3),
        R_squared = round(summary(model)$r.squared[[1]], 3),
        terms = attr(model$terms, "variables"),
        tidy = tidy
      )
    
    print('Formula:')
    print(formula)
    print(model$tidy)
    print('Adjusted R-squared:')
    print(model$adj_R_squared)
    return(model)
    
  }
