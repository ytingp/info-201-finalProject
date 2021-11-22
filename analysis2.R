library(dplyr)
library(ggplot2)
library(tidyr)

game <- read.csv("Twitch_game_data.csv")

game_selected <- game %>%
  filter(Year == "2021") %>%
  select(Year, Month, Game, Hours_watched) %>%
  group_by(Game) %>%
  summarize(Hours_watched = sum(Hours_watched)) %>%
  arrange(desc(Hours_watched)) %>%
  top_n(10)

chart <- ggplot(game_selected) +
  geom_col(mapping = aes(x = Hours_watched, y = Game)) + 
  labs(x = "Watch Time", y = "Games", 
       title = "Top 10 Most Watched Games on Twitch in 2021")