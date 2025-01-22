---
contributors:
  - Thomas J. Hodges
---

# To Do

- Add the Overleaf output and latex to /Doc
- Add the survey instructions, items, and logic to /Doc
- Ensure ggplot themes are consistent across project
- Update title in this README
- is the themes.R file necessary?
- Update list of tables and programs
- update DAGs file
- fix order of categorical variables 


# Replcation Code: Is Moral Injury an Identity Wound?


## Overview

The code in R Project allows for the replication of tables, figures, stats, graphs, and results used in Military Moral Injury and Identity Change: 
Regard for Military Identity Mediates Moral Injury Events and Symptoms.


## Data Availability and Provenance

This paper uses original data collected by the author as part of a **survey** administered in 2023 to United States military veterans (Hodges, 2023). Original survey data is available upon request. A processed copy of the data is included with this replication. 


## Licensing
- This analysis code is openly licensed via [CC0](https://creativecommons.org/publicdomain/zero/1.0/). It is in the public domain. 
- The replication data is openly licensed via [CC BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/). You may adapt the data by performing additional analysis or creating new variable derived by existing variables. To use the data, you must provide attribution (i.e., proper citation). Also, the data can only be used for non-commercial purposes. Any derivatives of the data must also be openly licensed via CC BY-NC-SA. 


## Computational requirements
Replicating this code will require a recent version of R (version 4.2.2 or later). You can download R from https://cran.rstudio.com

If you already have R installed, running the "`renv/activate.R`" will download the dependent packages. It relies on the `renv` package, which you can read about at https://rstudio.github.io/renv/. 

The code was last run on a **Apple M1 Chip MacBook Air MacOS version Sonoma 14.2.1**. On that computer, the project took 7 and a half minutes to compute. Most of that time is spent fitting models to the various bootstrapped data sets in the file `fit-models.R`.

## Description of programs/code

To replicate the analysis, run the entire `0-replicate.R` script. The script runs the other scripts, which are detailed below. 

There are two groups of programs in this project. The first configures the project (for instance, by ensuring the correct folder structure exists to save the outputs). The second analyzes the data. Data preparation was performed separately as a part of the original data collection (Hodges, 2023).

The data analysis scripts are ordered in five steps: descriptive statistics of the sample, graphic modelling, psychometrics, descriptive statistics of the study variables, and statistical modelling.


| Folder                                | File                              | Purpose                                                 |
|---------------------------------------|-----------------------------------|---------------------------------------------------------|
| src/                                  | replicate.R                       | Runs all of the scripts. Replicates analysis.           |
| src/01_config                         | themes.R                          | Set the style of visualizations.                        |
| src/01_config                         | folder-structure.R                | Configures the output folder.                           |
| src/01_config                         | function-count-percentage.R       | Helper function to make demographic tables.             |
| src/01_config                         | function-percentage-tables.R      | Helper function to make demographic tables.             |
| src/01_config                         | function-plot-lm.R                | Plots regression diagnostics used in plot-diagnostics.R |
| src/02_analysis/a-describe-sample     | demographics.R                    | Creates a table of demographics and latex code.         |
| src/02_analysis/a-describe-sample     | military-demographics.R           | Creates a table of military demographics and latex code.|
| src/02_analysis/a-describe-sample     | plot-demographics.R               | Plot graphs of various demographics in the sample.      |
| src/02_analysis/b-graphic-modelling   | draw-dags.R                       | Plot directed acyclical graphs and adjustment sets.     |
| src/02_analysis/c-examine-measures    | assess-psychometrics.R            | Prints summary table/latex for all scale psychometrics. |
| src/02_analysis/d-examine-variables   | descriptive-categorical.R         | Prints summary table/latex for the categorical variables|
| src/02_analysis/d-examine-variables   | descriptive-continuous.R          | Prints summary table/latex for the continuous variables |
| src/02_analysis/e-modelling           | fit-models.R                      | Specify and fits regression models to data.             |
| src/02_analysis/e-modelling           | save-results.R                    |              |
| src/02_analysis/e-modelling           | model-diagnostics.R               | Creates diagnostic plots for regression models.         |
| src/02_analysis/e-modelling           | predictions.R                     |          |
| src/02_analysis/e-modelling           | make-results-tables.R             | Creates latex tables of regression results.             |
| src/02_analysis/e-modelling           | visualize-results.R               | Plots coefficients and standard errors.                 |


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


## Acknowledgements

This README document was inspired by the template  [avaialable here](https://github.com/social-science-data-editors/template_README/blob/master/template-README.md).
