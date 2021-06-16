library(ggplot2)

##### Barplot for the significant heritabilities #####
data<-read.table('phototype_gcta_h2.tsv', sep = '\t', header = TRUE)
data<-data[c(4,6,15,17,21),]
data$trait<-c('Brown skin','Phototype','Black hair','Light brown eyes','Phototype score')
p<-ggplot(data,aes(x=trait,y=h2))+geom_bar(stat='identity',fill='steelblue',width = 0.5)
p+geom_errorbar(aes(ymin=h2-se,ymax=h2+se),width=0.2)

##### Barplot for all heritabilities #####
data<-read.table('phototype_gcta_h2.tsv', sep = '\t', header = TRUE)
data<-data[-c(2,3,5,7,14,22,23),]
data$trait<-c('Brown eyes','Brown skin','Phototype','Blond hair','Light blue/green eyes','White skin','Freckles','Blue/green eyes'
              ,'Red hair','Black hair','Very white skin','Light brown eyes','Black eyes','Sunburn','Brown hair','Phototype score')
p<-ggplot(data,aes(x=trait,y=h2))+geom_bar(stat='identity',fill='steelblue',width = 0.5)
p+theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
