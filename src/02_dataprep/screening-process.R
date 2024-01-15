
# Screening

## Load Functions ----------------------------------------------------------
source(here::here('src/01_config/functions/function-select-scales.R'))
source(here::here('src/01_config/functions/function-reorder-data.R'))
source(here::here('src/01_config/functions/function-undo-reverse-codes.R'))
source(here::here('src/01_config/functions/function-calculate-longstring.R'))
source(here::here('src/01_config/functions/function-calculate-longstring-again.R'))


# Save copies of the original data and the data scrubbed by Qualtrics 
data_original <- data %>% mutate(air_force_warrant_officer = NA, warrant_officer_years = NA)

data_scrubbed_qualtrics <- 
  data %>% 
  filter(Progress == 100, term == 'Scrubbed' | term == 'Scrubbed Out' | term == 'scrubbed')

# Screens
source(here::here('src/03_dataprep/screen-bots-dups.R'))
source(here::here('src/03_dataprep/screen-attention-checks.R'))
source(here::here('src/03_dataprep/screen-validity-checks.R'))
source(here::here('src/03_dataprep/screen-longstring.R'))
source(here::here('src/03_dataprep/screen-evenodd.R'))
source(here::here('src/03_dataprep/screen-synant.R.R'))
source(here::here('src/03_dataprep/screen-avgstring.R.R'))
