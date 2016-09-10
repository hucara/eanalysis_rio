# wordclouds


set.seed(1234)

freqr <- colSums(as.matrix(base.dtm))
forder <- order(freqr, decreasing=TRUE)
freqr[head(forder)]
freqr[tail(forder)]

require(quanteda)
require(RColorBrewer)
source("stopWords.R")
d <- dfm(tweets$chtext, ignoredFeatures = sw, stem = TRUE)
plot(d, max.words = 500, colors = brewer.pal(6, "Dark2"))

d <- dfm(tweets$chtext[tweets$class == "happy"], ignoredFeatures = sw, stem = TRUE)
plot(d, max.words = 100, colors = brewer.pal(6, "Dark2"))

d <- dfm(tweets$chtext[tweets$class == "sad"], ignoredFeatures = sw, stem = TRUE)
plot(d, max.words = 100, colors = brewer.pal(6, "Dark2"))

d <- dfm(tweets$chtext[tweets$class == "angry"], ignoredFeatures = sw, stem = TRUE)
plot(d, max.words = 100, colors = brewer.pal(6, "Dark2"))

d <- dfm(tweets$chtext[tweets$class == "surprised"], ignoredFeatures = sw, stem = TRUE)
plot(d, max.words = 100, colors = brewer.pal(6, "Dark2"))

d <- dfm(tweets$chtext[tweets$class == "disgusted"], ignoredFeatures = sw, stem = TRUE)
plot(d, max.words = 100, colors = brewer.pal(6, "Dark2"))

d <- dfm(tweets$chtext[tweets$class == "afraid"], ignoredFeatures = sw, stem = TRUE)
plot(d, max.words = 100, colors = brewer.pal(6, "Dark2"))
