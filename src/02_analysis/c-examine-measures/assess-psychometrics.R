

psychometrics <-
  tibble(
  variable = 
    c('Identity Dissonance', 
      'Moral Injury',
      'Military Identity Attachment',
      'Percieved Public Regard for the Military'),
  
  measure = 
    c('BIIS-2 Conflict', 
      'Moral Injury Symptoms',
      'WIS Interdependent',
      'WIS Public Regard'
       ),
  
  alpha = 
    c(
      fit_biis_conflict %>% semTools::reliability() %>% tibble() %>% slice(1) %>% round(2) %>% as.numeric(),
      alpha_mios$total[1] %>% round(2) %>% as.numeric(),
      fit_wis_interdependent %>% semTools::reliability() %>% tibble() %>% slice(1) %>% round(2) %>% as.numeric(),
      fit_wis_public_regard %>% semTools::reliability() %>% tibble() %>% slice(1) %>% round(2) %>% as.numeric()
    )
)

# Print
psychometrics %>% print(n = 100)

# Write
psychometrics %>% write_csv(here::here('output/tables/psychometrics.csv'))

psychometrics %>% kableExtra::kbl(format = 'latex') %>% 
  write_lines(here::here('output/tables/psychometrics-latex.txt'))

psychometrics %>% kableExtra::kbl(format = 'latex') %>% 
  append_results_tables()

