
# Analyze Survey

# Check Representation
source(here::here('src/04_analysis/manuscript-1/check-representation.R'))

# Draw DAGs
## Determine what variable to include in the model
source(here::here('src/04_analysis/manuscript-1/draw-dags.R'))

# Check Assumptions
source(here::here('src/04_analysis/manuscript-1/check-assumptions.R'))

# Transform Variables
source(here::here('src/04_analysis/manuscript-1/transform-variables.R'))

# Remove Outliers
source(here::here('src/04_analysis/manuscript-1/remove-outliers.R'))

# Run Regressions
source(here::here('src/04_analysis/manuscript-1/run-regressions.R'))

# Permutation Testing
source(here::here('src/04_analysis/manuscript-1/check-permutation.R'))

# Replicate with Bayesian regression
source(here::here('src/04_analysis/manuscript-1/replicate-bayes.R'))

# Create Correlation Tables
source(here::here('src/04_analysis/manuscript-1/create-regression-tables'))

# Create Regression Tables
source(here::here('src/04_analysis/manuscript-1/create-correlation-tables.R'))

