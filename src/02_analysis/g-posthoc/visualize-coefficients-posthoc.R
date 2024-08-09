

bind_rows(



model_wis_interdependent_2 %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  mutate(se_robust = as.numeric(coeftest_wis_interdependent_2[,2])) %>% 
  filter(term == 'mios_total') %>% 
  mutate(outcome = 'Attachment') %>% 
  mutate(term = if_else(term == 'mios_total',
                        'MI: Attachment', NA
  )), 


model_biis_2 %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  mutate(se_robust = as.numeric(coeftest_biis_2[,2])) %>% 
  filter(term == 'mios_total') %>% 
  mutate(outcome = 'Identity Dissonance') %>% 
  mutate(term = if_else(term == 'mios_total',
                        'MI: Dissonance', NA
  )),



model_biis_interact_2 %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  mutate(se_robust = as.numeric(coeftest_biis_interact_2[,2])) %>% 
  slice(c(2, 15, 16)) %>% 
  mutate(outcome = 'Identity Dissonance: Interaction')



) %>% 
arrange(outcome) %>% 
  ggplot(aes(x = estimate, 
             y = term, 
             xmin = (estimate - 2 * se_robust),
             xmax = (estimate + 2 * se_robust),
             color = outcome)) +
  scale_color_manual(values = c('#440154', 
                                  '#3b528b',
                                  '#21908C',
                                  '#5ec962',
                                  '#C7E020')) +
  geom_pointrange(size = 1, linewidth = 1.5) +
  geom_vline(aes(xintercept = 0), linetype = 2) +
  theme_classic() +
  theme(axis.text = element_text(size = 14),
        text = element_text(size = 14)
  ) +
  xlab('Unstandardized Coefficient') +
  ylab('') +
  scale_y_discrete( 
    labels = c(
      
      `MI: Attachment` = 'Attachment on Moral Injury', 
      `MI: Dissonance` = 'Dissonance on Moral Injury', 
      `wis_public_regard_total` = 'Dissonance on Public Regard (I) ', 
      `mios_total:wis_public_regard_total` = 'Dissonance on Interaction (I)', 
      `mios_total` = 'Dissonance on Moral Injury (I)'
      
      
    ),
    limits = c(
      'mios_total:wis_public_regard_total',
      'wis_public_regard_total',
      'mios_total',
      'MI: Dissonance',
      'MI: Attachment'
      
    ) 
  ) +
  theme(legend.position = 'none')








e# Total -------------------------------------------------------------------


model_mcarm_2 %>% 
  broom::tidy(conf.int = T, conf.level = 0.95) %>% 
  
  # Add robust standard errors
  mutate(se_robust = as.numeric(coeftest_mcarm_2[,2])) %>% 
  filter(term == 'clusterLower Identity' |
           term == 'clusterHigher Identity') %>% 
  mutate(outcome = 'Rentegration') %>% 
  mutate(term = if_else(term == 'clusterLower Identity',
                        'Lower: Reintegration', 
                        'Higher: Reintegration'
  ))