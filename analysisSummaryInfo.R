library(dplyr)

top_game <- game %>%
  filter(Year == "2021") %>%
  select(Year, Month, Game, Hours_watched) %>%
  group_by(Game) %>%
  summarize(Hours_watched = sum(Hours_watched)) %>%
  filter(Hours_watched == max(Hours_watched)) %>%
  select(Game)

Most_streamer_game <- game %>%
  filter(Year == "2021") %>%
  select(Year, Month, Game, Streamers) %>%
  group_by(Game) %>%
  summarize(Streamers = sum(Streamers)) %>%
  filter(Streamers == max(Streamers)) %>%
  select(Game)