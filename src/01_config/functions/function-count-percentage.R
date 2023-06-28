

# Creates a helper function to count the percentage of demographics

count_perc <-
  function(x, sort){
    x = 
      x %>% 
      count(sort = sort) %>% 
      ungroup() %>% 
      mutate(perc = n / sum(n) * 100) %>% 
      rename(category = 1)
    
    if(!is.character(x$category)){
      x = x %>% mutate(category = as.character(category))
    }
    
    return(x)
    
  }
