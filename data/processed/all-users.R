#!/usr/bin/env Rscript
library("ggplot2")
agg.top.Spain.evol <- read.csv("aggregated-top-Spain-evol.csv",sep=';')
ggplot(agg.top.Spain.evol,aes(x=users,y=followers))+geom_line()+geom_point()
ggsave('users-vs-followers.png')
ggplot(agg.top.Spain.evol,aes(x=users,y=contributions))+geom_line()+geom_point()
ggsave('users-vs-contributions.png')
