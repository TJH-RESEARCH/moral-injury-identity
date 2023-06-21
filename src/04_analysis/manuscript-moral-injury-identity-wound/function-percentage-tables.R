

create_percentage_table <- function(data){
  
  data %>% 
    tidyr::pivot_longer(everything(), names_to = 'category', values_to = 'response') %>% 
    group_by(category) %>% 
    summarize(total = n(), n = sum(response, na.rm = T), perc = n/total * 100) %>% 
    select(!total)
}
