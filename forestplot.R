library(forestplot)
library(dplyr)
library(data.table)

files<-c('/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.black_skin.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.brown_skin.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.white_skin.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.very_white_skin.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.black_eyes.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.brown_eyes.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.brown_light_eyes.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.blue_green_eyes.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.blue_green_light_eyes.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_imp.hair_color_black.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_imp.hair_color_brown.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_imp.hair_color_blond.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_imp.hair_color_red.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.sunburn.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas.freckles.glm.firth',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_imp.fototipo_cat.glm.linear',
         '/imppc/labs/dnalab/share/mar_navarro/gwas/output/gwas_imp.fototipo_score.glm.linear')

p<-c(NA)
or<-c(NA)
l95<-c(NA)
u95<-c(NA)

for(i in 1:length(files)){
  file<-fread(files[i]) %>% filter(!is.na(P))
  p[i+1]<-min(file$P)
  if (i %in% c(17,16)){or[i+1]<-file$BETA[which(file$P==p[i+1])]}
  else{or[i+1]<-file$OR[which(file$P==p[i+1])]}
  l95[i+1]<-file$L95[which(file$P==p[i+1])]
  u95[i+1]<-file$U95[which(file$P==p[i+1])]
  rs[i+1]<-file$ID[which(file$P==p[i+1])]
}

cochrane_from_rmeta <- 
  data.frame(
    coef  = or, 
    low = l95,
    high = u95)

p[1]<-'P-value'
or[1]<-'OR'
l95[1]<-'L95'
u95[1]<-'U95'

tabletext <- cbind(
  c("Phenotype", "Black skin", "Brown skin", "White skin", 
    "Very white skin", "Black eyes", "Brown eyes", "Light brown eyes", 
    "Blue green eyes", 'Light blue green eyes','Black hair','Brown hair','Blond hair','Red hair','Sunburn','Freckles',
    'Phototype','Phototype score'),
  c('SNP','rs16891982','rs192032167','rs16891982','rs12913832','rs16891982','rs12913832','rs12913832','rs12325715',
    'rs12913832','rs12203592','rs12203592','rs1805007','rs12913832','rs12913832','rs12913832','rs16891982','rs12203592'),
  c('Nearest gene','SLC45A2','NXNL2','SLC45A2','HERC2','SLC45A2','HERC2','HERC2','CCL13','HERC2','IRF4','IRF4','MC1R','HERC2','SLC45A2','IRF4','HERC2','HERC2'),
  c("Cases", "3", "715", "2269", 
    "252", "581", "2436", "778", '911','281','952','3750','243','34','1555','2911','-','-'),
  c("Controls", "4982", "4270", "2716", 
    "4733", "4407", "2552", "4210", 
    "4077", '4707','4027','1229','4736','4945','3430','2073','-','-'),
  or, l95, u95, p)

forestplot(tabletext, cochrane_from_rmeta$coef,cochrane_from_rmeta$low,cochrane_from_rmeta$high, new_page = TRUE,
           is.summary=c(TRUE, rep(FALSE,17)), #bold
           clip=c(-9.00,9.00), xlog=F,
           col=fpColors(box="royalblue",line="darkblue", summary="royalblue"),
           grapwidth=unit(14,'cm'),
           txt_gp = fpTxtGp(label = gpar(cex=.55)))