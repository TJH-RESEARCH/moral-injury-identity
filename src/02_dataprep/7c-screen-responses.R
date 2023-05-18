
# -------------------------------------------------------------------------
# Screen Responses



# Save those screened out by additional criteria ----------------------------------------------------
## This should be the opposite of the next script

# Save a copy pre-screened
data_original <- data

# Filter out screeners ----------------------------------------------------
data <-
  data %>% 
  filter(
    air_force_warrant_officer == 0, # No warrant officers in the Air Force
    branch_none == 0, # Branch: Did not serve
    attention_check_biis == 1, # Failed attention checks (i.e., instructed items)
    attention_check_wis == 1,
    validity_check_1 == 1, # Failed Validity checks
    honeypot1 == 0, # Answered honey pots
    honeypot2 == 0,
    honeypot3 == 0,
    longstr_reverse < mean(data$longstr_reverse) + (2 * sd(data$longstr_reverse)),          # Longsting outliers
    longstr_no_reverse < mean(data$longstr_no_reverse) + (2 * sd(data$longstr_no_reverse)), # Longstring outliers
    avgstr_reverse < mean(data$avgstr_reverse) + (2 * sd(data$avgstr_reverse)),             # Longsting outliers
    avgstr_no_reverse < mean(data$avgstr_no_reverse) + (2 * sd(data$avgstr_no_reverse)),    # Longstring outliers
    psychant < mean(data$psychant) + (2 * sd(data$psychant)),
    psychsyn > mean(data$psychsyn) - (2 * sd(data$psychsyn)),
    psychsyn > 0.05,
    psychant < -0.05,
    evenodd < mean(data$evenodd) + (2 * sd(data$evenodd)),
    `Duration (in minutes)` > mean(data$`Duration (in minutes)`) - (2 * sd(data$`Duration (in minutes)`)),
    `Duration (in seconds)` > 300

)

# Save a copy of the screened responses
data_extra_screening <- anti_join(data_original, data, by = c('id' = 'id'))
rm(data_original)


