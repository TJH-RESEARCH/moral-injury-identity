

# Create visualizations ---------------------------------------------------

## Load packages 
library(patchwork)


# Visualize ---------------------------------------------------------------

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
  lims(x = c(0, 100))
  labs(title = 'Duration')

duration_hist <-
  data %>%
  ggplot2::ggplot(aes(x = `Duration (in minutes)`)) +
  geom_histogram() +
  lims(x = c(0, 100))


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

psychsyn_box / psychsyn_hist
psychant_box / psychant_hist
psych_scatter
duration_box / duration_hist
evenodd_box / evenodd_hist
diff_box / diff_hist


# Validate ----------------------------------------------------------------


## Confront the data
quality_check <- validate::confront(data, validity_rules)

## Visualize the validity criteria 
validation_summary <- validate::summary(quality_check)
validation_plot <- validate::plot(quality_check, xlab = "")

validation_summary
validation_plot

## Check individual records
validate::aggregate(quality_check, by="record")




