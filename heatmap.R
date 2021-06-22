##### PHENOTYPE ASSOCIATION #####
library(ggplot2)

zscore<-c(1, 1, -1, -1,  1, -1, -1,  1, 1,  1,  1,  1,  -1, -1, -1, -1, -1,  -1, -1, -1, -1, 1, -1, 1, 1, -1, 1, -1, 1, -1, 1, -1, -1, 1, 1, 1, -1, -1, -1, 1, 1, -1, 1,1,1, 1,1 ,-1, -1, -1, -1, -1, -1, 1, 1)
genes<-c('RXFP3','PTPRT','PTPRT','IRF4','IRF4','IRF4','SLC45A2','SLC45A2','SLC45A2','SLC45A2','HERC2/OCA2','HERC2/OCA2','CCL13','HERC2/OCA2',
         'HERC2/OCA2','HERC2/OCA2','MC1R','HERC2/OCA2','HERC2/OCA2','IRF4','IRF4','IRF4','IRF4','SLC45A2','SLC45A2','SLC45A2','SLC45A2','SLC45A2','HERC2/OCA2','HERC2/OCA2',
         'HERC2/OCA2','HERC2/OCA2','RXFP3','RXFP3','RXFP3','RXFP3','RXFP3','GOLGA8F','GOLGA8F','GOLGA8F','GOLGA8F','GOLGA8F','GOLGA8F','GOLGA8F','GOLGA8F','ADAMTS12','ADAMTS12','ADAMTS12',
         'ADAMTS12','TUBB3','TUBB3','MC1R','MC1R','TYRP1','TYRP1')
pheno<-c('dSunburn','qBrown hair','rBlack hair','rBlack hair','qBrown hair','cFreckles','hBrown skin','gWhite skin',
         'fVery white skin','dSunburn','nBlack eyes','mBrown eyes','lLight brown eyes','kBlue/green eyes','jLight blue/green eyes',
         'pBlond hair','oRed hair','bPhototype','aPhototype score','fVery white skin','kBlue/green eyes','mBrown eyes','dSunburn','bPhototype','aPhototype score','rBlack hair','qBrown hair',
         'nBlack eyes','rBlack hair','gWhite skin','hBrown skin','dSunburn','hBrown skin','aPhototype score','bPhototype','gWhite skin','rBlack hair','nBlack eyes','mBrown eyes','kBlue/green eyes','jLight blue/green eyes',
         'rBlack hair','pBlond hair','bPhototype','aPhototype score','aPhototype score','bPhototype','hBrown skin','rBlack hair','bPhototype','aPhototype score','bPhototype','aPhototype score','bPhototype',
         'aPhototype score')
data<-data.frame(genes,pheno,zscore)
p<-ggplot(data,aes(x=genes,y=pheno,fill=factor(zscore)))+geom_tile(color='grey')+theme(axis.title.y = element_blank(), #Remove the y-axis title
                                                                axis.text.x = element_text(angle = 90, vjust = 0.5, face='italic'))
p <- p +theme(
    panel.background = element_rect(fill = "transparent") #All rectangles
  )
p<-p+scale_y_discrete(labels = c('Phototype score','Phototype','Freckles','Skin sensitivity','Very white skin','White skin','Brown skin','Light blue/green eyes','Blue/green eyes','Light brown eyes','Brown eyes',
                              'Black eyes','Red hair','Blond hair','Brown hair','Black hair'))
p + scale_fill_discrete(name = 'Z-score', labels = c('Negative','Positive'))  #Legend  


##### CHROMOSOME LOCATION #####
library(ggplot2)

gene<-c('aADAMTS12','bSLC45A2','cRXFP3','eIRF4','dEXOC2','gTYR','fNOX4','hKATNAL1','iOCA2','kHERC2','jGOLGA8F','mMC1R','lGAS8','nTUBB3','oPTPRT')
chr<-c('achr5q35','bchr5p13','cchr5p15','dchr6p25','dchr6p25','echr11q14','echr11q14','fchr13q12','gchr15q11','hchr15q13','hchr15q13','ichr16q24',
    'ichr16q24','ichr16q24','jchr20q12')
data2<-data.frame(gene,chr)
p<-ggplot(data2,aes(x=chr,y=gene,fill='green'))+geom_tile(color='grey',show.legend=FALSE)
p<-p+theme(axis.title.y = element_blank(),axis.text.y = element_text(face = 'italic'),
           axis.text.x = element_text(angle = 90, vjust = 0.5))
p <- p +theme(
  panel.background = element_rect(fill = "transparent") #All rectangles
)
p<-p+scale_x_discrete(labels=c('chr5q35','chr5p13','chr5p15','chr6p25','chr11q14','chr13q12','chr15q11','chr15q13','chr16q24','chr20q12'))
p+scale_y_discrete(labels=c('ADAMTS12','SLC45A2','RXFP3','EXOC2','IRF4','NOX4','TYR',
                            'KATNAL1','OCA2','GOLGA8F','HERC2','GAS8','MC1R','TUBB3','PTPRT'))

