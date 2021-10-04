#######################
#Objetivo: recolectar información de twitter
#Autor: Alvaro Chirino
#Fecha: 1 de octubre
#######################
rm(list=ls())
library(readxl)
library(dplyr)
library(stringr)
library(lubridate)
library(rtweet)
library(httr)
library(httpuv)
##################################
## load rtweet

##################################
#medios de comunicación twitter
url1<-"https://github.com/ARUFoundation/endemocracia_redes/raw/main/data/Base_v0.xlsx"
GET(url1, write_disk(tf <- tempfile(fileext = ".xlsx")))
bdm <- read_excel(tf, 1)
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
tw_medios<-aux
bd_medios<-get_timelines(aux$screen_name,n=500)
save(tw_medios,bd_medios,file="C:\\Users\\Alvaro Chirino\\Documents\\GitHub\\endemocracia_redes\\data\\medios.RData")
##################################
#Camaras
