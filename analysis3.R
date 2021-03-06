# library("readxl")
library(ggplot2)
library("stringr")
library(dplyr)
my_data <- read.csv("twitchdata-update.csv")

scatter <- ggplot(my_data) +
  geom_point(mapping = aes(
    x = Watch.time.Minutes., y = Followers, color = Watch.time.Minutes.)) +
  scale_color_continuous("Watch Time") +
  labs(x = "Watch Time", y = "Followers") +
  ggtitle("Watch Time Compared with Followers for Each Channel")
