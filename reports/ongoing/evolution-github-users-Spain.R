## ---- echo=FALSE, message=FALSE,results='hide',warning=FALSE-------------
# Extracted from evolution-github-users-Spain.Rmd
#load libraries
library(ggplot2)
library(ggthemes)
# Remember to run first 
# ./get-versions-csv.pl data/processed/aggregated-top-Spain.csv > data/processed/aggregated-top-Spain-evol.csv
agg.top.Spain.evol <- read.csv("../../data/processed/aggregated-top-Spain-evol.csv",sep=';')
agg.top.Spain.evol$idu <- as.numeric(row.names(agg.top.Spain.evol))
agg.top.Spain.evol$commitdate <-as.Date(agg.top.Spain.evol$commitdate)
ggplot(agg.top.Spain.evol,aes(x=commitdate,y=users))+geom_line()+geom_point()+theme_tufte()+scale_x_date()

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot(agg.top.Spain.evol,aes(x=idu,y=users))+geom_line()+geom_point()+theme_tufte()

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot(agg.top.Spain.evol,aes(x=users,y=followers))+geom_line()+geom_point()

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot(agg.top.Spain.evol,aes(x=users,y=contributions))+geom_line()+geom_point()

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot(agg.top.Spain.evol,aes(x=idu,y=contributions/users))+geom_line()+geom_point()

