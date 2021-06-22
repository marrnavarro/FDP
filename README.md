# FDP

Brief description of the code in this repository.

-phenotypes.R: used to extract the phenotypes from the questionnaire answered by the study population. The answers were not in binary mode, but this code transforms them into case/control variables. With the phenotypes, it creates the '.psam' file that serves as input for the GWAS analysis.

-pheweb.sh: 

-plots.R: this file is used for three tasks. The first is to create the input file for PheWeb and zip it. The second one is to create Quantile-Quantile plots, whereas the last task is for Manhattan plots. It performs the three tasks twice, once for the GWAS results and then for the summary statistics from MTAG.

-
