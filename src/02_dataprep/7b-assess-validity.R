

# Validate Data ----------------------------------------------------------------

## The `validate` package confronts the data with a set of validation rules.
library(validate)


## Declare Validity Rules ------------------------------------------------------
validity_rules_test <- 
  validate::validator(
    Air_Force_Warrant_Officer        = if(highest_rank == 4) branch_air_force != 1,
    Branch_None                      = branch_none == 0,
    Honeypot_1                       = honeypot1 == 0,
    Honeypot_2                       = honeypot2 == 0,
    Honeypot_3                       = honeypot3 == 0,
    Impossible_Rank_Years            = if(highest_rank == 3) years_service < 7,
    Improbable_Age_Child             = if(years_of_age < 40) military_family_child == 0,
    Improbable_Age_Education         = if(education == 'doctorate') years_of_age > 30,
    Inconsistent_Child               = if(military_family_child == 1) !is.na(bipf_children),
    Inconsistent_Religion_Worship    = if(religious == 0) worship < 4,
    Inconsistent_Retirement          = if(is.na(bipf_work)) employment_retired == 1 | employment_unemployed == 1,
    Inconsistent_Student             = if(is.na(bipf_education)) employment_student == 0, 
    Space_Force_1                    = if(branch_space_force == 1) years_service > 3,
    Space_Force_2                    = if(branch_space_force == 1) years_separation > 3,
    validity_check_1                 = validity_check_1 == 1,
    attention_check_1                = attention_check_biis == 1,
    attention_check_2                = attention_check_wis == 1,
    Psychometric_Synonyms            = psychsyn > 0,
    Psychometric_Antonyms            = psychant < 0,
    Average_String_Length_Reverse    = avgstr_reverse < mean(data$avgstr_reverse) + (2 * sd(data$avgstr_reverse)),
    Average_String_Length_No_Reverse = avgstr_no_reverse < mean(data$avgstr_no_reverse) + (2 * sd(data$avgstr_no_reverse)),
    Even_Odd_Consistency             = evenodd > mean(data$evenodd) - (2 * sd(data$evenodd)),
    Duration                         = `Duration (in minutes)` > mean(data$`Duration (in minutes)`) - (2 * sd(data$`Duration (in minutes)`))
    )
## Confront the data
quality_check <- validate::confront(data, validity_rules_test) 


## Summarize the validity criteria ------------------------------------------
validation_summary <- validate::summary(quality_check)
validation_summary

## Visualize the validity criteria ------------------------------------------
validation_plot <- validate::plot(quality_check, xlab = "")
validation_plot

## Check individual records -------------------------------------------------
validate::aggregate(quality_check, by="record")

## Join validity records with response data  -------------------------------
data <- 
  validate::aggregate(quality_check, by="record") %>% 
  tibble() %>%
  bind_cols(data) %>% 
  rename(validity_npass = npass,
         validity_nfail = nfail,
         validity_nNA = nNA,
         validity_rel_pass = rel.pass,
         validity_rel_fail = rel.fail,
         validity_rel_NA = rel.NA,
         ) %>% 
  select(id, everything())




