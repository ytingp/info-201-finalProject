# Aaron Thai
# What games were popular in 2021?

library(tidyverse)
games <- read.csv("Twitch_game_data.csv")

games_2021 <- games %>%
  filter(Year == 2021) %>%
  select(Game, Month, Hours_watched)

# how do we put these into one dataframe?
just_chat_2021 <- games_2021 %>%
  filter(Game == "Just Chatting") 
  
lol_2021 <- games_2021 %>%
  filter(Game == "League of Legends")

cod_2021 <- games_2021 %>%
  filter(Game == "Call of Duty: Warzone")

gta5_2021 <- games_2021 %>%
  filter(Game == "Grand Theft Auto V")

amogus_2021 <- games_2021 %>%
  filter(Game == "Among Us")

games_watch <- just_chat_2021 %>%
  select(Month)

games_watch <- games_watch %>%
  mutate(
    just_chat_hw = just_chat_2021$Hours_watched,
    lol_hw = lol_2021$Hours_watched,
    cod_hw = cod_2021$Hours_watched,
    gta5_hw = gta5_2021$Hours_watched,
    amogus_hw = amogus_2021$Hours_watched
  )

# Hours Watched vs Month for Just Chatting, etc.
games_plot <- 
  ggplot(data = games_watch) +
  geom_path(mapping = aes(x = Month, y = just_chat_hw, color = "grey0")) +
  geom_path(mapping = aes(x = Month, y = lol_hw, color = "steelblue")) +
  geom_path(mapping = aes(x = Month, y = cod_hw, color = "darkorange2")) +
  geom_path(mapping = aes(x = Month, y = gta5_hw, color = "green4")) +
  geom_path(mapping = aes(x = Month, y = amogus_hw, color = "darkred")) +
  scale_color_manual(name = "Game", 
                     values = c("darkorange2", "darkred", 
                                "green4", "grey0", "steelblue"),
                     labels = c("Call of Duty", "Among Us", 
                                "GTA 5", "Just Chatting", "League of Legends"))+
  scale_x_continuous(breaks = seq(1, 10, 1),
                   labels = seq(1, 10, 1)) +
  labs(x = "Month", y = "Total Hours Watched", 
       title = "Popular Twitch Games in 2021")
