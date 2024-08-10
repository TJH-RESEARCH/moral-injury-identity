

# MIOS --------------------------------------------------------------------
alpha_mios <-
  data %>% 
  select(mios_1, mios_2, mios_3, mios_4, mios_5, mios_6, mios_7, mios_8,
         mios_9, mios_10, mios_11, mios_12, mios_13, mios_14) %>% 
  psych::alpha()


# BIIS Conflict --------------------------------------------------------------
model_biis_conflict <- 
  'conflict =~ biis_1 + biis_2 + biis_3 + biis_4 + biis_5 + biis_6 + biis_7 + biis_8 + biis_9 + biis_10'

fit_biis_conflict <- 
  lavaan::cfa(model_biis_conflict, data, 
              std.lv = T, orthogonal = FALSE, estimator = 'MLR')


# WIS Interdependence --------------------------------------------------------------
model_wis_interdependent <- 
  'interdependent =~ wis_interdependent_8 + wis_interdependent_9 + wis_interdependent_10 + wis_interdependent_11 + wis_interdependent_12 + wis_interdependent_13 + wis_interdependent_14'

fit_wis_interdependent <- 
  lavaan::cfa(model_wis_interdependent, data, 
              std.lv = F, ordered = F, estimator = 'MLR')


# WIS Public Regard -------------------------------------------------------
model_wis_public_regard <- 
  'public_regard =~ wis_public_25 + wis_public_26 + wis_public_27 + wis_public_28'

fit_wis_public_regard <- 
  lavaan::cfa(model_wis_public_regard, data, 
              std.lv = F, ordered = F, estimator = 'MLR')


# PSYCHOMETRICS -----------------------------------------------------------
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

psychometrics %>% 
  kbl(caption = "Psychometric Properties of Measures",
      format = "latex",
      #col.names = c("Gender","Education","Count","Mean","Median","SD"),
      align = "l") %>%
  gsub("\\\\hline", "", .) %>% 
  kable_classic(full_width = F, 
                html_font = "helvetica") %>% 
  append_results_tables()


