big_bob <- read.csv("bob.csv")
bob <- big_bob[, c(40, 51, 54)]
bob$RIVER[bob$RIVER == 0] <- "no_river"
bob$RIVER[bob$RIVER == 1] <- "river"
bob$SNOW[bob$SNOW == 0] <- "no_snow"
bob$SNOW[bob$SNOW == 1] <- "snow"
bob$MOUNTAIN[bob$MOUNTAIN == 0] <- "no_mountain"
bob$MOUNTAIN[bob$MOUNTAIN == 1] <- "mountain"
save(bob, file = "bob.RData")

load("bob.RData")
head(bob)

dat <- read.csv("https://raw.githubusercontent.com/dcgerard/stat234/master/data/survey_1_66.csv", row.names = 1)
survey_dat <- as.table(as.matrix(dat))

save(survey_dat, file = "survey_dat.RData")

load("survey_dat.RData")
survey_dat
