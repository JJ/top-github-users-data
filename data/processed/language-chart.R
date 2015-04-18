library('ggplot2')
github.user.data <- read.csv('aggregated-top-Spain.csv',sep=';')
github.user.data$language <- reorder(github.user.data$language, X=github.user.data$language, FUN= function(x) -length(x))
language.table <- table(github.user.data$language)
language.table.acc <- head(language.table,n=-15)
language.table.acc['Others'] = sum(as.vector(head(language.table,n=-15)))
language.table.df <- data.frame( language=names(language.table.acc),users= as.vector(language.table.acc))
ggplot( data=language.table.df, aes( x=, fill=factor(V1)))+ geom_bar(width = 1,color='black')+coord_polar(theta="y")+guides(fill=guide_legend(ncol=2))

