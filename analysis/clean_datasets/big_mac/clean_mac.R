## Clean big-mac data
## Data from here: http://www.economist.com/content/big-mac-index

library(tidyverse)
bm_list <- list()
year_vec <- 2000:2017
for (index in 1:length(year_vec)) {
  bm_list[[index]] <- as_data_frame(read.csv(paste0("BMFile", year_vec[index], ".csv"), na.strings = "#N/A"))
  bm_list[[index]]$year <- year_vec[index]
  if ( "id" %in% names(bm_list[[index]])) {
    bm_list[[index]] <- mutate(bm_list[[index]], Country = id)
  }
  if (index == 1) {
    bm <- select(bm_list[[1]], Country, dollar_price, year)
  } else {
    temp <- select(bm_list[[index]], Country, dollar_price, year)
    bm <- bind_rows(bm, temp)
  }
}

bm <- bm %>% transmute(country = Country, dollar = dollar_price, year = year) %>%
  filter(!is.na(dollar))

write.csv(bm, "../../../data/big_mac.csv", row.names = FALSE)
