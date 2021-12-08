library(plotly)

intro_tab <- tabPanel(
  "Introduction",
  img(src = "picture.png",
      height = 100, width = 150),
  p("todo: 3 question")
)

graph_1_tab <- tabPanel(
  "Graph 1"
)

graph_2_tab <- tabPanel(
  "Graph 2",
  plotlyOutput(outputId = "plot"),
  selectInput(
    inputId = "y_axis_input",
    label = "Y axis",
    choices = list("Hours Watched" = "Hours_watched",
                   "Peak Viewers" = "Peak_viewers"),
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
  "Conclusion: 3 Major Takeaways"
)

ui <- navbarPage(
  "Climate Change",
  intro_tab,
  graph_1_tab,
  graph_2_tab,
  graph_3_tab,
  conclusion
)
