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
very_table
very_table <- table(tweets$very, tweets$source)
prop.table(very_table, margin = 2)

write.csv(tweets, file = "../../data/trump.csv", row.names = FALSE)

