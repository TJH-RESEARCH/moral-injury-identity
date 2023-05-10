

# Create visualizations ---------------------------------------------------

## Load packages 
library(patchwork)

## Create a new list

## Psychometric Synonyms/Antonyms
psych_scatter <-
  data %>% 
  ggplot2::ggplot(aes(x = psychant, 
                      y = psychsyn)) +
  geom_text(aes(label = id)) +
  labs(title = 'Psychological Synonym and Antonym Correlations') +
  lims(x = c(-1, 0), y = c(0, 1))

psychsyn_box <-
  data %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_boxplot() +
  labs(title = 'Psychological Synonym Correlation')

psychsyn_hist <-
  data %>%
  ggplot2::ggplot(aes(x = psychsyn)) +
  geom_histogram()

psychant_box <-
  data %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_boxplot() +
  labs(title = 'Psychological Antonym Correlation')

psychant_hist <-
  data %>%
  ggplot2::ggplot(aes(x = psychant)) +
  geom_histogram()

## Duration

duration_box <-
  data %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_boxplot() +
  labs(title = 'Duration')

duration_hist <-
  data %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_histogram()


## Even-Odd Consistency

evenodd_box <-
  data %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_boxplot() +
  labs(title = 'Even-Odd Consistency')

evenodd_hist <-
  data %>%
  ggplot2::ggplot(aes(x = evenodd)) +
  geom_histogram() +
  labs(title = '')

## Difference between M2C-Q and M-CARM scores  

diff_hist <-
  data %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_histogram() +
  labs(title = '')

diff_box <-
  data %>%
  ggplot2::ggplot(aes(x = mcarm_m2cq_difference)) +
  geom_boxplot() +
  labs(title = 'Difference between M2C-Q and M-CARM (0-4 range)')


# Visualize ---------------------------------------------------------------

psychsyn_box / psychsyn_hist
psychant_box / psychant_hist
psych_scatter
duration_box / duration_hist
evenodd_box / evenodd_hist
diff_box / diff_hist


# Validate ----------------------------------------------------------------

## The `validate` package confronts the data with a set of validation rules.
library(validate)

## Declare validation rules
validity_rules <- 
  validate::validator(
    air_force_warrant_officer = air_force_warrant_officer == 0,
    space_force = branch_space_force == 0,
    branch_none = branch_none == 0,
    inconsistent_children = inconsistent_children == 0,
    inconsistent_children_age = inconsistent_children_age == 0,
    inconsistent_education_years = inconsistent_education_years == 0,
    inconsistent_education = inconsistent_education == 0, 
    inconsistent_rank = inconsistent_rank == 0,
    inconsistent_religion = inconsistent_religion == 0, 
    validity_years = validity_years >= 0,
    validity_check_1 = validity_check_1 == 1,
    attention_check_1 = attention_check_biis == 1,
    attention_check_2 = attention_check_wis == 1,
    outlier_longstring_reverse = outlier_longstring_reverse == 0,
    outlier_longstring_no_reverse = outlier_longstring_no_reverse == 0,
    outlier_psychsyn = outlier_psychsyn == 0,
    outlier_psychant = outlier_psychant == 0,
    outlier_evenodd = outlier_evenodd == 0,
    outlier_duration = outlier_evenodd == 0,
    outlier_irvTotal = outlier_irvTotal == 0,
    outlier_irv1 = outlier_irv1 == 0,
    outlier_irv2 = outlier_irv2 == 0,
    outlier_irv3 = outlier_irv3 == 0,
    outlier_irv4 = outlier_irv4 == 0,
    outlier_irv5 = outlier_irv5 == 0,
    outlier_irv6 = outlier_irv6 == 0,
    outlier_mcarm_m2cq_diff = outlier_mcarm_m2cq_difference == 0,
    honeypot1 = honeypot1 == 0,
    honeypot2 = honeypot2 == 0,
    honeypot3 = honeypot3 == 0
    
  )


## Confront the data
quality_check <- validate::confront(data, validity_rules)

## Visualize the validity criteria 
validation_summary <- validate::summary(quality_check)
validation_plot <- validate::plot(quality_check, xlab = "")

validation_summary
validation_plot

## Check individual records
validate::aggregate(quality_check, by="record")

## Join validity records with response data
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



# Outlier Analysis --------------------------------------------------------

## Psych Synonyms
data$psychsyn
mean(data$psychsyn)
sd(data$psychsyn)
mean(data$psychsyn) + (1.5 * sd(data$psychsyn))
mean(data$psychsyn) - (1.5 * sd(data$psychsyn))
data$psychsyn > mean(data$psychsyn) + (2 * sd(data$psychsyn))
data$psychsyn < mean(data$psychsyn) - (2 * sd(data$psychsyn))

## Psych Antonyms
data$psychant
mean(data$psychant)
sd(data$psychant)
mean(data$psychant) + (1.5 * sd(data$psychant))
mean(data$psychant) - (1.5 * sd(data$psychant))
data$psychant > mean(data$psychant) + (2 * sd(data$psychant))
data$psychant < mean(data$psychant) - (2 * sd(data$psychant))

## Even Odd
data$evenodd
mean(data$evenodd)
sd(data$evenodd)
mean(data$evenodd) + (1.5 * sd(data$evenodd))
mean(data$evenodd) - (1.5 * sd(data$evenodd))
data$evenodd > mean(data$evenodd) + (2 * sd(data$evenodd))
data$evenodd < mean(data$evenodd) - (2 * sd(data$evenodd))

## IRV
data$irv
mean(data$irv)
sd(data$irv)
mean(data$irv) + (1.5 * sd(data$irv))
mean(data$irv) - (1.5 * sd(data$irv))
data$irv > mean(data$irv) + (2 * sd(data$irv))
data$irv < mean(data$irv) - (2 * sd(data$irv))

## Duration
data$`Duration (in minutes)`
mean(data$`Duration (in minutes)`)
sd(data$`Duration (in minutes)`)
mean(data$`Duration (in minutes)`) + (1.5 * sd(data$`Duration (in minutes)`))
mean(data$`Duration (in minutes)`) - (1.5 * sd(data$`Duration (in minutes)`))
data$`Duration (in minutes)` > mean(data$`Duration (in minutes)`) + (2 * sd(data$`Duration (in minutes)`))
data$`Duration (in minutes)` < mean(data$`Duration (in minutes)`) - (2 * sd(data$`Duration (in minutes)`))

## Difference in M2C-Q and M-CARM
data$mcarm_m2cq_difference
mean(data$mcarm_m2cq_difference)
sd(data$mcarm_m2cq_difference)
mean(data$mcarm_m2cq_difference) + (2 * sd(data$mcarm_m2cq_difference))
mean(data$mcarm_m2cq_difference) - (2 * sd(data$mcarm_m2cq_difference))
data$mcarm_m2cq_difference > mean(data$mcarm_m2cq_difference) + (2 * sd(data$mcarm_m2cq_difference))

