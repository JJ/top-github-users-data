library("ggplot2")
qplot(log10(seq_along(barcelona.data$contributions)), log10(barcelona.data$contributions)) +     geom_point(aes(y=log10(madrid.data$contributions),x=log10(seq_along(madrid.data$contributions)),color='madrid.data$contributions')) +    geom_point(aes(y=log10(zaragoza.data$contributions), x=log10( seq_along(zaragoza.data$contributions)),color='zaragoza.data$contributions')) +    geom_point(aes(y=log10(sevilla.data$contributions), x=log10( seq_along(sevilla.data$contributions)),color='sevilla.data$contributions')) +    geom_point(aes(y=log10(granada.data$contributions), x=log10( seq_along(granada.data$contributions)),color='granada.data$contributions')) 
ggsave("otros-zipf-github.png")

