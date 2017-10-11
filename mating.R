mating <- as.table(rbind(c(78, 23, 13),
                         c(19, 23, 12),
                         c(11, 9, 16)))

dimnames(mating) <- list(self = c("blue", "brown", "green"), partner = c("blue", "brown", "green"))

save(mating, file = "mating.RData")


load("mating.RData")
mating

mosaicplot(mating, color = TRUE)
