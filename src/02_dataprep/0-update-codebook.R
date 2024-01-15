


# Update Codebook -----------------------------------------------------


# Branch ------------------------------------------------------------------
labelled::var_label(data$branch_air_force) <- "Served in the Air Force"
labelled::var_label(data$branch_army) <- "Served in the Army"
labelled::var_label(data$branch_coast_guard) <- "Served in the Coast Guard"                                            
labelled::var_label(data$branch_marines) <- "Served in the Marine"
labelled::var_label(data$branch_navy) <- "Served in the Navy"
labelled::var_label(data$branch_space_force) <- "Served in the Space Force"
labelled::var_label(data$branch_public_health) <- "Served in the US Public Health Service"
labelled::var_label(data$branch_none) <- "Did not serve in any branch"

# Demographics ------------------------------------------------------------
labelled::var_label(data$race_asian) <- "Race: Asian or Asian American"
labelled::var_label(data$race_native) <- "Race: Alaska Native or American Indian"
labelled::var_label(data$race_black) <- "Race: Black or African American"
labelled::var_label(data$race_latino) <- "Race: Hispanic or Latino"
labelled::var_label(data$race_mena) <- "Race: Middle Eastern or North African"
labelled::var_label(data$race_pacific) <- "Race: Hawaiian or Pacific Islander"
labelled::var_label(data$race_white) <- "Race: White"
labelled::var_label(data$race_other) <- "Race: Other"

labelled::var_label(data$sex) <- "What is your sex/gender?"
labelled::var_label(data$religious) <- "Do you consider yourself religious/spiritual?"
labelled::var_label(data$worship) <- "How often do you attend a place of worship? (e.g., church, temple, mosque)"
labelled::var_label(data$politics) <- "What best describes your political affiliation?"
labelled::var_label(data$marital) <- "What is your marital status?"
labelled::var_label(data$education) <- "What is the highest level of school you have completed?"
labelled::var_label(data$job_like_military) <- "How similar is your current job to the military?"

labelled::var_label(data$never_married) <- "Marital Status: Never Married"
labelled::var_label(data$married) <- "Marital Status: Married or living with a Partner"
labelled::var_label(data$divorced) <- "Marital Status: Divorced or Separated"
labelled::var_label(data$widowed) <- "Marital Status: Widowed"
labelled::var_label(data$sex_female) <- "Sex: Female"
labelled::var_label(data$sex_male) <- "Sex: Male"
labelled::var_label(data$sex_nonbinary) <- "Sex: Nonbinary"
labelled::var_label(data$sex_other) <- "Sex: Other"
labelled::var_label(data$sexual_orientation) <- "What is your sexual orientation?"
labelled::var_label(data$sexual_orientation_straight) <- "Sexual Orientation: Straight or Heterosexual"                                            
labelled::var_label(data$sexual_orientation_gay) <- "Sexual Orientation: Gay or Homosexual"
labelled::var_label(data$sexual_orientation_bi) <- "Sexual Orientation: Bisexual"
labelled::var_label(data$sexual_orientation_other) <- "Sexual Orientation: Other"
labelled::var_label(data$validity_years) <- "Years of Age minus 17, years of service, and years of separation"


# b-IPF -------------------------------------------------------------------
#labelled::var_label(data$bipf_daily) <- ""

# DIFI: US Identity -------------------------------------------------------------
#labelled::var_label(data$difi_distance) <- ""
#labelled::var_label(data$difi_us) <- ""
#labelled::var_label(data$difi_overlap) <- ""

# Employment --------------------------------------------------------------
labelled::var_label(data$employment_full_time) <- "Employed Full-Time"                                            
labelled::var_label(data$employment_part_time) <- "Employed Part-Time"                                            
labelled::var_label(data$employment_irregular) <- "Employed irregularly"                                            
labelled::var_label(data$employment_unemployed) <- "Not employed"                                            
labelled::var_label(data$employment_retired) <- "Retired"                                            
labelled::var_label(data$employment_student) <- "Student"

# Military Family ---------------------------------------------------------
labelled::var_label(data$military_family_spouse) <- "Spouse or partner served in military"                  
labelled::var_label(data$military_family_parents) <- "Parent served in military"
labelled::var_label(data$military_family_sibling) <- "Sibling served in military"                                            
labelled::var_label(data$military_family_child) <- "Child served in military"                        
labelled::var_label(data$military_family_other) <- "Other close family member served in the military"
labelled::var_label(data$military_family_none) <- "No other family member has served in the military"

# Military Experiences ----------------------------------------------------
labelled::var_label(data$military_exp_combat) <- "Combat Experience"
labelled::var_label(data$military_exp_noncombat) <- "Non-combat deployment"
labelled::var_label(data$military_exp_support) <- "Combat Support"                      
labelled::var_label(data$military_exp_peacekeeping) <- "Peacekeeping or Humanitarian Deployment"                                    
labelled::var_label(data$military_exp_none) <- "No combat, deployments, or combat support"
labelled::var_label(data$military_exp_total) <- "Number of different types of military experiences reported"

# MIOS Event Type ---------------------------------------------------------
labelled::var_label(data$mios_event_type_self) <- "Moral Injury Event: Self"                                            
labelled::var_label(data$mios_event_type_other) <- "Moral Injury Event: Other Person"                                            
labelled::var_label(data$mios_event_type_betrayal) <- "Moral Injury Event: Betrayal"     

# MIOS PTSD Symptoms ------------------------------------------------------
labelled::var_label(data$mios_ptsd_symptoms_nightmares) <- "In the past month, have you had nightmares about the event or thought about the event when you did not want to?"                  
labelled::var_label(data$mios_ptsd_symptoms_avoid) <- "In the past month, have you tried hard not to think about the event or went out of your way to avoid situations that reminded you of the event(s)?" 
labelled::var_label(data$mios_ptsd_symptoms_vigilant) <- "In the past month, have you been constantly on guard, watchful, or easily startled?"
labelled::var_label(data$mios_ptsd_symptoms_numb) <- "In the past month, have you felt numb or detached from people, activities, or your surroundings?" 
labelled::var_label(data$mios_ptsd_symptoms_guilty) <- "In the past month, have you felt guilty or unable to stop blaming yourself or others for the event(s) or any problems the event(s) may have caused?"
labelled::var_label(data$mios_ptsd_symptoms_none) <- "None of the above symptoms in the past month"  

# Military Demographics ---------------------------------------------------
labelled::var_label(data$highest_rank) <- "What is the highest pay grade you have achieved?"
labelled::var_label(data$discharge_reason) <- "What was your reason for discharge?"
labelled::var_label(data$n_deploy) <- "How many times did you deploy?"
labelled::var_label(data$officer) <- "Military Officer"
labelled::var_label(data$enlisted) <- "Enlisted Personnel"
labelled::var_label(data$warrant_officer) <- "Warrant Officer"


# Service Era -------------------------------------------------------------
labelled::var_label(data$service_era) <- "Service Era"
labelled::var_label(data$service_era) <- "Served Before WWII"
labelled::var_label(data$service_era) <- "Served in WWII"
labelled::var_label(data$service_era) <- "Served in the post-WWII era"
labelled::var_label(data$service_era) <- "Served in the Korean era"
labelled::var_label(data$service_era) <- "Served in the Cold War era"
labelled::var_label(data$service_era) <- "Served in the Vietnam era"
labelled::var_label(data$service_era) <- "Served in the Persian Gulf (pre-9/11) era"
labelled::var_label(data$service_era) <- "Served in the post-9/11 era"
labelled::var_label(data$service_era) <- "Served in multiple service eras"


# Unmet Needs -------------------------------------------------------------
labelled::var_label(data$unmet_needs_job) <- "Not having a job when you left the military"
labelled::var_label(data$unmet_needs_housing) <- "Not having a place to live when you left the military"                                          
labelled::var_label(data$unmet_needs_healthcare) <- "No access to health care when you left the military"                                            
labelled::var_label(data$unmet_needs_education) <- "No access to educational benefits when you left the military"                                            
labelled::var_label(data$unmet_needs_records ) <- "No access to medical or service records when you left the military"                                            
labelled::var_label(data$unmet_needs_physical) <- "Unmet physical health needs when you left the military"                                            
labelled::var_label(data$unmet_needs_mental) <- "Unmet mental health needs when you left the military"                                            
labelled::var_label(data$unmet_needs_legal ) <- "Unresolved legal issues when you left the military"                                            
labelled::var_label(data$unmet_needs_financial) <- "Financial problems when you left the military"                                            
labelled::var_label(data$unmet_needs_none) <- "None of these unmet needs when you left the military"


# Scales ------------------------------------------------------------------

## BIIS-2
labelled::var_label(data$biis_total) <- "(BIIS-2 Total Score (17 items)"
labelled::var_label(data$biis_harmony) <- "BIIS-2 Harmoney Subscale Score (10 items)"
labelled::var_label(data$biis_blendedness) <- "BIIS-2 Blendedness Subscale Score (7 items)"

## b-IPF
labelled::var_label(data$bipf_total) <- " (b-IPF Total Score (7 items)"

## Civilian Commitment
labelled::var_label(data$civilian_commit_total) <- "Civilian Identity Commitment Total Score (4 items)"

## M2CQ
labelled::var_label(data$m2cq_mean) <- "Military to Civilian Questionnaire Mean Score (16 items; some can be scored as NA)"

## M-CARM
labelled::var_label(data$mcarm_purpose_connection) <- "M-CARM Purpose Subscale Score (6 items)"
labelled::var_label(data$mcarm_help_seeking) <- "M-CARM Help Seeking Subscale Score (4 items)"
labelled::var_label(data$mcarm_beliefs_about_civilians) <- "M-CARM Beliefs About Civilians Subscale Score (3 items)"
labelled::var_label(data$mcarm_resentment_regret) <- "M-CARM Resentment and Regret Subscale Score (3 items)"
labelled::var_label(data$mcarm_regimentation) <- "M-CARM Regimentation Subscale Score (5) items"
labelled::var_label(data$mcarm_total) <- "M-CARM Total Score (21 items)"

## MIOS 
labelled::var_label(data$mios_shame) <- "Moral Injury Outcomes Scale Shame Subscale Score (7 items)"
labelled::var_label(data$mios_trust) <- "Moral Injury Outcomes Scale Total Trust Violation Subscale Score (7 items)"
labelled::var_label(data$mios_total) <- "Moral Injury Outcomes Scale Shame Subscale Score (14 items)"

## SCC
labelled::var_label(data$scc_total) <- "Self-Concept Consistency Scale Total Score (12 items)"

## Unmet Discharge Needs
labelled::var_label(data$unmet_needs_total) <- "Number of Unmet Needs when leaving the military (9 items)"

## WIS
labelled::var_label(data$wis_private_regard_total) <- "WIS Private Regard Subscale Score (7 items)"
labelled::var_label(data$wis_interdependent_total) <- "WIS Independent Subscale Score (7 itmes)"
labelled::var_label(data$wis_connection_total) <- "WIS Connection Subscale Score (3 items)"
labelled::var_label(data$wis_family_total) <- "WIS Family Subscale Score (3 items)"
labelled::var_label(data$wis_centrality_total) <- "WIS Centrality Subscale Score (4 items)"
labelled::var_label(data$wis_public_regard_total) <- "WIS Public Regard Subscale Score (4 items)"
labelled::var_label(data$wis_skills_total) <- "WIS Skills Subscale Score (3 items)"  


# Validity and Attention Criteria  ---------------------------------------------------------
labelled::var_label(data$air_force_warrant_officer) <- "Warrant officer in the Air Force" 
labelled::var_label(data$validity_years) <- "Subtract 17 from years of age, then subtract years of service and separation. Negative numbers indicate inaccurate answers." 
labelled::var_label(data$invalid_years) <- "Are validity years less than 0?" 
labelled::var_label(data$psychant) <- "Psychometric Antonym Correlation" 
labelled::var_label(data$psychsyn) <- "Psychometric Synonym Correlation" 
labelled::var_label(data$longstr_no_reverse_scc) <- "Longest String Length: Self-Concept Clarity Scale without reverse scoring"
labelled::var_label(data$avgstr_no_reverse_scc) <- "Average String Length: Self-Concept Clarity Scale without reverse scoring" 
labelled::var_label(data$longstr_reverse_scc) <- "Longest String Length: Self-Concept Clarity Scale with reverse scoring"
labelled::var_label(data$avgstr_reverse_scc) <- "Average String Length: Self-Concept Clarity Scale with reverse scoring " 
labelled::var_label(data$longstr_mios) <- "Longest String Length: Moral Injury Outcomes Scale"
labelled::var_label(data$avgstr_mios) <- "Average String Length: Moral Injury Outcomes Scale" 
labelled::var_label(data$longstr_no_reverse_mcarm) <- "Longest String Length: Military-Civilian Adjustment and Reintegration Measure without reverse scoring" 
labelled::var_label(data$avgstr_no_reverse_mcarm) <- "Average String Length: Military-Civilian Adjustment and Reintegration Measure without reverse scoring" 
labelled::var_label(data$longstr_reverse_mcarm) <- "Longest String Length: Military-Civilian Adjustment and Reintegration Measure with reverse scoring" 
labelled::var_label(data$avgstr_reverse_mcarm) <- "Average String Length: Military-Civilian Adjustment and Reintegration Measure with reverse scoring" 
labelled::var_label(data$longstr_m2cq) <- "Longest String Length: Military to Civilian Questionnaire with revese scoring" 
labelled::var_label(data$avgstr_m2cq) <- "Average String Length: Military to Civilian Questionnaire with revese scoring" 
labelled::var_label(data$longstr_no_reverse_biis) <- "Longest String Length: Bicultural Identity Integration Scale-2 without reverse scoring" 
labelled::var_label(data$avgstr_no_reverse_biis) <- "Average String Length: Bicultural Identity Integration Scale-2 without reverse scoring" 
labelled::var_label(data$longstr_reverse_biis) <- "Longest String Length: Bicultural Identity Integration Scale-2 with reverse scoring" 
labelled::var_label(data$avgstr_reverse_biis) <- "Average String Length: Bicultural Identity Integration Scale-2 with reverse scoring" 
labelled::var_label(data$longstr_no_reverse) <- "Longest String Length: Entire Survey without reverse scoring" 
labelled::var_label(data$avgstr_no_reverse) <- "Average String Length: Entire Survey with reverse scoring" 
labelled::var_label(data$longstr_reverse) <- "Longest String Length: Entire Survey with reverse scoring" 
labelled::var_label(data$avgstr_reverse) <- "Average String Length: Entire Survey with reverse scoring" 
#labelled::var_label(data$d_sq) <- "Mahalanobis distance squared (D-sqaured)" 
#labelled::var_label(data$d_sq_flagged) <- "D: Multivariate Outlier" 

# Honeypot ----------------------------------------------------------------
labelled::var_label(data$honeypot1) <- "Item not display to valid users. To catch bots."  
labelled::var_label(data$honeypot2) <- "Item not display to valid users. To catch bots."
labelled::var_label(data$honeypot3) <- "Item not display to valid users. To catch bots."


# -------------------------------------------------------------------------

### Codebook
print(tibble::enframe(sjlabelled::get_label(data)), n = 500)



# Write Codebook ----------------------------------------------------------

tibble::enframe(sjlabelled::get_label(data)) %>% print(n = 500)

labels_new <- tibble::enframe(sjlabelled::get_label(data)) %>% 
  rename(variable = name, label = value)

labels <- left_join(labels, labels_new, by = c('variable' = 'variable', 'label' = 'label'))


print(labels, n = 500)
print(labels_new, n = 500)

