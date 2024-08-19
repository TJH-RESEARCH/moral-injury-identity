

# MIOS --------------------------------------------------------------------
alpha_mios <-
  data %>% 
  select(mios_1, mios_2, mios_3, mios_4, mios_5, mios_6, mios_7, mios_8,
         mios_9, mios_10, mios_11, mios_12, mios_13, mios_14) %>% 
  psych::alpha()

# WIS Interdependence --------------------------------------------------------------
model_wis_interdependent <- 
  'interdependent =~ wis_interdependent_8 + wis_interdependent_9 + wis_interdependent_10 + wis_interdependent_11 + wis_interdependent_12 + wis_interdependent_13 + wis_interdependent_14'

fit_wis_interdependent <- 
  lavaan::cfa(model_wis_interdependent, data, 
              std.lv = F, ordered = F, estimator = 'MLR')


# WIS Private Regard -------------------------------------------------------
model_wis_private_regard <- 
  'private_regard =~ wis_private_1 + wis_private_2 + wis_private_3 + wis_private_4 + wis_private_5 + wis_private_6 + wis_private_7'

fit_wis_private_regard <- 
  lavaan::cfa(model_wis_private_regard, data, 
              std.lv = F, ordered = F, estimator = 'MLR')


# PSYCHOMETRICS -----------------------------------------------------------
psychometrics <-
  tibble(
  variable = 
    c(
      'Moral Injury Symptoms',
      'Military Identity Attachment',
      'Regard for the Military'),
  
  measure = 
    c(
      'Moral Injury Outcomes Scale',
      'Warrior Identity Scale: Interdependence Subscale',
      'Warrior Identity Scale: Private Regard Subscale'
       ),
  
  alpha = 
    c(
      alpha_mios$total[1] %>% round(2) %>% as.numeric(),
      fit_wis_interdependent %>% semTools::reliability() %>% tibble() %>% slice(1) %>% round(2) %>% as.numeric(),
      fit_wis_private_regard %>% semTools::reliability() %>% tibble() %>% slice(1) %>% round(2) %>% as.numeric()
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
  write_lines(file = here::here('output/tables/results-tables.txt'), append = TRUE)
