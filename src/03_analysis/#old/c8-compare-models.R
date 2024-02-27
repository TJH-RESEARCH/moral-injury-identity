# Model Fit Measures


# Compare Models ----------------------------------------------------------
hierarchical_comparison <- anova(model_0, model_1, model_2, model_3)

hierarchical_comparison <-
  tibble(model = c('null', 1, 2, 3),
         res_df = hierarchical_comparison$Res.Df,
         rss = hierarchical_comparison$RSS,
         df = hierarchical_comparison$Df,
         sum_sq = hierarchical_comparison$`Sum of Sq`,
         f_stat = hierarchical_comparison$`F`,
         p = hierarchical_comparison$`Pr(>F)`,
         r_sq = c(model_0_results$r.squared,
                  model_1_results$r.squared,
                  model_2_results$r.squared,
                  model_3_results$r.squared),
         diff_r_sq = r_sq - lag(r_sq),
         adj_r_sq = c(model_0_results$adj.r.squared,
                      model_1_results$adj.r.squared,
                      model_2_results$adj.r.squared,
                      model_3_results$adj.r.squared)
  )


## Print:
hierarchical_comparison %>% print()

# Write to CSV in output folder -------------------------------------------

hierarchical_comparison %>% 
  mutate(across(c(sum_sq, r_sq, adj_r_sq), ~ round(.x, 3)),
         across(c(f_stat), ~ round(.x, 4))
  ) %>% 
  write_csv(here::here('output/results/c8-hierarchical-comparison.csv'))

# Message:
if(exists('hierarchical_comparison')) message('Results of comparison of nested models saved as `output/results/c8-hierarchical-comparison.csv`')

rm(hierarchical_comparison)
