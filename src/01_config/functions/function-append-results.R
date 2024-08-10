

# Append to Results Log -------------------------------------------------------------------

append_results_tables <-
  function(table){
    
    if(dir.exists(here::here('output/tables/results-tables.txt'))){
      
      write_lines( 
        table,
        file = here::here('output/tables/results-tables.txt')
      )
     
      
    }
      
    if(dir.exists(here::here('output/tables/results-tables.txt')) == F){
      
      write_lines( 
        c(
          read_lines(here::here('output/tables/results-tables.txt')),
          read_lines(table) 
        ),
        file = here::here('output/tables/results-tables.txt')
      )
      
    }
  }
    
           