# Load Packages ----------------------------------------------------------------
renv::status()
library(kableExtra)
library(tidyverse)

# SET UP FOLDER ----------------------------------------------------------------
source(here::here('src/01_config/folder-structure.R'))

# READ DATA SET  ---------------------------------------------------------------
data <- read_csv(here::here('data/data_main.csv'))

# DESCRIBE SAMPLE --------------------------------------------------------------
source(here::here('src/02_analysis/a-describe-sample/demographics.R'))
source(here::here('src/02_analysis/a-describe-sample/military-demographics.R'))
source(here::here('src/02_analysis/a-describe-sample/population-demographics.R'))

# GRAPHIC MODELLING ------------------------------------------------------------
source(here::here('src/02_analysis/b-graphic-modelling/draw-dags.R'))

# ASSESS INSTRUMENTS -----------------------------------------------------------
source(here::here('src/02_analysis/c-examine-measures/assess-psychometrics.R'))

# EXAMINE VARIABLES-------------------------------------------------------------
source(here::here('src/02_analysis/d-examine-variables/plot-pairs.R'))
source(here::here('src/02_analysis/d-examine-variables/descriptive-categorical.R'))
source(here::here('src/02_analysis/d-examine-variables/descriptive-continuous.R'))

# SPECIFY MODELS ---------------------------------------------------------------
source(here::here('src/02_analysis/e-modelling/fit-models.R'))
source(here::here('src/02_analysis/e-modelling/save-results.R'))
source(here::here('src/02_analysis/e-modelling/model-diagnostics.R'))
source(here::here('src/02_analysis/e-modelling/predictions.R'))
source(here::here('src/02_analysis/e-modelling/make-results-tables.R'))
source(here::here('src/02_analysis/e-modelling/visualize-results.R'))

# SAVE SESSION INFO ------------------------------------------------------------
source(here::here('src/01_config/session-info.R'))

message('Replication complete')