
# Make some simple tables and graphs


# Average MI symptom score by MI event yes/no screener

## 
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
            ) %>% round(2) %>% write_csv(here::here('output/tables/means-table.csv'))





            