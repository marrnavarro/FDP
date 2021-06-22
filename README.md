# FDP

Brief description of the code in this repository.

-phenotypes.R: used to extract the phenotypes from the questionnaire answered by the study population. The answers were not in binary mode, but this code transforms them into case/control variables. With the phenotypes, it creates the '.psam' file that serves as input for the GWAS analysis.

-gwas_imputed.sh: file for using PLINK 2.0 to conduct GWAS, first for the chromosomes 1-22 and then for the X chromosome. It is specified the input files, chromosomes, name of the phenotypes, covariables, confidence interval, type of regression, column names, output directory, and number of threads to be used

-plots.R: this file is used for three tasks. The first is to create the input file for PheWeb and zip it. The second one is to create Quantile-Quantile plots, whereas the last task is for Manhattan plots. It performs the three tasks twice, once for the GWAS results and then for the summary statistics from MTAG.

-pheweb.sh: reads phenotypes file and categories file for PheWeb, verifying that each phenotype has a category assigned, and process PheWeb.

-forestplot.R: used to read the summary statistics from GWAS and make a Forest plot with the most significant association of each trait (each file). The resulting figure contains the following information: phenotype, SNP, nearest gene, number of cases, number of controls, odds ratio, 95% confidence interval of the odds ratio and p-value.

-mtag.sh: contains the command line for performing MTAG. The command line consists in the name of the files, the output directory, and the number of samples in each input file.

-heatmap.R: code for the two different Heatmap plots. First, it creates a data frame composed of phenotypes, associated genes and z-scores and plots it. The next command lines help the plot being more comprehensible by changing the labels. The last part of the code is devoted to the creation of a dataset with genes and their chromosome location for plotting it.

-barplot_h2.R: code for the heritability Bar plot. It reads the table with heritability measures, keeps only the columns with significant values and makes the graphic including the error bar.
