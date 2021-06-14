plink2=/imppc/labs/dnalab/nblaym/gwas/plink2
output=/imppc/labs/dnalab/share/mar_navarro/gwas/output 
pgen=/imppc/labs/dnalab/share/COVID_GTEx_GCAT/data/GCAT_imputed_QC.pgen
pvar=/imppc/labs/dnalab/share/COVID_GTEx_GCAT/data/GCAT_imputed_QC.pvar
psam=/imppc/labs/dnalab/share/mar_navarro/genotips/GCATcore_hair.psam

cd $output

#cromosomes 1-22
$plink2 --pgen $pgen --pvar $pvar --psam $psam --chr 1-22 --pheno-name fototipo_score,fototipo_cat,hair_color_black,hair_color_blond,hair_color_brown,hair_color_red,brown_eyes,black_eyes,brown_light_eyes,blue_green_eyes,blue_green_light_eyes,sunburn,freckles,brown_skin,medium_skin,white_skin,very_white_skin  --covar-name GENDER, PC1, PC2, PC3, PC4, AGE --ci 0.95 --glm firth cols=chrom,pos,ref,alt,a1count,a1countcc,ax,nobs,a1freq,a1freqcc,test,orbeta,se,ci,tz,p hide-covar --out $output/gwas --threads 6

#cromosoma X
$plink2 --pgen $pgen --pvar $pvar --psam $psam --chr 23 --pheno-name fototipo_score,fototipo_cat,hair_color_black,hair_color_blond,hair_color_brown,hair_color_red,brown_eyes,black_eyes,brown_light_eyes,blue_green_eyes,blue_green_light_eyes,sunburn,freckles,brown_skin,medium_skin,white_skin,very_white_skin   --covar-name PC1, PC2, PC3, PC4, AGE --xchr-model 1  --ci 0.95 --glm firth  
cols=chrom,pos,ref,alt,a1count,a1countcc,nobs,a1freq,a1freqcc,test,orbeta,se,ci,tz,p hide-covar --out $output/gwas_x --threads 4
