
# SIMPLE TABLE

## Make a simple table illustrating the hypothesized relationship


# Table -------------------------------------------------------------------
## Average WIS subscale score by MI event yes/no screener

table_simple_identity_wound <-
  data %>% 
  group_by(mios_screener) %>% 
  summarise(MIOS = mean(mios_total), 
            Centrality = mean (wis_centrality_total),
            Connection = mean (wis_connection_total),
            Family = mean (wis_family_total),
            Interdependent = mean (wis_interdependent_total),
            Private_regard = mean (wis_private_regard_total),
            Public_regard = mean (wis_public_regard_total),
            Skills = mean (wis_skills_total)
            ) %>% 
  round(2)
  
## Print
table_simple_identity_wound %>% print()

## Save:
table_simple_identity_wound %>% 
  write_csv(here::here('output/tables/identity-wound-simple.csv'))

## Message:
message('Simple table saved to `output/tables/identity-wound-simple.csv`')

## Clean up:
rm(table_simple_identity_wound)




            