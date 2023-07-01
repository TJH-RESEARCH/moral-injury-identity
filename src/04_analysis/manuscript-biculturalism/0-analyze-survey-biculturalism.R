
# ANALYZE SURVEY
# Military-Civilian Biculturalism?: 
# Bicultural Identity and the Adjustment of Separated Service Members


## 0. Process Survey ---------------------------------------------------------
source(here::here('src/02_dataprep/0-process-survey.R'))

## 1. Create Correlation Table ----------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/1-create-correlation-table.R'))

## 2. Cluster Military Identity -----------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/2-cluster-wis.R'))

## 3. Cluster Civilian Identity -----------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/3-cluster-civilian.R'))

## 4. Combine Identity Clusters -----------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/4-combine-clusters.R'))

## 5. Check ANVOA Assumptions -----------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/5-check-assumptions.R'))

## 6. Run ANOVA ---------------------------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/6-run-anova.R'))

## 7. Check ANOVA Diagnostics ------------------------------------------------------
source(here::here('src/04_analysis/manuscript-bicultural`1ism/7-anova-diagnostics.R'))

## 8. Paired t-Tests --------------------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/8-paired-t-tests.R'))

## 9. Permutation Testing ----------------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/9-permutation.R'))

## 10. Create ANOVA Tables -------------------------------------------
source(here::here('src/04_analysis/manuscript-biculturalism/10-create-anova-tables.R'))