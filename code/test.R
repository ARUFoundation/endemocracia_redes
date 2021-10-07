rm(list=ls())
N<-10^6
x<-rnorm(N)
bd<-data.frame(x,date())
fecha<-date()
save(bd,fecha,file="base.RData")