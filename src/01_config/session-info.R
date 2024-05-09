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

