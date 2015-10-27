
library("ggplot2")
language.province <- read.csv("place-language.csv")
language.top20 <- as.data.frame(summary(language.province$language, max=25))
language.top20.df <- data.frame(language=row.names(language.top20),
                                devs=language.top20$"summary(language.province$language, max = 25)")

ggplot()+geom_bar(data=language.top20.df,aes(reorder(language,devs),y=devs),stat="identity")+coord_flip()
ggplot( data=language.top20.df, aes(x="",y=devs,fill=factor(language)))+ geom_bar(width=1,stat='identity') + coord_polar(theta='y')