## Bob Ross Data
## see https://fivethirtyeight.com/features/a-statistical-analysis-of-the-work-of-bob-ross/
## also see https://github.com/fivethirtyeight/data/tree/master/bob-ross

bob <- read.csv(url("https://raw.githubusercontent.com/fivethirtyeight/data/master/bob-ross/elements-by-episode.csv"))

write.csv(bob, "../../data/bob.csv", row.names = FALSE)

table(bob$TREE, bob$CLOUDS)
table(bob$MOUNTAIN, bob$CLOUDS)
