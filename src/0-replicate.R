

# Load Packages -----------------------------------------------------------
source(here::here('renv/activate.R'))
library(tidyverse)

# SET UP FOLDER --------------------------------------------------------
source(here::here('src/01_config/folder-structure.R'))
source(here::here('src/01_config/functions/function-append-results.R'))


# DATA SET MANAGEMENT -----------------------------------------------------------
data <- read_csv(here::here('data/data_main.csv'))


# DESCRIBE SAMPLE ----------------------------------------------------------
source(here::here('src/02_analysis/a-describe-sample/sample-size.R'))
source(here::here('src/02_analysis/a-describe-sample/demographics.R'))
source(here::here('src/02_analysis/a-describe-sample/military-demographics.R'))


# GRAPHIC MODELLING --------------------------------------------------------
source(here::here('src/02_analysis/b-graphic-modelling/draw-dags.R'))


# ASSESS INSTRUMENTS ----------------------------------------------------
## Moral Injury
source(here::here('src/02_analysis/c-examine-measures/cfa-mios.R'))
source(here::here('src/02_analysis/c-examine-measures/alpha-mios.R'))

## Identity Dissonance
source(here::here('src/02_analysis/c-examine-measures/cfa-biis-conflict.R'))

## Military Identity 
source(here::here('src/02_analysis/c-examine-measures/cfa-wis-interdependent.R'))
source(here::here('src/02_analysis/c-examine-measures/cfa-wis-public-regard.R')) 


## Save a Table of the Psychometric
source(here::here('src/02_analysis/c-examine-measures/assess-psychometrics.R'))

# Clean the environment
rm(fit_biis_conflict, 
   alpha_mios,
   fit_wis_interdependent, 
   fit_wis_public_regard
)



# EXAMINE VARIABLES----------------------------------------------------
## Moral Injury 
source(here::here('src/02_analysis/d-examine-variables/plot-mios.R'))


## Identity Dissonance
source(here::here('src/02_analysis/d-examine-variables/plot-identity-dissonance.R'))

## Military Identity
source(here::here('src/02_analysis/d-examine-variables/plot-interdependent.R'))
source(here::here('src/02_analysis/d-examine-variables/plot-public-regard.R'))

## Bivariate Analysis
source(here::here('src/02_analysis/d-examine-variables/plot-pairs.R'))
source(here::here('src/02_analysis/d-examine-variables/plot-hypotheses.R'))

## Descriptive Statistics
source(here::here('src/02_analysis/d-examine-variables/descriptive-categorical.R'))
source(here::here('src/02_analysis/d-examine-variables/descriptive-continuous.R'))


# SPECIFY MODELS ----------------------------------------------------
source(here::here('src/02_analysis/e-modelling/fit-models.R'))
source(here::here('src/02_analysis/e-modelling/model-diagnostics.R'))
source(here::here('src/02_analysis/e-modelling/calculate-robust-se.R'))


# INTERPRET MODELS --------------------------------------------------------
source(here::here('src/02_analysis/f-interpret-results/make-results-tables-biis.R'))
source(here::here('src/02_analysis/f-interpret-results/make-results-tables-wis.R'))
source(here::here('src/02_analysis/f-interpret-results/visualize-results.R'))



# POST HOC ANALYSIS -------------------------------------------------------
source(here::here('src/02_analysis/g-posthoc/split-sample.R'))



source(here::here('src/01_config/session-info.R'))

message('
        
        
        
        Replication complete
        
        
        ')

