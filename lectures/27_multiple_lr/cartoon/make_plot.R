library(tidyverse)

set.seed(13)
n <- 10
x <- rnorm(n)
y <- x * 2 + 1 + rnorm(n)

dfdat <- data_frame(x = x, y = y)
pl <- ggplot(dfdat, aes(x = x, y = y)) +
  geom_point() +
  theme_bw() +
  stat_smooth(method = "lm", se = FALSE) +
  geom_hline(yintercept = mean(y), lty = 2)

pdf(file = "anova.pdf", family = "Times", height = 3, width = 3)
print(pl)
dev.off()
