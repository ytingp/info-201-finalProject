library(ggplot2)
library(plotly)
library(stringr)
library(lubridate)
library(tidyverse)

# Load files
games <- read.csv("Twitch_game_data.csv")
# View(games)

chatb <- read.csv("healthygamer_gg_testdata.csv")

# Twitch Game Data Prep
top_5 <- games %>%
  filter(Rank <= 5)

names <- top_5 %>%
  select(Game) %>%
  unique()

select_data <- games %>%
  filter(grepl("^Just Chatting$|^League of Legends$|^Call of Duty: Warzone$|
               ^Grand Theft Auto V$|^Among Us$|
               ^Counter Strike: Global Offensive$|^Dota 2$|^Hearthstone$|
               ^Minecraft$|^Rust$", Game)) %>%
  filter(Year == "2021") %>%
  mutate(Hours_Streamed = as.numeric(sub(" .*", "", Hours_Streamed)))


#---Twitch Chat Data Prep
# ignore empty messages
clean_chatb <- chatb %>%
  filter(message != "")

# prepare slider
start_time <- as.POSIXct(clean_chatb$timestamp[1])#, format = "%H:%M:%S")
end_time <- as.POSIXct(clean_chatb$timestamp[7647])#, format = "%H:%M:%S")
seconds_v <- as.POSIXct(clean_chatb$timestamp[1:7647])#, format = "%H:%M:%S")

# length of chat log in seconds 
vod_length <- paste0("", difftime(end_time, start_time, units="secs"))

# make a seconds column for our slider
clean_chatb <- clean_chatb %>%
  mutate(
    seconds = as.numeric(
      paste0("", difftime(seconds_v, start_time, units="secs"))
    )
  ) %>%
  select(user, message, timestamp, seconds) 
#---


# Server Functions
server <- function(input, output) {
  output$plot <- renderPlotly({
    my_graph <- ggplot(data = select_data) +
      geom_line(mapping = aes(x = Month, y = !!as.name(input$y_axis_input),
                              color = Game)) + 
      labs(x = "Year", y = str_replace_all(input$y_axis_input, "_", " "),
           title = "Trends of Viewship in 2021") +
      scale_x_discrete(name = "Month", 
                       limits = c("0", "1", "2", "3", "4", "5", "6", "7", "8", 
                                  "9"))
    my_ploty_plot <- ggplotly(my_graph)
    return(my_ploty_plot)
  })

  # Functions for Twitch Chat Bar Chart
  output$timestring <- renderText ({
    ets <- seconds_to_period(input$seconds) # end timestring
    etso <- sprintf('%02d:%02d:%02d', ets@hour, minute(ets), second(ets))
    return(
      paste("You selected: time from", etso[1], "to", etso[2])
    )
  })
  
  output$barchat <- renderPlotly({
    barchat_title <- "Popular Emotes over Time: "
    
    # input$seconds (warning?)
    filtered_chat <- clean_chatb %>%
      filter(seconds >= input$seconds) %>%
      filter(seconds <= input$seconds)
    
    chat_choice <- filtered_chat
    
    # top 10 emotes (picked by me)
    emote_sums <- filtered_chat %>%
      summarize(
        pog = 
          nrow(filter(chat_choice, grepl("pog|Pog|POG|poG", message) == TRUE)),
        lul = 
          nrow(filter(chat_choice, grepl("LUL", message) == TRUE)),
        heart = 
          nrow(filter(chat_choice, grepl("<3", message) == TRUE)),
        sadge = 
          nrow(filter(chat_choice, grepl("Sadge", message) == TRUE)),
        kekw = 
          nrow(filter(chat_choice, grepl("KEKW", message) == TRUE)),
        monka = 
          nrow(filter(chat_choice, grepl("monka", message) == TRUE)),
        feels_strong_man = 
          nrow(filter(chat_choice, grepl("FeelsStrongMan", message) == TRUE)),
        four_five_head = 
          nrow(filter(chat_choice, grepl("Head", message) == TRUE)),
        pepe_laugh = 
          nrow(filter(chat_choice, grepl("PepeLaugh", message) == TRUE)),
        bible_thump = 
          nrow(filter(chat_choice, grepl("BibleThump", message) == TRUE))
      )
    
    # arrange dataframes nicely for ggplot
    top_10_emote_data <- gather(emote_sums, "emote", "messages")
    
    top_5_emote_data <- head(top_10_emote_data, 5)
    
    chat_plot <- ggplot(data = top_5_emote_data) +
      geom_col(mapping = aes(x = emote, y = messages, fill = emote)) +
      theme_dark() +
      ggtitle(barchat_title) +
      scale_fill_manual(values = c(
        "heart" = "#c48ee0", 
        "kekw" = "#d98768", 
        "lul" = "#fce5cd", 
        "pog" = "#f1c232", 
        "sadge" = "#a8e6ae"
      )) 

    chat_plotly <- ggplotly(chat_plot)
    return(chat_plotly)
  })
}
