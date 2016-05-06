## ---- echo=FALSE, message=FALSE,results='hide',warning=FALSE-------------

#load libraries
library(ggplot2)
library(mclust)
library(MASS)

# Remember to run first 
#./agg-csv.pl > data/processed/data-per-province.csv  
# and
# cd apps; ./get-languages.pl > ../data/processed/place-language.csv

data.province <- read.csv('../../data/processed/data-per-province.csv',sep=';')
data.province$usersrel <- data.province$users / data.province$population
data.province$contribrel <- data.province$contributions / data.province$population
data.province$followersrel <- data.province$followers / data.province$population
data.province$starsrel <- data.province$stars / data.province$population
data.province$userstarsrel <- data.province$user_stars / data.province$population

# Remember to run first
# merge-city.coffee
github.user.data <- read.csv('../../data/processed/aggregated-top-Spain.csv',sep=';')
github.user.data$place <- reorder(github.user.data$place, X=github.user.data$place, FUN= function(x) -length(x))
province.table <- table(github.user.data$place)
province.table.acc <- head(province.table,n=10)
province.table.acc['Others'] = sum(as.vector(tail(province.table,n=-10)))
province.table.df <- data.frame( province=names(province.table.acc),users= as.vector(province.table.acc))

github.user.data$language <- reorder(github.user.data$language, X=github.user.data$language, FUN= function(x) -length(x))
language.table <- table(github.user.data$language)
language.table.acc <- head(language.table,n=20)
language.table.acc['Others'] = sum(as.vector(tail(language.table,n=-20)))
language.table.df <- data.frame( language=names(language.table.acc),users= as.vector(language.table.acc))
# languages split
language.province <- read.csv("../../data/processed/place-language.csv")
language.top20 <- as.data.frame(summary(language.province$language, max=25))
language.top20.df <- data.frame(language=row.names(language.top20),
                                devs=language.top20$"summary(language.province$language, max = 25)")

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot(data.province, aes(x=reorder(province,population),y=users))+geom_bar(stat='identity')+coord_flip()

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot( data=province.table.df, aes(x="",y=users,fill=factor(province)))+ geom_bar(width=1,stat='identity') + coord_polar(theta='y')

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot(data.province, aes(x=reorder(province,usersrel),y=usersrel))+geom_bar(stat='identity')+coord_flip()

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot(data.province, aes(x=reorder(province,contribrel),y=contribrel))+geom_bar(stat='identity')+coord_flip()

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot(data.province, aes(x=reorder(province,followersrel),y=followersrel))+geom_bar(stat='identity')+coord_flip()

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot(data.province, aes(x=reorder(province,starsrel),y=starsrel))+geom_bar(stat='identity')+coord_flip()

## ----userstars, echo=FALSE,fig.width=10,fig.height=8---------------------
ggplot(data.province, aes(x=reorder(province,userstarsrel),y=userstarsrel))+geom_bar(stat='identity')+coord_flip()

## ----cluster, echo=FALSE,warning=FALSE,fig.width=10,fig.height=8---------
data.province.rel <- data.frame(users=data.province$usersrel, contrib=data.province$contribrel, stars=data.province$starsrel, userstars=data.province$userstarsrel )

data.province.clust <- Mclust(data.province.rel)
data.province$CLUST <- data.province.clust$classification

d <- dist(data.province.rel)
scaling <- isoMDS(d, k=2)
data.province$scaledx = scaling$points[,1]
data.province$scaledy = scaling$points[,2]

ggplot(data.province, aes(x=scaledx, y=scaledy, colour=factor(CLUST),shape=factor(CLUST)))+geom_point()+ geom_text(aes(label=province,angle=315,hjust=0))

## ---- echo=FALSE,fig.width=10,fig.height=8-------------------------------
ggplot( data=language.top20.df, aes(x="",y=devs,fill=factor(language)))+ geom_bar(width=1,stat='identity') + coord_polar(theta='y')

