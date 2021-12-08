library(plotly)

intro_tab <- tabPanel(
  "Introduction",
  img(src = "picture.png",
      height = 100, width = 150),
  p("Twitch is a popular streaming platform that focus on broadcasting video 
    games and even e-sports competition. We will be answering the following 
    questions:"),
##  p("1. ryan to-do"),
  p("2. What do people like to watch on Twitch? We will answer this
    question by looking at the viewership graph."),
  p("3. How often do Twitch users send emotes in the chat? We will answer
          this question by looking at the chat graph.")
)


## RYAN: put your graph output in graph_1_tab and customize it
graph_1_tab <- tabPanel(
  "Graph 1"
)

graph_2_tab <- tabPanel(
  "Viewership Graph",
  plotlyOutput(outputId = "plot"),
  selectInput(
    inputId = "y_axis_input",
    label = "Y axis",
    choices = list("Hours Watched" = "Hours_watched",
                   "Peak Viewers" = "Peak_viewers",
                   "Hours Streamed" = "Hours_Streamed",
                   "Average Viewer" = "Avg_viewers"
                   ),
    selected = "Hours_watched"
  )
)

# Input for Twitch Bar Chart
# Create a variable `seconds input` that allows seconds 0-6188
seconds_input <- sliderInput(
  inputId = "seconds",
  label = "Seconds elapsed in stream", min = 0, max = 6188, value = c(0,6188)
)

# Panel for Chat Chart tab
plot_chat_plot <- mainPanel(
  plotlyOutput(outputId = "barchat"),
  seconds_input,
  textOutput(outputId = "timestring"),
  p(),
  p("How often do Twitch users send emotes in the chat?"),
  p("Using the slider, we can see down to the second 
  when users are sending messages that include 5 popular emotes."),
)

# Tab for Chat Chart
graph_3_tab <- tabPanel(
  "Chat Chart",
  h1("Twitch Chat Dataset"),
  verticalLayout(
    plot_chat_plot,
  )
)

conclusion <- tabPanel(
  "Conclusion:"
  p("Major Takeaways:"),
  ##  p("1. ryan to-do"),
  p("2. What do people like to watch on Twitch? We noticed that in 2021, the 
    most populor category that was streamed was Just Chatting, which are 
    in-real-life streams where streamers are not playing video games. We also 
    noticed how even though even if a certain category is being streamed for
    more hours than others, it doesn't mean that it will get views. For example,
    even though Call of Duty: Warzone has around the same stream time Just
    Chatting, it only has about half of Just Chatting's hours watched every 
    month."),
  p("3. How often do Twitch users send emotes in the chat? We will answer
          this question by looking at the chat graph.")
)
)

ui <- navbarPage(
  "Climate Change",
  intro_tab,
  graph_1_tab,
  graph_2_tab,
  graph_3_tab,
  conclusion
)
