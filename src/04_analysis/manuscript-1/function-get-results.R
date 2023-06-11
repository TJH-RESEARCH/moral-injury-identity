


get_results <- function(x){
  
  model_name = deparse(substitute(x))
  p = get_terms(x)
  i = 1
  
  y = list(NULL)
  for(i in 1:length(x)){
    y[i] = list(x[[i]]$tidy)
    y[[i]] = bind_cols(y[[i]], 
                     rep(p[i,1], nrow(y[i][[1]])) %>% unlist() %>% tibble() %>% rename(DV = 1), 
                     rep(p[i,2], nrow(y[i][[1]])) %>% unlist() %>% tibble() %>% rename(IV = 1),
                     rep(model_name, nrow(y[i][[1]])) %>% tibble() %>% rename(model = 1),
    )
    
 i = i + 1 
}

  y = bind_rows(y)
  
  y = y %>% 
    mutate(model = model_name,
           DV = str_remove(DV, 'wis_'),
           DV = str_remove(DV, '_total'),
           model = str_remove(model, 'fit_')
          ) %>% 
    select(DV, model, everything())
  return(y)
}

# Test
# get_results(fit_set_1_controls)
