


# Append to Results Log -------------------------------------------------------------------

append_results_regression <-
  function(table, gof_stats){

  ifelse(test = 
         dir.exists(here::here('output/results/results-tables.txt')) == FALSE,
       yes = 
         write_lines( 
           c(
             read_lines(here::here('output/results/results-tables.txt')),
             read_lines(table)[1:26], 
             read_lines(gof_stats, skip = 26)
           ),
           file = paste(here::here('output/results/results-tables.txt'))
         ),
       no = 
         write_lines( 
           c(read_lines(table)[1:26],
             read_lines(gof_stats, skip = 26)),
           file = paste(here::here('output/results/results-tables.txt'))
         )
)

  
  }




# Append to Results Log -------------------------------------------------------------------

append_results_tables <-
  function(table){
    
    if(dir.exists(here::here('output/results/results-tables.txt'))){
      
      write_lines( 
        table,
        file = paste(here::here('output/results/results-tables.txt'))
      )
     
      
    }
      
    if(dir.exists(here::here('output/results/results-tables.txt')) == F){
      
      write_lines( 
        c(
          read_lines(here::here('output/results/results-tables.txt')),
          read_lines(table) 
        ),
        file = paste(here::here('output/results/results-tables.txt'))
      )
      
    }
  }
    
           