#######funciones creadas para el monitoreo
library(wordcloud)
library(wordcloud2)
fb$post_text

docs<-Corpus(VectorSource(fb$post_text))
docs 

docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)

docs <- tm_map(docs, content_transformer(tolower))

docs <- tm_map(docs, removeWords, c(stopwords("sp"),"ahora") )

dtm <- TermDocumentMatrix(docs) 

matrix <- as.matrix(dtm) 

words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)    
wordcloud2(df)
##funciones
#vectores de texto     
nube<-function(aux,palabras){
  docs<-Corpus(VectorSource(aux))
  docs <- docs %>%
    tm_map(removeNumbers) %>%
    tm_map(removePunctuation) %>%
    tm_map(stripWhitespace)
  docs <- tm_map(docs, content_transformer(tolower))
  docs <- tm_map(docs, removeWords, stopwords("sp"))
  docs <- tm_map(docs, removeWords, palabras)
  dtm <- TermDocumentMatrix(docs) 
  matrix <- as.matrix(dtm) 
  words <- sort(rowSums(matrix),decreasing=TRUE) 
  df <- data.frame(word = names(words),freq=words)    
  return(df)
}
#objetos corpus
nube2<-function(aux){
  docs <- aux %>%
    tm_map(removeNumbers) %>%
    tm_map(removePunctuation) %>%
    tm_map(stripWhitespace)
  docs <- tm_map(docs, content_transformer(tolower))
  docs <- tm_map(docs, removeWords, stopwords("sp"))
  dtm <- TermDocumentMatrix(docs) 
  matrix <- as.matrix(dtm) 
  words <- sort(rowSums(matrix),decreasing=TRUE) 
  df <- data.frame(word = names(words),freq=words)    
  return(df)
}