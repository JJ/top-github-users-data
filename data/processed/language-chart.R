library('ggplot2')
github.user.data <- read.csv('aggregated-top-Spain.csv',sep=';')
github.user.data$language <- reorder(github.user.data$language, X=github.user.data$language, FUN= function(x) -length(x))
language.table <- table(github.user.data$language)
language.table.acc <- head(language.table,n=20)
language.table.acc['Others'] = sum(as.vector(tail(language.table,n=-20)))
language.table.df <- data.frame( language=names(language.table.acc),users= as.vector(language.table.acc))
ggplot( data=language.table.df, aes(x="",y=users,fill=factor(language)))+ geom_bar(width=1,stat='identity') + coord_polar(theta='y')
ggsave( 'language-stacked-chart.png')


