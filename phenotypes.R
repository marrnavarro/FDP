library(dplyr)
library(data.table)

questionari = fread('/imppc/labs/dnalab/nblaym/mysql/output/questionari_nivell1.csv', na.strings = 'NULL') %>% 
  select(entity_id,FOTOTIPO_PECAS,FOTOTIPO_QUEMADURAS_PRIMERA_EXPOSICION_SOLAR, FOTOTIPO_OJOS, FOTOTIPO_PIEL)

questionari$freckles<-rep(2,19370)  #Controls
questionari$freckles[which(questionari$FOTOTIPO_PECAS %in% c(1,2))]<-1  #Questionnaire answers are 'Abundant freckles' and 'Some freckles'

questionari$sunburn<-rep(2,19370)  #Controls
questionari$sunburn[which(questionari$FOTOTIPO_QUEMADURAS_PRIMERA_EXPOSICION_SOLAR %in% c(1,2))]<-1 #Questionnaire answers are 'Yes, I burn easily' and 'Yes, I burn moderately'

questionari$freckles[which(questionari$FOTOTIPO_PECAS==0)]<-NA  #Questionnaire answer is 'Does not know/Does not answer'
questionari$sunburn[which(questionari$FOTOTIPO_QUEMADURAS_PRIMERA_EXPOSICION_SOLAR==0)]<-NA  #Questionnaire answer is 'Does not know/Does not answer'

questionari$black_eyes<-rep(2,19370)
questionari$black_eyes[which(questionari$FOTOTIPO_OJOS==1)]<-1 #Questionnaire answer is 'Black eyes'

questionari$brown_eyes<-rep(2,19370)
questionari$brown_eyes[which(questionari$FOTOTIPO_OJOS==2)]<-1 #Questionnaire answer is 'Brown eyes'

questionari$brown_light_eyes<-rep(2,19370)
questionari$brown_light_eyes[which(questionari$FOTOTIPO_OJOS==3)]<-1 #Questionnaire answer is 'Light brown eyes'

questionari$blue_green_eyes<-rep(2,19370)
questionari$blue_green_eyes[which(questionari$FOTOTIPO_OJOS==4)]<-1  #Questionnaire answer is 'Blue, green or gray eyes'

questionari$blue_green_light_eyes<-rep(2,19370)
questionari$blue_green_light_eyes[which(questionari$FOTOTIPO_OJOS==5)]<-1  #Questionnaire answer is 'Light blue, green or gray eyes'

questionari$black_skin<-rep(2,19370)
questionari$black_skin[which(questionari$FOTOTIPO_PIEL==1)]<-1  #Questionnaire answer is 'Black skin'

questionari$brown_skin<-rep(2,19370)
questionari$brown_skin[which(questionari$FOTOTIPO_PIEL==2)]<-1  #Questionnaire answer is 'Brown skin'

questionari$medium_skin<-rep(2,19370)
questionari$medium_skin[which(questionari$FOTOTIPO_PIEL==3)]<-1  #Questionnaire answer is 'Medium skin'

questionari$white_skin<-rep(2,19370)
questionari$white_skin[which(questionari$FOTOTIPO_PIEL==4)]<-1  #Questionnaire answer is 'White skin'

questionari$very_white_skin<-rep(2,19370)
questionari$very_white_skin[which(questionari$FOTOTIPO_PIEL==5)]<-1  #Questionnaire answer is 'Very white skin'

#Questionnaire answer is 'Does not know/Does not answer'
questionari$very_white_skin[which(questionari$FOTOTIPO_PIEL==0)]<-NA
questionari$white_skin[which(questionari$FOTOTIPO_PIEL==0)]<-NA
questionari$medium_skin[which(questionari$FOTOTIPO_PIEL==0)]<-NA
questionari$brown_skin[which(questionari$FOTOTIPO_PIEL==0)]<-NA
questionari$black_skin[which(questionari$FOTOTIPO_PIEL==0)]<-NA
questionari$black_eyes[which(questionari$FOTOTIPO_OJOS==0)]<-NA
questionari$brown_eyes[which(questionari$FOTOTIPO_OJOS==0)]<-NA
questionari$brown_light_eyes[which(questionari$FOTOTIPO_OJOS==0)]<-NA
questionari$black_eyes[which(questionari$FOTOTIPO_OJOS==0)]<-NA
questionari$blue_green_eyes[which(questionari$FOTOTIPO_OJOS==0)]<-NA
questionari$blue_green_light_eyes[which(questionari$FOTOTIPO_OJOS==0)]<-NA

#Remove the columns that do not have the phenotypes in binary mode
new_questionari<-questionari[,-2]
for (i in 1:3){
  new_questionari<-new_questionari[,-2] 
}

consulta = fread('/imppc/labs/dnalab/nblaym/mysql/output/consulta_nivell2.csv', na.strings = 'NULL') %>% 
  filter(SPAIN_CORE==TRUE) %>%  #Spanish population only
  select(entity_id, GENOTYPED_SAMPLE)
psam = left_join(new_questionari,consulta,'entity_id') %>% filter(!is.na(GENOTYPED_SAMPLE))  #Join by entity_id
psam = psam[,-1] #remove entity_id
old = fread('/imppc/labs/dnalab/share/mar_navarro/genotips/GCATcore.psam', na.strings = 'NULL')
gcat_core = left_join(old,psam,c('IID'='GENOTYPED_SAMPLE'))
write.table(gcat_core, '/imppc/labs/dnalab/share/mar_navarro/genotips/GCATcore.psam', row.names = FALSE, sep='\t', quote = FALSE)