library(dplyr)

game <- read.csv("Twitch_game_data.csv")
# my_data <- read_excel(file.choose("twitchdata-update.xlsx"))
my_data <- read.csv("twitchdata-update.csv")
chat <- read.csv("healthygamer_gg_testdata.csv")

# 1
top_game <- game %>%
  filter(Year == "2021") %>%
  select(Year, Month, Game, Hours_watched) %>%
  group_by(Game) %>%
  summarize(Hours_watched = sum(Hours_watched)) %>%
  filter(Hours_watched == max(Hours_watched)) %>%
  pull(Game)

# 2
Most_streamer_game <- game %>%
  filter(Year == "2021") %>%
  select(Year, Month, Game, Streamers) %>%
  group_by(Game) %>%
  summarize(Streamers = sum(Streamers)) %>%
  filter(Streamers == max(Streamers)) %>%
  pull(Game)

# 3
Most_popular_streamer <- my_data %>%
  filter(Watch.time.Minutes. == max(Watch.time.Minutes.)) %>%
  pull(Channel)

# What percent of Twitch chat messages in contain emotes?
# see `percent_emotes`

# What is the emote message per minute rate?
# see `emote_rate`

clean_chat <- chat %>%
  filter(message != "") %>%
  select(user, message, timestamp)

total_messages <- nrow(chat)

emote_sums <- clean_chat %>%
  summarize(
    pog = 
      nrow(filter(clean_chat, grepl("pog|Pog|POG|poG", message) == TRUE)),
    lul = nrow(filter(clean_chat, grepl("LUL", message) == TRUE)),
    heart = nrow(filter(clean_chat, grepl("<3", message) == TRUE)),
    sadge = nrow(filter(clean_chat, grepl("Sadge", message) == TRUE)),
    kekw = nrow(filter(clean_chat, grepl("KEKW", message) == TRUE)),
    monka = nrow(filter(clean_chat, grepl("monka", message) == TRUE)),
    feels_strong_man = 
      nrow(filter(clean_chat, grepl("FeelsStrongMan", message) == TRUE)),
    four_five_head = nrow(filter(clean_chat, grepl("Head", message) == TRUE)),
    pepe_laugh = 
      nrow(filter(clean_chat, grepl("PepeLaugh", message) == TRUE)),
    bible_thump = 
      nrow(filter(clean_chat, grepl("BibleThump", message) == TRUE))
  )

total_emotes_sample <- sum(emote_sums)

# 4
percent_emotes <- signif(total_emotes_sample / total_messages, digits = 3) * 100
# at least 40.3% of the chat messages contain an emote
# (based on 10 popular emotes alone)

time_elapsed <- 
  length(integer(toString(
    round(
      difftime(max(chat$timestamp), min(chat$timestamp), unit = "mins"))
  )))

# 5
emote_rate <- round(total_emotes_sample / time_elapsed)
# at least 30 emote messages per minute, or 1 emote message every 2 seconds 