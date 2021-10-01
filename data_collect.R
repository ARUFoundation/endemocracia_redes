#######################
#Objetivo: recolectar información de twitter
#Autor: Alvaro Chirino
#Fecha: 1 de octubre
#######################
library(readxl)
library(dplyr)
library(stringr)
library(lubridate)
library(rtweet)
##################################

#medios de comunicación twitter
bdm<-read_excel("C:\\Users\\Alvaro Chirino\\Documents\\GitHub\\endemocracia_redes\\data\\Base_v0.xlsx",1)
bdm<-bdm %>% filter(twitter!="")

bdm$twitter<-str_trim(bdm$twitter,side=c("both"))
bdm$twitter<-gsub(" ","",bdm$twitter,fixed = T)
bdm$twitter<-gsub("@","",bdm$twitter,fixed = T)
bdm$twitter<-gsub("https://twitter.com/","",bdm$twitter,fixed = T)

vv<-c("user_id","screen_name","followers_count","profile_image_url")
aux<-NULL
for(i in 1:nrow(bdm)){
  #print(bdm$twitter[i])
  aa<-lookup_users(bdm$twitter[i])
  if(nrow(aa)>0){
    aux<-rbind(aa[,vv],aux  )  
  }
}
depto<-c("chuquisaca","lapaz","cochabamba","oruro","potosí","tarija","beni","pando","santacruz")
aux2<-get_timelines(aux$screen_name,n=200)
aux3<-aux2 %>% filter(as_date(created_at)==today())
aux4<-aux3 %>% mutate(nn=1) %>% group_by(screen_name) %>% mutate(nn=cumsum(nn)) %>% filter(nn<10)