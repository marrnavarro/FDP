##### FOR GWAS RESULTS #####
library(qqman)
library(data.table)
library(dplyr)

all_chr <- c('/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.freckles.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.sunburn.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.black_skin.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.brown_skin.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.medium_skin.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.white_skin.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.very_white_skin.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.black_eyes.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.brown_eyes.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.brown_light_eyes.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.blue_green_eyes.glm.firth',
             '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.blue_green_light_eyes.glm.firth')
x_chr <- c('/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.freckles.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.sunburn.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.black_skin.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.brown_skin.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.medium_skin.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.white_skin.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.very_white_skin.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.black_eyes.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.brown_eyes.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.brown_light_eyes.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.blue_green_eyes.glm.firth',
           '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_x.blue_green_light_eyes.glm.firth')
names <- c('freckles','sunburn','black_skin','brown_skin','medium_skin','white_skin','very_white_skin',
'black_eyes','brown_eyes','brown_light_eyes','blue_green_eyes','blue_green_light_eyes')

for (i in 1:length(all_chr)){
  #Pheweb
  phenotype = rbind(fread(all_chr[i]) %>% arrange(`#CHROM`,POS), 
                    fread(x_chr[i]) %>% mutate(`#CHROM`=23) %>% arrange(POS)) %>% 
    filter(!is.na(P)) %>% select(`#CHROM`,POS,	ID,	REF	, ALT, P)
  write.table(phenotype, paste('/imppc/labs/dnalab/share/mar_navarro/pheweb_data/tests/input_files/csv/',names[i],'.csv', sep=''), row.names = FALSE, sep='\t', quote = FALSE)
  system(paste('gzip -c', ' /imppc/labs/dnalab/share/mar_navarro/pheweb_data/tests/input_files/csv/',names[i],'.csv > /imppc/labs/dnalab/share/mar_navarro/pheweb_data/tests/input_files/assoc-files/new/',names[i],'.gz', sep=''))
  #QQ plots
  png(file = paste("/imppc/labs/dnalab/share/mar_navarro/gwas/output/qq_plots/qq_",names[i],'.png',sep=''))
  qq(phenotype$P)
  dev.off()
  #Manhattan plots
  png(file = paste("/imppc/labs/dnalab/share/mar_navarro/gwas/output/manhattan/manhattan_",names[i],'.png',sep=''))
  manhattan(phenotype,'#CHROM','POS','P','ID')
  dev.off()
}


##### FOR MTAG RESULTS #####
library(qqman)
library(data.table)
library(dplyr)

files <- c('/imppc/labs/dnalab/share/mar_navarro/mtag/output/brown_skin.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/white_skin.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/very_white_skin.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/black_hair.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/brown_hair.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/blond_hair.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/freckles.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/sunburn.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/black_eyes.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/brown_eyes.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/light_brown_eyes.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/blue_green_eyes.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/light_blue_green_eyes.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/phototype.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/phototype_score.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/phototype2.txt',
           '/imppc/labs/dnalab/share/mar_navarro/mtag/output/phototype_score2.txt')
names2<-c('brown_skin','white_skin','very_white_skin','black_hair','brown_hair','blond_hair','freckles',
          'sunburn','black_eyes','brown_eyes','light_brown_eyes','blue_green_eyes','light_blue_green_eyes',
          'phototype','phototype_score','phototype2','phototype_score2')

for (i in 1:length(files)){
  #Pheweb
  phenotype = fread(files[i]) %>% arrange(CHR,BP) %>% filter(!is.na(mtag_pval)) %>% select(CHR , BP,	SNP,	A1	, A2, mtag_pval) %>% rename(pval=mtag_pval,`#CHROM`=CHR,POS=BP,ID=SNP,a1=A1,a2=A2)
  write.table(phenotype, paste('/imppc/labs/dnalab/share/mar_navarro/pheweb_data/tests/input_files/csv/mtag_',names2[i],'.csv', sep=''), row.names = FALSE, sep='\t', quote = FALSE)
  system(paste('gzip -c', ' /imppc/labs/dnalab/share/mar_navarro/pheweb_data/tests/input_files/csv/mtag_',names2[i],'.csv > /imppc/labs/dnalab/share/mar_navarro/pheweb_data/tests/input_files/assoc-files/new_mtag/',names2[i],'.gz', sep=''))
  #QQ plots
  png(file = paste("/imppc/labs/dnalab/share/mar_navarro/gwas/output/qq_plots/qq_mtag3_",names2[i],'.png',sep=''))
  qq(phenotype$mtag_pval)
  dev.off()
  #Manhattan plots
  png(file = paste("/imppc/labs/dnalab/share/mar_navarro/gwas/output/manhattan/manhattan_mtag3_",names2[i],'.png',sep=''))
  manhattan(phenotype,'CHR','BP','mtag_pval','SNP')
  dev.off()
}

