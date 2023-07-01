

# Write table containing model fit statistics

table_model_fit <-
  model_stats %>% 
  arrange(DV, desc(r_squared)) %>% 
  select(!c(IV, model)) %>% 
  mutate(f = paste(model_stats$f, "(", model_stats$numdf, ",", model_stats$dendf, ")",
                          sep = ""),
  ) %>% 
  select(!c(numdf, dendf)) %>% 
  mutate(DV = str_to_title(str_replace(DV, '_', ' ')),
         p.value = str_replace(as.character(p.value), '0.', '.'),
         r_squared = str_replace(as.character(r_squared), '0.', '.'),
         adj_r_squared = str_replace(as.character(adj_r_squared), '0.', '.')
         ) %>% 
  rename(R2 = r_squared, 
         `Adjusted R2` = adj_r_squared, 
         RMSE = rmse,
         F = f, 
         `p-value` = p.value) %>% 
  filter(DV != 'total')

## Print:
table_model_fit %>% print()

## Save:
table_model_fit %>% 
  write_csv(here::here('output/tables/identity-wound-model-fit.csv'))

## Message
if(exists('table_model_fit')) message('Model fit table saved to `output/results/identity-wound-model-fit.csv`')

## Clean Up:
rm(table_model_fit)


    
   
  