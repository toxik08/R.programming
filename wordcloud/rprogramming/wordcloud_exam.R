
setwd("D:/rprogramming")

install.packages(c("tm", "SnowballC", "wordcloud", "RColorBrewer"))

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

set.seed(1234)

feedback_file <- "feedback.txt"

if (!file.exists(feedback_file)) {
  cat("feedback.txt not found. Generating synthetic data (1000+ feedback lines)...\n")
  
  girls_templates <- c(
    "The service at the restaurant was excellent and the staff were friendly.",
    "Food quality was great but the wait time was long.",
    "I love the menu and the ambience, but the dessert was too sweet.",
    "Friendly servers and quick service. Overall a wonderful experience.",
    "Portions were small for the price, but the flavor was excellent."
  )
  boys_templates <- c(
    "The government office staff were helpful and processed my documents quickly.",
    "Long queues at the government office; waiting times need improvement.",
    "The officials were professional but the system is slow.",
    "I appreciate the clear instructions and timely updates from the office.",
    "Paperwork is confusing, better signage would help visitors."
  )
  
  n_each <- 500
  girls_feedback <- sample(girls_templates, n_each, replace = TRUE)
  boys_feedback  <- sample(boys_templates, n_each, replace = TRUE)
  
 
  adjectives <- c("excellent","good","poor","slow","quick","friendly","rude","helpful","confusing","clear","efficient","inefficient","clean","dirty","organized","unorganized")
  verbs <- c("was","is","seems","felt")
  extras <- paste(sample(adjectives, n_each*2, replace = TRUE),
                  sample(verbs, n_each*2, replace = TRUE))
  

  girls_feedback <- paste(girls_feedback, "-", sample(c("", extras[1:n_each]), n_each, replace = FALSE))
  boys_feedback  <- paste(boys_feedback, "-", sample(c("", extras[(n_each+1):(2*n_each)]), n_each, replace = FALSE))
  
  feedback_all <- c(paste0("Girls: ", girls_feedback),
                    paste0("Boys: ", boys_feedback))
  
  feedback_all <- sample(feedback_all, length(feedback_all), replace = FALSE)
  
  writeLines(feedback_all, con = feedback_file, useBytes = TRUE)
  cat("Generated", length(feedback_all), "feedback lines to", feedback_file, "\n")
} else {
  cat("Using existing", feedback_file, "\n")
}

# ---- Part 1 – Data Preparation (25 pts) ----

raw_lines <- readLines(feedback_file, encoding = "UTF-8", warn = FALSE)

corpus <- VCorpus(VectorSource(raw_lines))
corpus <- tm_map(corpus, content_transformer(tolower))              
corpus <- tm_map(corpus, removeNumbers)                               
corpus <- tm_map(corpus, removePunctuation)                           
corpus <- tm_map(corpus, removeWords, stopwords("english"))           
corpus <- tm_map(corpus, stripWhitespace)                            
corpus <- tm_map(corpus, content_transformer(function(x) {x <- gsub("\\b(girl|girls|boy|boys)\\b:?\\s*", "", x, ignore.case = TRUE)
  return(x)
}))
corpus <- tm_map(corpus, stemDocument, language = "english")



# ---- Part 2 – Word Frequency Analysis (25 pts) ----
tdm <- TermDocumentMatrix(corpus, control = list(wordLengths = c(1, Inf)))
m <- as.matrix(tdm)
word_freq <- rowSums(m)
word_freq <- sort(word_freq, decreasing = TRUE)


freq_df <- data.frame(
  word = names(word_freq),
  frequency = as.integer(word_freq),
  row.names = NULL,
  stringsAsFactors = FALSE
)

top_n <- 10
top_words <- head(freq_df, n = top_n)
cat("Top", top_n, "most frequent words:\n")
print(top_words)
cat("\n")



# ---- Part 3 – Word Cloud Generation (30 pts) ----

freq_vec <- setNames(freq_df$frequency, freq_df$word)

png(filename = "wordcloud_exam.png", width = 800, height = 600)

pal <- brewer.pal(8, "Dark2")

wordcloud(
  names(freq_vec),
  freq = freq_vec,
  min.freq = 2,
  max.words = 1000,
  random.order = FALSE,       
  rot.per = 0.15,
  scale = c(4, 0.5),
  use.r.layout = FALSE
)

dev.off()
cat("Saved main word cloud to wordcloud_exam.png (800x600)\n")



# ---- Part 4 – Advanced Task (20 pts) ----

rare_words_df <- subset(freq_df, frequency == 1)

if (nrow(rare_words_df) == 0) {
  cat("No words with frequency = 1 found. Creating wordcloud with 5 least frequent words instead.\n")
  
  tail_n <- min(5, nrow(freq_df))
  rare_words_df <- tail(freq_df, n = tail_n)
}

rare_vec <- setNames(rare_words_df$frequency, rare_words_df$word)

png(filename = "wordcloud_rare.png", width = 800, height = 600)

wordcloud(
  names(rare_vec),
  freq = rare_vec,
  min.freq = 1,
  max.words = 1000,
  random.order = FALSE,
  rot.per = 0.1,
  scale = c(3, 0.5),
  use.r.layout = FALSE
)
dev.off()
cat("Saved rare word cloud to wordcloud_rare.png (800x600)\n\n")


