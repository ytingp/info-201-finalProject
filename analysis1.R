# Aaron Thai
# Chart for Twitch Chat Dataset

# from https://www.kaggle.com/mowglii/twitch-chat-test-data 
# vod is gone? seems to be a chatting stream and viewer interview
# see time 15:35:32

# load libraries and data
library(tidyverse)
library(scales)
chat <- read.csv("healthygamer_gg_testdata.csv")

# notice! some messages beginning with : like :D are broken
# they appear in the channel column instead of the message column,
# leaving the message column empty. let's clean it

clean_chat <- chat %>%
  filter(message != "") %>%
  select(user, message, timestamp)

# regex attempt to find trends
# because of how similar emotes can be to normal internet speech,
# it is difficult to accurately dinstinguish them by text alone

emotes_only <- clean_chat %>% 
  filter(grepl("([a-z]+[A-Z]+.|[A-Z]+[a-z]+.|[A-Z]+[A-Z])", message) == TRUE)

# ~1000 values (cases like monkaW, lowercase then uppercase)
pattern1 <- clean_chat %>% 
  filter(grepl("[a-z]+[A-Z]+.", message) == TRUE)

# ~3000 values (cases like Sadge, uppercase then lowercase)
pattern2 <- clean_chat %>% 
  filter(grepl("[A-Z]+[a-z]+.", message) == TRUE)

# ~2500 values (cases like KEKW, contains all caps)
pattern3 <- clean_chat %>% 
  filter(grepl("[A-Z]+[A-Z]", message) == TRUE)

# how many times do they say these emotes? top 10 emotes?
# (how many messages are these with these emotes?)
# resort to guess and check since emote ids were not given in this dataset
# (picked 10 that seemed common as i manually went through the data)

# top 10 emotes (picked by me)
# sum of these alone is ~3000
# (about 40% of the messages)
# manually sorted by number most to least? 
# (use arrange(emote_sums, desc(messages)))
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

# arrange dataframes nicely for ggplot
emote_sums_tall <- gather(emote_sums, "emote", "messages")

top_5_data <- head(emote_sums_tall, 5)
# top_5_data <- top_5_data[order(top_5_data$emote),]
# sorted alphabetically for pie chart

# methodology notice:
# variables pog, lul, monka, and four_five_head 
# are all aggregates of closely related emotes
# - pog includes: Pog, POG, PogChamp, , pepoG, POGGERS, etc.
# - lul includes: LUL, LULW, OMEGALUL, etc.
# - monka includes: monkaW, monkaS, monkaHmm, etc.
# - four_five_head includes: 4Head, 5Head

# present as Bar Chart, Table, Pie Chart (if bar is taken)

bar_plot <- ggplot(data = top_5_data) +
  geom_col(mapping = aes(x = emote, y = messages))

pie_chart <-ggplot(top_5_data, 
                   aes(x = "", y = messages, fill = emote)) +
            geom_bar(stat = "identity", width = 1, color = "white") +
            coord_polar("y", start = 0) + 
            theme_void() +
            scale_fill_manual(values = 
              c("#c48ee0", "#d98768", "#fce5cd", "#f1c232", "#5d8254")) + 
            ggtitle("Emote Popularity in Sample Chat") +
            geom_text(
              aes(y = messages/2 + c(0, cumsum(messages)[-length(messages)]), 
                label = c(421, 521, 482, 360, 469)))
                  # percent(c(421, 469, 360, 482, 521) / total_emotes_sample)))

  



