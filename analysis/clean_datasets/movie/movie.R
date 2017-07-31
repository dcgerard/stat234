## Data from fivethirtyeight
## See https://fivethirtyeight.com/features/fandango-movies-ratings/
## and see https://github.com/fivethirtyeight/data/tree/master/fandango

## Movies that had ticket sales in 2015 and had at least 30 reiveiws on Fandango
library(tidyverse)
library(stringr)
movie <- read.csv(url("https://raw.githubusercontent.com/fivethirtyeight/data/master/fandango/fandango_score_comparison.csv"))

write.csv(movie, "../../../data/movie.csv", row.names = FALSE)

names(movie)
plot(movie$RottenTomatoes, movie$RottenTomatoes_User)
movie$FILM[movie$RottenTomatoes < 20 & movie$RottenTomatoes_User > 80] ## some sort of christian movie
movie$FILM[movie$RottenTomatoes > 95 & movie$RottenTomatoes_User < 60] ## some sort of artsy fartsy biopic


plot(table(movie$Fandango_Stars))
ggplot(data = movie, mapping = aes(x = Metacritic)) +
  geom_histogram(bins = 10, color = "black") +
  theme_bw()

movie_norm <- select(as_data_frame(movie), contains("norm"), Fandango_Stars) %>%
  select(contains("round"), Fandango_Stars) %>%
  gather(key = "source", value = "normalized_score") %>%
  mutate(source = str_replace(source, "_norm", "")) %>%
  mutate(source = str_replace(source, "_round", ""))

ggplot(data = movie_norm, mapping = aes(x = source, y = normalized_score)) +
  geom_boxplot() +
  theme_bw()
