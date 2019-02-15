
shinyServer( function(input, output) {
  
  
  portales <- c(espectador = "https://www.elespectador.com/noticias",
                tiempo = 'https://www.eltiempo.com/economia',
                semana = 'https://www.semana.com/seccion/economia/4-1',
                caracol = 'http://caracol.com.co/seccion/economia/',
                republica = 'https://www.larepublica.co/',
                canal1 = 'https://canal1.com.co/noticias/economia/',
                elpais = 'https://www.elpais.com.co/economia')
  
  htmls <- c(esp = '.field--type-ds a',
             tiempo = '.titulo .page-link',
             semana = '.article-h-link',
             caracol = '.module-title',
             republica ='.headline a',
             canal1 = '.title a',
             elpais = '.listing-title .page-link',
             elcolombiano = '#layout-column_estraordinario .priority-content')
  
  diarios = c('ESP','TIM','SEM','CAR','REP','CAN','ELP')
  
  final <-  cbind2(x = "xxx", y = 'xxx')
  
  for (i in 1:length(portales)) {
    
    webpage <- read_html(portales[i])
    noticias_data_html <- html_nodes(webpage, htmls[i])
    noticias<-as.matrix(noticias_data_html)
    
    matches <- regmatches(noticias_data_html, 
                          gregexpr("[[:digit:]]+", 
                                   noticias_data_html))
    numeros <- list()
    
    for (j in 1:length(matches)) {
      if (length(matches[[i]]) > 1) {
        numeros[j] <-as.character(
          max(as.numeric(matches[[j]])))
      } else
        numeros[j] <- matches[j]
    }
    
    noticias <- noticias_data_html
    
    for (k in 1:length(numeros)){
      noticias<-gsub(pattern = numeros[k],
                     replacement = " . ",x = noticias )
    }
    
    noticias<- sub("^[^.]*", "", noticias)
    noticias<- sub("^[^>]*", "", noticias)
    noticias<- sub(">", "", noticias)
    noticias<- sub("</a>", "", noticias)
    noticias<- sub("</span>", "", noticias)
    noticias<- sub("h2", "", noticias)
    noticias<- sub('<span>', "", noticias)
    noticias<- sub('</>', "", noticias)
    noticias <- cbind2(as.matrix(noticias),diarios[i])
    final <- rbind(final,noticias)
  }
  
  docs <- Corpus(VectorSource(final[,1]))
  docs <- tm_map(docs, content_transformer(tolower))
  docs <- tm_map(docs, removeNumbers)
  docs <- tm_map(docs, removePunctuation)
  docs <- tm_map(docs, removeWords, stopwords("spanish"))
  
  dtm <- TermDocumentMatrix(docs)
  m <- as.matrix(dtm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  findAssocs(dtm, terms = "rep", corlimit = 0.3)
  
  
  w<-as.data.frame(unlist(docs))
  h <- as.data.frame(w[,1])
  
  texto <- tibble(text = h[,1])
  
  austen_bigrams <- texto %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2)
  
  austen_bigrams %>%
    count(bigram, sort = TRUE)
  
  bigrams_separated <- austen_bigrams %>%
    separate(bigram, c("word1", "word2"), sep = " ")
  
  # new bigram counts:
  bigram_counts <-  bigrams_separated %>% 
    count(word1, word2, sort = TRUE)
  
  bigram_graph <- bigram_counts %>%
    filter(n > 3) %>%
    graph_from_data_frame()
  
  output$distPlot1 <- renderPlot({
    wordcloud(words = d$word, freq = d$freq, min.freq = 5,
              max.words=100, random.order=FALSE,random.color = TRUE, rot.per=0.35, 
              colors=brewer.pal(8, "Dark2"))
    
  })
  
  output$distPlot2 <- renderPlot({
    a <- grid::arrow(type = "closed", length = unit(.15, "inches"))
    
    ggraph(bigram_graph, layout = "fr") +
      geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                     arrow = a, end_cap = circle(.07, 'inches')) +
      geom_node_point(color = "lightblue", size = 5) +
      geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
      theme_void()
    
    
  })
}
)
