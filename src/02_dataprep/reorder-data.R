
data <-
  data %>% 
  dplyr::select(!c(psychant, psychsyn, ID, d_sq, d_sq_flagged,
                   evenodd, StartDate, EndDate, Status,
                   Progress, `Duration (in seconds)`, validity_years,
                   `Duration (in minutes)`,
                   RecordedDate, UserLanguage, ResponseId,
                   term, at_least_18, served, separated,
                   phone, `Informed Consent`, opp, rid,
                   SC0, RISN, SVID, gc, V, LS, PS, transaction_id, 
                   air_force_warrant_officer, validity_check_1) & 
                  !starts_with('Q_') &
                  !starts_with('attention') &
                  !starts_with('honeypot') &
                  !contains('longstr') & 
                  !contains('avgstr')
  ) %>% 
  dplyr::select(Finished, 
                `Response Type`,
                DistributionChannel, 
                sex,
                race,
                marital,
                religious,
                worship,
                politics,
                employment,
                
                education,
                job_like_military,
                active_duty,
                reserve,
                highest_rank,
                mos, 
                discharge_reason,
                disability,
                disability_percent,
                contains('year'),
                contains('age'),
                starts_with('branch'), 
                starts_with('service_era'),
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
                starts_with('scc'),
                starts_with('wis_priv'),
                starts_with('wis_inter'),
                starts_with('wis_conn'),
                starts_with('wis_family'),
                starts_with('wis_centr'),
                starts_with('wis_publ'),
                starts_with('wis_skill'),
                starts_with('unmet_needs'),
                
                enlisted,
                warrant_officer,
                officer,
                
                starts_with('sex'),
                starts_with('race'),
                
                never_married,
                married,
                divorced,
                widowed,
                
                starts_with('employ'),
                
                everything()
  )
