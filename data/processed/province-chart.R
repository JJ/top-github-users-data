library('ggplot2')
github.user.data <- read.csv('aggregated-top-Spain.csv',sep=';')
github.user.data$place <- reorder(github.user.data$place, X=github.user.data$place, FUN= function(x) -length(x))
ggplot( data=github.user.data, aes( x=factor(1), fill=factor(place)))+ geom_bar(width = 1,color='black')+coord_polar(theta="y")+guides(fill=guide_legend(ncol=2))

