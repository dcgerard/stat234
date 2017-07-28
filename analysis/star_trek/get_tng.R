## TNG dataset
## See https://github.com/RMHogervorst/TNG

library(TNG)
library(tidyverse)
library(stringr)
data("TNG")


main_characters <- c("picard", "riker", "geordi", "tasha", "worf", "beverly", "pulaski", "troi",
                     "data", "wesley")

TNG$num_words <- sapply(gregexpr("\\W+", TNG$text), length) + 1
TNG <- filter(as_data_frame(TNG), type == "speech")

for (index in 1:length(main_characters)) {
  temp <- filter(TNG, str_detect(who, ignore.case(main_characters[index]))) %>%
    group_by(episode) %>%
    summarize(numwords = sum(num_words)) %>%
    ungroup()
  names(temp) <- c("episode", main_characters[index])
  if (index == 1) {
    word_dat <- temp
  } else {
    word_dat <- left_join(word_dat, temp, bye = "episode")
  }
}
word_dat[is.na(word_dat)] <- 0

trek <- select(TNG, episode, Released, Episode, Season) %>%
  distinct()
trek[trek$episode == "rascals", 2:4] <- c("1992-10-30", 7, 6)
trek[trek$episode == "time's arrow", 2:4] <- c("1992-06-15", 26, 5)
trek$Episode <- as.numeric(trek$Episode)
trek$Season <- as.numeric(trek$Season)
trek$index <- rank(trek$Released)
trek <- right_join(trek, word_dat, by = "episode")



trek$tot_words <- rowSums(select(trek, picard:wesley))
trek <- trek %>% mutate(picard_prop = picard / tot_words,
                riker_prop = riker / tot_words,
                geordi_prop = geordi / tot_words,
                tasha_prop = tasha / tot_words,
                worf_prop = worf / tot_words,
                beverly_prop = beverly / tot_words,
                pulaski_prop = pulaski / tot_words,
                troi_prop = troi / tot_words,
                data_prop = data / tot_words,
                wesley_prop = wesley / tot_words)

write.csv(trek, file = "../../data/trek.csv", row.names = FALSE)

ggplot(data = trek, mapping = aes(x = index, y = picard_prop)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  geom_vline(xintercept = cumsum(table(trek$Season)), lty = 2) +
  theme_bw()

qqnorm(sqrt(trek$picard))
qqline(sqrt(trek$picard))


