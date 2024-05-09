


# BIIS Conflict -----------------------------------------------------------
(coefplot_biis <-
  model_biis_2 %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  
  # Add robust standard errors
  mutate(se_robust = as.numeric(coeftest_biis_2[,2])) %>% 
  filter(term != '(Intercept)') %>% 
  ggplot(aes(x = estimate, 
             y = term, 
             xmin = (estimate - 2 * se_robust),
             xmax = (estimate + 2 * se_robust))) +
  geom_pointrange() +
  geom_vline(aes(xintercept = 0), linetype = 2) +
  theme_classic() +
  theme(axis.text = element_text(size = 14),
        text = element_text(size = 14)
  ) +
  xlab('Identity Conflict') +
  ylab('') +
  scale_y_discrete( 
    labels = c(
      mios_total = 'Moral Injury Symptoms',
      pc_ptsd_positive_screen = 'PTSD',
      sex_male = 'Male',
      race_black = 'Race: Black', 
      race_white = 'Race: White',
      branch_air_force = 'Branch: Air Force',
      branch_marines = 'Branch: Marines',
      branch_navy = 'Branch: Navy',
      service_era_post_911 = 'Post-9/11 Era',
      service_era_vietnam = 'Vietnam Era',
      service_era_persian_gulf = 'Persian Gulf Era',
      n_deploy = 'Deployments (#)',
      years_service = 'Years of Service'),
    limits = c(
      'years_service',
      'n_deploy',
      'service_era_vietnam', 
      'service_era_persian_gulf',
      'service_era_post_911', 
      'branch_navy',
      'branch_marines',
      'branch_air_force',
      'race_white',
      'race_black', 
      'sex_male',
      'pc_ptsd_positive_screen',
      'mios_total'
    ) 
  ) 
)





# BIIS Conflict -----------------------------------------------------------
(coefplot_connection <-
   model_wis_connection_2 %>% 
   broom::tidy(conf.int = T, conf.level = 0.95) %>% 
   
   # Add robust standard errors
   mutate(se_robust = as.numeric(coeftest_wis_connection_2[,2])) %>% 
   filter(term != '(Intercept)') %>% 
   ggplot(aes(x = estimate, 
              y = term, 
              xmin = (estimate - 2 * se_robust),
              xmax = (estimate + 2 * se_robust))) +
   geom_pointrange() +
   geom_vline(aes(xintercept = 0), linetype = 2) +
   theme_classic() +
   theme(axis.text = element_text(size = 14),
         text = element_text(size = 14)
   ) +
   xlab('Connection') +
   ylab('') +
   scale_y_discrete( 
     labels = c(
       mios_total = 'Moral Injury Symptoms',
       pc_ptsd_positive_screen = 'PTSD',
       sex_male = 'Male',
       race_black = 'Race: Black', 
       race_white = 'Race: White',
       branch_air_force = 'Branch: Air Force',
       branch_marines = 'Branch: Marines',
       branch_navy = 'Branch: Navy',
       service_era_post_911 = 'Post-9/11 Era',
       service_era_vietnam = 'Vietnam Era',
       service_era_persian_gulf = 'Persian Gulf Era',
       n_deploy = 'Deployments (#)',
       years_service = 'Years of Service'),
     limits = c(
       'years_service',
       'n_deploy',
       'service_era_vietnam', 
       'service_era_persian_gulf',
       'service_era_post_911', 
       'branch_navy',
       'branch_marines',
       'branch_air_force',
       'race_white',
       'race_black', 
       'sex_male',
       'pc_ptsd_positive_screen',
       'mios_total'
     ) 
   ) 
)



# BIIS Conflict -----------------------------------------------------------
(coefplot_interdependent <-
   model_wis_interdependent_2 %>% 
   broom::tidy(conf.int = T, conf.level = 0.95) %>% 
   
   # Add robust standard errors
   mutate(se_robust = as.numeric(coeftest_wis_interdependent_2[,2])) %>% 
   filter(term != '(Intercept)') %>% 
   ggplot(aes(x = estimate, 
              y = term, 
              xmin = (estimate - 2 * se_robust),
              xmax = (estimate + 2 * se_robust))) +
   geom_pointrange() +
   geom_vline(aes(xintercept = 0), linetype = 2) +
   theme_classic() +
   theme(axis.text = element_text(size = 14),
         text = element_text(size = 14)
   ) +
   xlab('Interdependence') +
   ylab('') +
   scale_y_discrete( 
     labels = c(
       mios_total = 'Moral Injury Symptoms',
       pc_ptsd_positive_screen = 'PTSD',
       sex_male = 'Male',
       race_black = 'Race: Black', 
       race_white = 'Race: White',
       branch_air_force = 'Branch: Air Force',
       branch_marines = 'Branch: Marines',
       branch_navy = 'Branch: Navy',
       service_era_post_911 = 'Post-9/11 Era',
       service_era_vietnam = 'Vietnam Era',
       service_era_persian_gulf = 'Persian Gulf Era',
       n_deploy = 'Deployments (#)',
       years_service = 'Years of Service'),
     limits = c(
       'years_service',
       'n_deploy',
       'service_era_vietnam', 
       'service_era_persian_gulf',
       'service_era_post_911', 
       'branch_navy',
       'branch_marines',
       'branch_air_force',
       'race_white',
       'race_black', 
       'sex_male',
       'pc_ptsd_positive_screen',
       'mios_total'
     ) 
   ) 
)




# -------------------------------------------------------------------------
bind_rows(
  model_biis_2 %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  
  # Add robust standard errors
  mutate(se_robust = as.numeric(coeftest_biis_2[,2])) %>% 
  filter(term == 'mios_total') %>% 
    mutate(outcome = c('Dissonance')),
  
  
  model_wis_connection_2 %>% 
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    
    # Add robust standard errors
    mutate(se_robust = as.numeric(coeftest_wis_connection_2[,2])) %>% 
    filter(term == 'mios_total') %>% 
    mutate(outcome = c('Connection')),
  
  model_wis_interdependent_2 %>% 
    broom::tidy(conf.int = T, conf.level = 0.95) %>% 
    
    # Add robust standard errors
    mutate(se_robust = as.numeric(coeftest_wis_interdependent_2[,2])) %>% 
    filter(term == 'mios_total') %>% 
    mutate(outcome = c('Interdependence'))
    
    
  ) %>% 
  ggplot(aes(x = estimate, 
             y = outcome, 
             xmin = (estimate - 2 * se_robust),
             xmax = (estimate + 2 * se_robust))) +
  geom_pointrange() +
  geom_vline(aes(xintercept = 0), linetype = 2) +
  theme_classic() +
  theme(axis.text = element_text(size = 14),
        text = element_text(size = 14)
  ) +
  xlab('Moral Injury Symptoms') +
  ylab('') +
  scale_y_discrete( 
    limits = c(
      'Dissonance',
      'Connection',
      'Interdependence'
    ) 
  ) 


1# -------------------------------------------------------------------------

library(patchwork)

plot_coef_1 <- (coefplot_mcarm + coefplot_civilians + coefplot_help_seeking)
plot_coef_2 <- (coefplot_purpose + coefplot_resent + coefplot_regiment) 

plot_coef_1 %>% print()
plot_coef_2 %>% print()

ggsave(filename = paste0('output/figures/coeficients_1.jpg'),
       plot = plot_coef_1)

ggsave(filename = paste0('output/figures/coeficients_2.jpg'),
       plot = plot_coef_2)


rm(
  coefplot_civilians,
  coefplot_help_seeking,
  coefplot_mcarm,
  coefplot_purpose,
  coefplot_regiment,
  coefplot_resent,
  plot_coef_1,
  plot_coef_2)




