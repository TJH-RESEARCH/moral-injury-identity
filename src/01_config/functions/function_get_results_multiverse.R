


x = fit_multiverse_dissonance_robust_DV_dataset5
get_results_multiverse(fit_multiverse_dissonance_robust_DV_dataset5)

get_results_multiverse <- function(x){
  
  model_name = deparse(substitute(x))
  p = get_terms(x)
  i = 1
  data_set_list = unique(x[[1]]$tidy$dataset$dataset_categorical)
  
  y = list(NULL)
  
  for(i in  seq_along(data_set_list)){
    y[i] = x[[i]]$tidy %>% 
      bind_cols(
        list(x[[i]]$terms)
        
      )
    y2[i] = 
    
    
    DV = p[i, 1]
    IV = p[i, 2]
    
    
    y[[i]] <- y[[i]] %>% bind_cols(DV, IV)
    
    i = i + 1 
  }
  
  
  y = bind_rows(y)
  y = y %>% mutate(model = model_name,
                   terms = p)
  
  
  return(y)
}

# Test
# get_results(fit_set_1_controls)


