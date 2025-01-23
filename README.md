---
contributors:
  - Thomas J. Hodges
---

# To Do
- output of diagnostic only saves 1 plot


# Replcation Code: Moral Injury and Identity: Examining Moral Injury as Identity Loss and Identity Change



## Overview

The code in R Project allows for the replication of tables, figures, stats, graphs, and results used in Moral Injury and Identity: Examining Moral Injury as Identity Loss and Identity Change.


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


| Folder                                | File                              | Purpose                                                                   |
|---------------------------------------|-----------------------------------|---------------------------------------------------------------------------|
| src/                                  | replicate.R                       | Runs all of the scripts. Replicates analysis.                             |
| src/01_config                         | themes.R                          | Set the style of visualizations.                                          |
| src/01_config                         | folder-structure.R                | Configures the output folder.                                             |
| src/01_config                         | function-count-percentage.R       | Helper function to make demographic tables.                               |
| src/01_config                         | function-percentage-tables.R      | Helper function to make demographic tables.                               |
| src/01_config                         | function-plot-lm.R                | Plots regression diagnostics used in plot-diagnostics.R                   |
| src/02_analysis/a-describe-sample     | demographics.R                    | Creates a table of demographics and latex code.                           |
| src/02_analysis/a-describe-sample     | military-demographics.R           | Creates a table of military demographics and latex code.                  |
| src/02_analysis/a-describe-sample     | plot-demographics.R               | Plot graphs of various demographics in the sample.                        |
| src/02_analysis/b-graphic-modelling   | draw-dags.R                       | Plot directed acyclical graphs and adjustment sets.                       |
| src/02_analysis/c-examine-measures    | assess-psychometrics.R            | Prints summary table/latex for all scale psychometrics.                   |
| src/02_analysis/d-examine-variables   | descriptive-categorical.R         | Prints summary table/latex for the categorical variables.                 |
| src/02_analysis/d-examine-variables   | descriptive-continuous.R          | Prints summary table/latex for the continuous variables.                  |
| src/02_analysis/e-modelling           | fit-models.R                      | Specify and fits regression models to data.                               |
| src/02_analysis/e-modelling           | save-results.R                    | Unnests the data and saves it to the environment for subsequent analysis. |
| src/02_analysis/e-modelling           | model-diagnostics.R               | Creates diagnostic plots for regression models.                           |
| src/02_analysis/e-modelling           | predictions.R                     | Plots the models' predicted vs observed outcomes.                         |
| src/02_analysis/e-modelling           | make-results-tables.R             | Creates latex tables of regression results.                               |
| src/02_analysis/e-modelling           | visualize-results.R               | Plots coefficients and standard errors.                                   |


The provided code reproduces:

- All numbers provided in text in the paper
- All tables in the paper and supplemental material
- Figure 2 in the paper
- Additional figures not in the paper. These include the directed acyclical graphics (in /output/dags/), plots to assess model diagnostics (in /output/figures/), and plots of the coefficients (in /output/figures/)

CSV files may be open in a spreadsheet or data analysis software. TXT files are latex and can be viewed in [Overleaf](https://www.overleaf.com) or a similar program.

### List of tables and programs

| Figure/Table # | Program                  | Output file                                                |
|----------------|--------------------------|------------------------------------------------------------|
| Table 1        | 02_analysis/a-describe-sample/demographics.R          |  demographics.csv             |
| Table 2        | 02_analysis/a-describe-sample/military-demographics.R | military-demographics.csv     |
| Table 3        | 02_analysis/d-examine-variables/descriptive-categorical.R | military-demographics.csv |
| Table 4        | 02_analysis/d-examine-variables/descriptive-continuous.R | military-demographics.csv  |
| Table 5        | 02_analysis/e-modelling/make-results-tables.R | results-tables.txt                    |
| Table S1       | 02_analysis/c-examine-measures/assess-psychometrics.R | results-tables.txt            |
| Table S2       | 02_analysis/e-modelling/compare-models.R | psychometrics.csv                          |
| Table S3       | 02_analysis/e-modelling/make-results-tables.R | results-tables.txt                    |
| Table S4       | 02_analysis/e-modelling/make-results-tables.R | results-tables.txt                    |
| Table S5       | 02_analysis/e-modelling/make-results-tables.R | results-tables.txt                    |
| Table S6       | 02_analysis/e-modelling/make-results-tables.R | results-tables.txt                    |
| Table S7       | 02_analysis/a-describe-sample/population-demographics.R | population-demographics.csv |
| Figure 2       | 05_analysis/e-modelling/visualize-results.R| plot-bootstrap.jpg                       |



## References

Hodges, Thomas. 2023. “Moral Injury, Identity Dissonance, and Reintegration: A Compendium of Reintegration and Survey of United States Military Veterans.” Kennesaw State University. https://digitalcommons.kennesaw.edu/incmdoc_etd/52.


## Acknowledgements

This README document was inspired by the template  [avaialable here](https://github.com/social-science-data-editors/template_README/blob/master/template-README.md).
