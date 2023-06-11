

create_percentage_table <- function(data){
  
  data %>% 
    tidyr::pivot_longer(everything(), names_to = 'item', values_to = 'response') %>% 
    group_by(item) %>% 
    summarize(total = n(), sum = sum(response, na.rm = T), perc = sum/total * 100)
}
