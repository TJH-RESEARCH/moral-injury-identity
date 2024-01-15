


data_replication <-
  data %>% 
  select(biis_1,
         biis_2,
         biis_3,
         biis_4,
         biis_5,
         biis_6,
         biis_7,
         biis_8,
         biis_9,
         biis_10,
         biis_harmony,
         branch,
         branch_air_force,
         branch_marines,
         branch_navy,
         discharge_reason,
         discharge_medical,
         discharge_other,
         disability,
         education,
         highest_rank,
         highest_rank_numeric,
         officer,
         starts_with('m2c'),
         starts_with('military_exp'),
         starts_with('military_family'),
         mios_1:mios_14,
         mios_total,
         mios_screener,
         mios_event_type,
         mios_event_type_self,
         mios_event_type_other,
         mios_event_type_multiple,
         mios_criterion_a,
         military_exp_combat,
         ptsd_positive_screen,
         starts_with('race'),
         starts_with('rank'),
         starts_with('service_era_'),
         sexual_orientation,
         sex,
         sex_male,
         trauma_type,
         unmet_needs_any,
         unmet_needs_none,
         years_of_age,
         years_separation,
         years_service
         )

data_replication %>% 
  write_csv(here::here('data/processed/data-replication.csv'))

data_replication %>% 
  readr::write_rds(here::here('data/processed/data-replication.rds'))

rm(data_replication)

data <- 
  readr::read_rds(here::here('data/processed/data-replication.rds'))


message('You are now working with the replicate dataset')
