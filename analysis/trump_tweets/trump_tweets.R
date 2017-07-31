## load and clean trump twitter data
## Using code from this blog post: http://varianceexplained.org/r/trump-tweets/
load(url("http://varianceexplained.org/files/trump_tweets_df.rda"))
library(tidyverse)
library(stringr)
glimpse(trump_tweets_df)

tweets <- trump_tweets_df %>%
  select(id, statusSource, text, created) %>%
  extract(statusSource, "source", "Twitter for (.*?)<") %>%
  filter(source %in% c("iPhone", "Android"))

library(lubridate)
library(scales)
tweets <- tweets %>% mutate(hour = hour(with_tz(created, "EST")))
tweets$quote <- ifelse(stringr::str_detect(tweets$text, '^\".+\"'),
                           "qote", "no_quote")

tweets$picture <- ifelse(str_detect(tweets$text, "t.co"),
                          "picture", "no_picture")
tweets$very <- ifelse(str_detect(tweets$text, ignore.case("very")),
                             "very", "no_very")

tweets <- mutate(tweets, text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp|&lt;", ""))
tweets <- mutate(tweets, text = str_replace_all(text, "\\n", ""))
tweets <- mutate(tweets, text = str_replace_all(text, "[ ]+$", ""))

tweets$length <- str_length(tweets$text)

table(tweets$quote, tweets$source)
table(tweets$picture, tweets$source)
very_table <- table(tweets$very, tweets$source)
prop.table(very_table, margin = 2)



library(tidytext)
twords <- tweets %>% unnest_tokens(word, text) %>%
  select(id, word)

temp <- twords %>% right_join(get_sentiments("nrc")) %>%
  filter(!is.na(sentiment)) %>%
  group_by(id) %>%
  count(sentiment, sort = TRUE) %>%
  spread(key = sentiment, value = n)

temp[, 2:11] <- !is.na(temp[, 2:11])

tweets2 <- inner_join(tweets, temp, by = "id")

tweets3 <- filter(tweets2, quote == "no_quote")

prop.table(table(tweets3$source, tweets3$negative), margin = 1)
prop.table(table(tweets3$source, tweets3$positive), margin = 1)
prop.table(table(tweets3$source, tweets3$anger), margin = 1)
prop.table(table(tweets3$source, tweets3$fear), margin = 1)
prop.table(table(tweets3$source, tweets3$anticipation), margin = 1)
prop.table(table(tweets3$source, tweets3$joy), margin = 1)
prop.table(table(tweets3$source, tweets3$sadness), margin = 1)
prop.table(table(tweets3$source, tweets3$surprise), margin = 1)
prop.table(table(tweets3$source, tweets3$trust), margin = 1)
prop.table(table(tweets3$source, tweets3$disgust), margin = 1)
prop.table(table(tweets3$source, tweets3$quote), margin = 1)
prop.table(table(tweets3$source, tweets3$picture), margin = 1)

write.csv(tweets2, file = "../../data/trump.csv", row.names = FALSE)

