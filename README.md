---
contributors:
  - Thomas J. Hodges
---

# To Do

- Add the Overleaf output and latex to /Doc
- Add the survey instructions, items, and logic to /Doc
- Ensure themes are consistent across project
- plot-demographics.R  


# Replcation Code: Is Moral Injury an Identity Wound?


## Overview

The code in R Project allows for the replication of tables, figures, stats, graphs, and results used in Is Moral Injury an Identity Wound? Moral Injury, Military Identity, and Implications for Separated Service Members.


## Data Availability and Provenance

This paper uses original data collected by the author as part of a **survey** administered in 2023 to United States military veterans (Hodges, 2023). Original survey data is available upon reasonable request. A processed copy of the data is included with this repliation. 


## Licensing
- This analysis code is openly licensed via [CC0](https://creativecommons.org/publicdomain/zero/1.0/). It is in the public domain. 
- The replication data is openly licensed via [CC BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/). You may adapt the data by performing additional analysis or creating new variable derived by existing variables. To use the data, you must provide attribution (i.e., proper citation). Also, the data can only be used for non-commercial purposes. Any derivatives of the data must also be openly licensed via CC BY-NC-SA. 


## Computational requirements
Replicating this code will require a recent version of R (version 4.2.2 or later). You can download R from https://cran.rstudio.com

If you already have R installed, running the "`renv/activate.R`" will download the dependent packages. It relies on the `renv` package, which you can read about at https://rstudio.github.io/renv/. This script is run as a part of the "replicate.R" file which runs the entire project. 

The code was last run on a **Apple M1 Chip MacBook Air MacOS version Sonoma 14.2.1**. 


## Description of programs/code

To replicate the analysis, run the entire `0-replicate.R` script. The script runs the other scripts, which are detailed below. 

There are three groups of programs in this project. The first configures the project (for instance, by setting a standard theme for visualizations). The second analyzes the data. Data preparation was performed separately.

The data analysis scripts are ordered in seven stages: desciptives, graphic modelling, psychometrics, examining variables, modelling, interpreting results, and robustness analysis.  


| Folder                                | File                              | Purpose                                                 |
|---------------------------------------|-----------------------------------|---------------------------------------------------------|
| src/                                  | replicate.R                       | Runs all of the scripts. Replicates analysis.           |
| src/01_config                         | themes.R                          | Set the style of visualizations.                        |
| src/01_config                         | folder-structure.R                | Configures the output folder.                           |
| src/01_config                         | folder-append-results.R           | Helper function to add regression results to a log.     |
| src/01_config/functions               | function-count-percentage.R       | Helper function to make demographic tables.             |
| src/01_config/functions               | function-percentage-tables.R      | Helper function to make demographic tables.             |
| src/01_config/functions               | function-plot-lm.R                | Plots regression diagnostics used in plot-diagnostics.R |
| src/02_analysis/a-describe-sample     | sample-size.R                     | Calculates sample size for each version of data set.    |
| src/02_analysis/a-describe-sample     | demographics.R                    | Creates a basic demographics table and latex code.      |
| src/02_analysis/a-describe-sample     | military-demographics.R           | Creates a military demographics table and latex code.   |
| src/02_analysis/a-describe-sample     | plot-demographics.R               | Plot graphs of various demographics in the sample.      |
| src/02_analysis/b-graphic-modelling   | draw-dags.R                       | Plot directed acyclical graphs and adjustment sets.     |
| src/02_analysis/c-examine-measures    | alpha-mios.R                      | Calculates and saves Cronbach's alpha for the MIOS.     |
| src/02_analysis/c-examine-measures    | alpha-scc.R                       | Calculates and saves Cronbach's alpha for the SCC.      |
| src/02_analysis/c-examine-measures    | cfa-biis-conflict.R               | Examines psychometrics of BIIS-2 Conflict scale.        |
| src/02_analysis/c-examine-measures    | cfa-mios.R                        | Examines psychometrics of MIOS.                         |
| src/02_analysis/c-examine-measures    | cfa-wis-centrality.R              | Examines psychometrics of WIS Centrality subscale.      |
| src/02_analysis/c-examine-measures    | cfa-wis-connection.R              | Examines psychometrics of WIS Connection subscale.      |
| src/02_analysis/c-examine-measures    | cfa-wis-family.R                  | Examines psychometrics of WIS Family subscale.          |
| src/02_analysis/c-examine-measures    | cfa-wis-interdependent.R          | Examines psychometrics of WIS Interdependence subscale. |
| src/02_analysis/c-examine-measures    | assess-psychometrics.R            | Prints summary table/latex for all scale psychometrics. |
| src/02_analysis/d-examine-variables   | descriptive-categorical.R         | Prints summary table/latex for the categorical variables * |
| src/02_analysis/d-examine-variables   | descriptive-continuous.R          | Prints summary table/latex for the continuous variables |
| src/02_analysis/d-examine-variables   | plot-mios.R                       | Creates histogram and boxplot of moral injury.          |
| src/02_analysis/d-examine-variables   | plot-connection.R                 | Creates histogram and boxplot of military connection.   |
| src/02_analysis/d-examine-variables   | plot-identity-dissonance.R        | Creates histogram and boxplot of identity dissonance.   |
| src/02_analysis/d-examine-variables   | plot-hypotheses.R                 | Creates bivariate plots of primary variables.           |
| src/02_analysis/d-examine-variables   | plot-pairs.R                      | Creates paired plots of continuous variables.           |
| src/02_analysis/d-examine-variables   | t-test-mi-event.R                 | Runs t-test on moral injury symptoms by event endorse.  |
| src/02_analysis/e-modelling           | fit-models.R                      | Specify and fits regression models to data.             |
| src/02_analysis/e-modelling           | model-diagnostics.R               | Creates diagnostic plots for regression models.         |
| src/02_analysis/e-modelling           | calculate-robust-se.R             | Calculates Huber-White standard errors & runs coeftest. |
| src/02_analysis/f-interpret-results   | make-results-tables.R             | Creates latex tables of regression results.             |
| src/02_analysis/f-interpret-results   | visualize-results.R               | Plots coefficients and standard errors.                 |
| src/02_analysis/g-robustness          | fit-models-centrality.R           | Re-runs the regressions with WIS Centrality as outcome. |
| src/02_analysis/g-robustness          | fit-models-family.R               | Re-runs the regressions with WIS Family as outcome.     |
| src/02_analysis/g-robustness          | fit-models-scc.R                  | Re-runs the regressions with Self Concept Clarity.      |
| src/02_analysis/g-robustness          | fit-models-interdependent.R       | Re-runs the regressions with WIS Interdependence.       |
| src/02_analysis/g-robustness          | plot-robustness.R                 | Creates visualizations of robustness results.           |



The provided code reproduces:

- All numbers provided in text in the paper
- All tables and figures in the paper

## List of tables and programs

| Figure/Table #    | Program                  | Line Number | Output file                      |
|-------------------|--------------------------|-------------|----------------------------------|
| Table a           | 02_analysis/table1.do    |             | summarystats.csv                 |
| Table b           | 05_analysis/table2and3.do| 15          | table2.csv                       |


## References

Hodges, Thomas. 2023. “Moral Injury, Identity Dissonance, and Reintegration: A Compendium of Reintegration and Survey of United States Military Veterans.” Kennesaw State University. https://digitalcommons.kennesaw.edu/incmdoc_etd/52.



---

## Acknowledgements


This README document was inspired by the template  [avaialable here](https://github.com/social-science-data-editors/template_README/blob/master/template-README.md).


