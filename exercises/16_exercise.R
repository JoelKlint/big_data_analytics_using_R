# Exercise 16

# Assignment 1-a
URL="http://thefourthrevolution.org/wordpress/"
library(XML); library(bitops); library(RCurl)
htm <- getURL(URL)
doc <- htmlParse(htm, asText=TRUE)
ptx <- xpathSApply(doc, "//p", xmlValue)
star <- paste(ptx, collapse="\n")

library(NLP); library(tm)
corp <- Corpus(VectorSource(star))
corp = tm_map(corp,removePunctuation)
corp = tm_map(corp,tolower)
corp = tm_map(corp,removeNumbers)
corp = tm_map(corp,removeWords, stopwords("english"))
corp <- tm_map(corp, removeWords,c("can","far","live",
                                   "now","one","say","will"))
corp = tm_map(corp,PlainTextDocument)

dtm <- DocumentTermMatrix(corp)  
Freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)  
head(Freq,20)

library(RColorBrewer); library(wordcloud)
wf <- data.frame(Word=names(Freq), Freq=Freq)
wordcloud(words=wf$Word, freq=wf$Freq, min.freq=5,
          random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8,"Dark2"))

# Assignment 1-b
library(ggplot2)  
ggplot(subset(wf, Freq>4), aes(Word,Freq)) +    
  geom_bar(stat="identity",fill="green") + theme_bw() +  
  theme(axis.text.x=element_text(angle=0, hjust=1)) + coord_flip()  

