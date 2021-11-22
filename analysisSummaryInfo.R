library(dplyr)

game <- read.csv("Twitch_game_data.csv")
my_data <- read_excel(file.choose("twitchdata-update.xlsx"))
chat <- read.csv("healthygamer_gg_testdata.csv")

top_game <- game %>%
  filter(Year == "2021") %>%
  select(Year, Month, Game, Hours_watched) %>%
  group_by(Game) %>%
  summarize(Hours_watched = sum(Hours_watched)) %>%
  filter(Hours_watched == max(Hours_watched)) %>%
  pull(Game)

Most_streamer_game <- game %>%
  filter(Year == "2021") %>%
  select(Year, Month, Game, Streamers) %>%
  group_by(Game) %>%
  summarize(Streamers = sum(Streamers)) %>%
  filter(Streamers == max(Streamers)) %>%
  pull(Game)
