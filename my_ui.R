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

graph_3_tab <- tabPanel(
  "Graph 3"
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
