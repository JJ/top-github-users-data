data.province <- read.csv('data-per-province.csv',sep=';')
data.province$usersrel <- data.province$users / data.province$population
data.province$contribrel <- data.province$contributions / data.province$population
data.province$followersrel <- data.province$followers / data.province$population
data.province$starsrel <- data.province$stars / data.province$population
library(ggplot2)
ggplot(data.province, aes(x=reorder(province,population),y=users))+geom_bar(stat='identity')+coord_flip()
ggsave("users-by-province.png")
ggplot(data.province, aes(x=reorder(province,usersrel),y=usersrel))+geom_bar(stat='identity')+coord_flip()
ggsave("users-rel-by-province.png")
ggplot(data.province, aes(x=reorder(province,contribrel),y=contribrel))+geom_bar(stat='identity')+coord_flip()
ggsave("contrib-rel-by-province.png")
ggplot(data.province, aes(x=reorder(province,followersrel),y=followersrel))+geom_bar(stat='identity')+coord_flip()
ggsave("followers-rel-by-province.png")
ggplot(data.province, aes(x=reorder(province,starsrel),y=starsrel))+geom_bar(stat='identity')+coord_flip()
ggsave("stars-rel-by-province.png")
