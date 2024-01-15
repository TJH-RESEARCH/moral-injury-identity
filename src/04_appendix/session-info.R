session_info <- sessionInfo() 
session_info %>% print()

session_info %>%
  write_rds(
    paste(here::here(), 
          '/output/session-info/session-info-', 
          Sys.Date(), 
          '.rds',
          sep = '')
    )


rm(session_info)


# Citations ---------------------------------------------------------------

message('Analysis was performed with the following packages:')
print(citation('lm.beta'))
print(citation('lavaan'))
