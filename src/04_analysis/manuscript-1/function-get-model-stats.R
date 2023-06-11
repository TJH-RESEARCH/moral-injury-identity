

# Make function to get results from lists



# R Squared ---------------------------------------------------------------

get_r_squared <- function(x){
  
  # 
  y = list(NULL)
  
  # 
  for (i in 1:length(x)) {
    y[i] = x[[i]][4]
    i +1
  }
  # Unlist and tidy the results
  y = y %>% unlist() %>% tibble() %>% rename(r_squared = 1)
  return(y)
}



# Adjusted R Squared ------------------------------------------------------

get_adj_r_squared <- function(x){
  
  # 
  y = list(NULL)
  
  # 
  for (i in 1:length(x)) {
    y[i] = x[[i]][3]
    i + 1
  }
  # Unlist and tidy the results
  y = y %>% unlist() %>% tibble() %>% rename(adj_r_squared = 1)
  return(y)
}


# Terms -------------------------------------------------------------------

get_terms <- function(x){
  
  # 
  y = list(NULL)
  
  # 
  for (i in 1:length(x)) {
    y[i] = str_remove(as.character(x[[i]][5]), "list\\(")
    y[i] = str_remove(y[i], "\\)")
    y[i] = str_replace(y[i],pattern = ", ", " ~ ")
    i + 1
  }
  # Unlist and tidy the results
  y = y %>% unlist() %>% tibble() %>% rename(terms = 1)
  
  yy = list(NULL)
  xx = list(NULL)
  
  for (i in 1:length(x)) {
    yy[i] = str_trim(str_split(y$terms, pattern = '~')[[i]][1])
    xx[i] = str_trim(str_split(y$terms, pattern = '~')[[i]][2])
  }
  
  # Unlist and tidy the results
  yy = yy %>% unlist()
  xx = xx %>% unlist()
  
  y = 
    tibble(
      DV = yy,
      IV = xx
    )
  
  return(y)
}


# F -----------------------------------------------------------------------

get_f <- function(x){
  
  # Open null lists
  y = list(NULL)
  f = list(NULL)
  numdf = list(NULL)
  dendf = list(NULL)
  
  # 
  for (i in 1:length(x)) {
    y[i] = x[[i]][2]
    f[i] = y[[1]][1]
    numdf[i] = y[[1]][2]
    dendf[i] = y[[1]][3]
    i + 1
  }
  # Unlist and tidy the results
  y = tibble(
    f = f %>% unlist(),
    numdf = numdf %>% unlist(),
    dendf = dendf %>% unlist()
  )
  
  return(y)
}


# Get Results Function ----------------------------------------------------
## Puts everything together in one tibble

get_model_stats <- function(x){
 
  model_name = deparse(substitute(x))
  
  x1 = get_terms(x)
  x2 = get_f(x)
  x3 = get_adj_r_squared(x)
  x4 = get_r_squared(x)
  
  y = bind_cols(x2, x3, x4, x1)
  y = 
    y %>% 
    mutate(model = model_name,
           DV = str_remove(DV, 'wis_'),
           DV = str_remove(DV, '_total'),
           model = str_remove(model, 'fit_'),
           ) %>% 
    select(DV, model, adj_r_squared, r_squared, everything())
  
  return(y)
}


# Test
#x <- get_results(results_set_2_controls)
#x

