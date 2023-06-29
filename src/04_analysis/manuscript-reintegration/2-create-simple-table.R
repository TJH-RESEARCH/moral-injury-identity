

# SIMPLE TABLE
# Make a simple table and/or graph to demonstrate the argument





# Create Table ------------------------------------------------------------
simple_table_reintegration <-
  data %>% 
    group_by(mios_screener) %>% 
    select(mios_screener,
           mios_total,
            civilian_commit_total,
            wis_total,
            mios_total,
            biis_blendedness,
            biis_harmony,
            mcarm_total) %>% 
    summarise(across(everything(), ~ mean(.x)))
   

# Print -------------------------------------------------------------------
simple_table_reintegration %>% print()

# Write table to file -----------------------------------------------------
simple_table_reintegration %>%
  round(2) %>% 
  write_csv(here::here('output/tables/simple-table-reintegration.csv'))





            