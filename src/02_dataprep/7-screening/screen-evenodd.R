
source(here::here('src/01_config/functions/function-calculate-evenodd.R'))



data_start_main <- data_main
data_start_strict <- data_strict
data_start_lenient <- data_lenient


# Screen:Even-Odd Consistency ------------------------------------------------
## Anything above 0 indicates no to negative correlation on even vs odd questions
## Of the same scales

data_main <-
  data_main %>% 
  calculate_evenodd()

data_strict <-
  data_strict %>% 
  calculate_evenodd()

data_lenient <-
  data_lenient %>% 
  calculate_evenodd()


# Visualize -------------------------------------------------------------------------
(plot_main_evenodd <- data_main %>% ggplot(aes(evenodd)) + geom_histogram())
(plot_lenient_evenodd <- data_lenient %>% ggplot(aes(evenodd)) + geom_histogram())
(plot_strict_evenodd <- data_strict %>% ggplot(aes(evenodd)) + geom_histogram())

# Save Plots --------------------------------------------------------------
ggsave(here::here('output/figure/plot_strict_evenodd.jpeg'),plot = plot_strict_evenodd)
ggsave(here::here('output/figure/plot_main_evenodd.jpeg'),plot = plot_main_evenodd)
ggsave(here::here('output/figure/plot_lenient_evenodd.jpeg'),plot = plot_lenient_evenodd)

rm(plot_lenient_evenodd, plot_main_evenodd, plot_strict_evenodd)



# Filter ------------------------------------------------------------------
data_main <- data_main %>% filter(evenodd < 0)
data_lenient <- data_lenient %>% filter(evenodd < 0)
data_strict <- data_strict %>% filter(evenodd < -0.4)



# Label Exclusion Reasons -------------------------------------------------

data_exclusions_main <-
  update_exclusions(data_start = data_start_main,
                    data = data_main,
                    data_exclusions = data_exclusions_main,
                    exclusion_reason_string = 'Even-Odd Inconsistency')

data_exclusions_strict <-
  update_exclusions(data_start = data_start_strict,
                    data = data_strict,
                    data_exclusions = data_exclusions_strict,
                    exclusion_reason_string = 'Even-Odd Inconsistency')

data_exclusions_lenient <-
  update_exclusions(data_start = data_start_lenient,
                    data = data_lenient,
                    data_exclusions = data_exclusions_lenient,
                    exclusion_reason_string = 'Even-Odd Inconsistency')

rm(data_start_main, data_start_strict, data_start_lenient)