
data <-
  data %>% 
  dplyr::select(sex,
                race,
                marital,
                religious,
                worship,
                politics,
                employment,

                starts_with('sex'),
                starts_with('race'),
                
                never_married,
                married,
                divorced,
                widowed,
                
                starts_with('employ'),
                
                education,
                job_like_military,
                active_duty,
                reserve,
                mos, 
                contains('discharge'),
                contains('year'),
                contains('age'),
                starts_with('branch'), 
                
                highest_rank,
                enlisted,
                warrant_officer,
                officer,
                nonenlisted,
                contains('rank'), 
                
                disability,
                starts_with('service_era'),
                disability_percent,
                n_deploy,
                starts_with('military_exp'), 
                starts_with('military_family'),
                starts_with('bipf'),
                starts_with('biis'),
                starts_with('civilian'),
                starts_with('difi'),
                starts_with('m2cq'),
                starts_with('mcarm'),
                trauma_type,
                starts_with('mios'),
                starts_with('pc_'),
                starts_with('scc'),
                starts_with('wis_priv'),
                starts_with('wis_inter'),
                starts_with('wis_conn'),
                starts_with('wis_family'),
                starts_with('wis_centr'),
                starts_with('wis_publ'),
                starts_with('wis_skill'),
                wis_total,
                starts_with('unmet_needs'),

                everything()
                
  )


data %>% names() %>% print()

message('Variables reordered.')