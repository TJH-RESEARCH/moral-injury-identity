# Effect size Cohen's f2

# Different in variance explained with and 
#  without the variable over the variance
#  still not explained when all variables in model.


effect_size_f2 <-
  tibble(
    variable = 'Moral Injury Symptoms',
    `Effect Size: f2` = (model_3_results$r.squared -  
            model_2_results$r.squared) / 
           (1 - model_3_results$r.squared)
  )

effect_size_f2 %>% print()
effect_size_f2 %>% write_csv(here::here('output/stats/effect-size-f2.csv'))
message('Effect Size f2 saved to `output/stats/effect-size-f2.csv`')
rm(effect_size_f2)
