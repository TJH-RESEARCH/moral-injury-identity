# Regression Tables


  

# Get regression results and bind them by rows -------------------------------------------------------

get_results(fit_set_1_controls_precision) %>% 
  filter(DV != 'total') %>% 

# Add significance stars --------------------------------------------------

  mutate(p.stars = 
    
    case_when(p.value <= .05 ~ '*',
              p.value <= .01 ~ '**',
              p.value <= .001 ~ '***',
              .default = ''
    )
         ) %>% 
  

# Set numeric to character ------------------------------------------------
## We need to combine columns of different types when we 'pivot' the data
  
  mutate(estimate = str_c(as.character(estimate), p.stars ),
         std_estimate = str_c( '(', as.character(std_estimate), ')')
         ) %>% 
  select(term, estimate, std_estimate, DV) %>% #print(n = 100) 
  

# Pivot longer ------------------------------------------------------------
## Combine standardized and non-standardized coefficients in one column:

pivot_longer(cols = -c(term, DV)) %>% 
  

# Add an abbreviation of standard to the IVs ------------------------------
  mutate(
    
    term = if_else(
      name == "std_estimate", str_c(term, '_std'), term)
  ) %>% 

# Widen the data ------------------------------------------------------------
## expand to make one column per DV
  pivot_wider(id_cols = c(term), 
              names_from = DV,
              values_from = value) %>% 
  
  
# Remove the redundant IV names -------------------------------------------
  mutate(term = if_else(str_detect(term, pattern = '_std'), '', term)) %>% 
  

# Format the variable names -----------------------------------------------
  mutate(term = str_replace_all(term, '_', ' '),
         term = str_remove_all(term, 'race'),
         term = str_replace_all(term, 'branch', 'branch: '),
         term = str_replace_all(term, 'service era', 'service era: '),
         term = str_to_title(term),
         term = str_replace_all(term, 'Mios Ptsd', 'PTSD'),
         term = str_replace_all(term, 'Mios', 'Moral Injury Symptoms'),
         term = str_replace_all(term, 'Bipf', 'Psychosocial Functioning'),
         term = str_replace_all(term, 'Sexmale', 'Male'),
         term = str_replace_all(term, 'Years Service', 'Years of Service'),
         term = str_remove_all(term, ' Total'),
         centrality = str_replace(as.character(centrality), '0.', '.'),
         connection = str_replace(as.character(connection), '0.', '.'),
         family = str_replace(as.character(family), '0.', '.'),
         interdependent = str_replace(as.character(interdependent), '0.', '.'),
         private_regard = str_replace(as.character(private_regard), '0.', '.'),
         public_regard = str_replace(as.character(public_regard), '0.', '.'),
         skills = str_replace(as.character(skills), '0.', '.')
  ) %>% 
# Remove the standardized intercept row -----------------------------------
  slice(-(2)) %>% 
  #print(n = 100)

# Write to CSV in output folder -------------------------------------------
  write_csv(here::here('output/tables/regression-table-1.csv'))

