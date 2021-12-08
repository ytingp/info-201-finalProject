library(ggplot2)
library(plotly)
library(stringr)

games <- read.csv("Twitch_game_data.csv")
View(games)

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
  mutate(Hours_Streamed = sub(" .*", "", Hours_Streamed)) 

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
}
