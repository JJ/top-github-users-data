
#Taken from http://stats.stackexchange.com/questions/6780/how-to-calculate-zipfs-law-coefficient-from-a-set-of-top-frequencies

p<-madrid.data$contributions/sum(madrid.data$contributions)

lzipf <- function(s,N) -s*log(1:N)-log(sum(1/(1:N)^s))

opt.f <- function(s) sum((log(p)-lzipf(s,length(p)))^2)

opt <- optimize(opt.f,c(0.5,10))

p<-barcelona.data$contributions/sum(barcelona.data$contributions)

opt.f <- function(s) sum((log(p)-lzipf(s,length(p)))^2)

opt <- optimize(opt.f,c(0.5,10))

p<-granada.data$contributions/sum(granada.data$contributions)

opt.f <- function(s) sum((log(p)-lzipf(s,length(p)))^2)

opt <- optimize(opt.f,c(0.5,10))

p<-zaragoza.data$contributions/sum(zaragoza.data$contributions)

opt.f <- function(s) sum((log(p)-lzipf(s,length(p)))^2)

opt <- optimize(opt.f,c(0.5,10))

p<-valencia.data$contributions/sum(valencia.data$contributions)

opt.f <- function(s) sum((log(p)-lzipf(s,length(p)))^2)

opt <- optimize(opt.f,c(0.5,10))
