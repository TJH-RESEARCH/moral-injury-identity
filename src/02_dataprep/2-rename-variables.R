

# -------------------------------------------------------------------------#
# Rename variables  -------------------------------------------------------

data <-
  data %>% 
  rename(

# The name of this subscale is misspelled ----------------------------------
        wis_interdependent_10 = wis_interdependent10,
        wis_interdependent_11 = wis_interdependent11,
        wis_interdependent_12 = wis_interdependent12,
        wis_interdependent_13 = wis_interdependent13,
        wis_interdependent_14 = wis_interdependent14,
       
# Rename some variables to be more specific ------------------------------
        difi_distance = difi_us_slide_1,
        difi_overlap = difi_us_slide_2,

# This honeypot quesiton is multiple response, so the name has changed:
        honeypot2 = honeypot2_1,
       
# Fix dummy variables  ----------------------------------------------------
       
        ## Branch
        branch_air_force = branch_1,
        branch_army = branch_2,
        branch_coast_guard = branch_3,
        branch_marines = branch_4,
        branch_navy = branch_5,
        branch_space_force = branch_6,
        branch_public_health = branch_7,
        branch_none = branch_8,
        
        ## Employment       
        employment_full_time = employment_1,
        employment_part_time = employment_2,
        employment_irregular = employment_3,
        employment_unemployed = employment_4,
        employment_retired = employment_5,
        employment_student = employment_6,
        
        ## Military Experiences
        military_exp_combat = military_experiences_1,
        military_exp_noncombat = military_experiences_2,
        military_exp_support = military_experiences_3,
        military_exp_peacekeeping = military_experiences_4,
        
        ## Military Family
        military_family_spouse = military_family_1,
        military_family_parents = military_family_2,
        military_family_sibling = military_family_3,
        military_family_child = military_family_4,
        military_family_other = military_family_5,
        military_family_none = military_family_0,
        
        ## MIOS
        mios_event_type_self = mios_event_type_1,
        mios_event_type_other = mios_event_type_2,
        mios_event_type_betrayal = mios_event_type_3,
        mios_ptsd_symptoms_nightmares= mios_ptsd_symptoms_1,
        mios_ptsd_symptoms_avoid = mios_ptsd_symptoms_2,
        mios_ptsd_symptoms_vigilant = mios_ptsd_symptoms_3,
        mios_ptsd_symptoms_numb = mios_ptsd_symptoms_4,
        mios_ptsd_symptoms_guilty = mios_ptsd_symptoms_5,
        mios_ptsd_symptoms_none = mios_ptsd_symptoms_0,
        
        ## Race
        race_asian = race_1,
        race_native = race_2,
        race_black = race_3,
        race_latino = race_4,
        race_mena = race_5,
        race_pacific = race_6,
        race_white = race_7,
        race_other = race_8,
        
        ## Unmet Needs
        unmet_needs_job = unmet_needs_1,
        unmet_needs_housing = unmet_needs_2,
        unmet_needs_healthcare = unmet_needs_3,
        unmet_needs_education = unmet_needs_4,
        unmet_needs_records = unmet_needs_5,
        unmet_needs_physical = unmet_needs_6,
        unmet_needs_mental = unmet_needs_7,
        unmet_needs_legal = unmet_needs_8,
        unmet_needs_financial = unmet_needs_9,
        unmet_needs_none = unmet_needs_0

)

# -------------------------------------------------------------------------#