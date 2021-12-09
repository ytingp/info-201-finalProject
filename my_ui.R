library(plotly)

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
  includeCSS("style.css"),
  h1("Introduction:"),
  tags$img(src = "picture.png",
      height = 100, width = 150, class= "center"),
  p("Twitch is a popular streaming platform that focus on broadcasting video 
    games and even e-sports competition. We will be answering the following 
    questions:"),
  
  ## Introduction Page RYAN to-do
  p(HTML("<strong>"),
    "1. What makes xQcOW the number 1 channel on Twitch?", 
    HTML("</strong><br>"), 
    "We will answer this question by looking at Streamer Graph."),
  p("This graph uses data collected by Kaggle user Ran.Kirsh. 
    They used sullygnome.com, a Twitch analytics and statistics site, 
    to gather their data."),

  p(HTML("<strong>"),
    "2. What do people like to watch on Twitch?", 
    HTML("</strong><br>"),  
    "We will answer this question by looking at the viewership graph."),
  p("This graph uses data collected by Kaggle user Aayush Mishra.
    They got their data from the website known as sullygnome.com. 
    The dataset is about the top 1000 streamers on Twitch over the past year."),

  p(HTML("<strong>"), 
    "3. How often do Twitch users send emotes in the chat?", 
    HTML("</strong><br>"),  
    "We will answer this question by looking at the chat graph."),
  p("This graph uses data collected by Kaggle user mowgli. 
    They collected their data from the Twitch API using the R package Rchamp. 
    (https://github.com/mowgl-i/Rchamp). 
    This dataset is a log of chat messages from the channel HealthyGamer_GG.
    HealthyGamer_GG often hosts streams aimed at improving mental health 
    in the gaming community."),
  )
)


## RYAN: put your graph output in graph_1_tab and customize it

graph_1_tab <- tabPanel(
  "Streamer Graph",
  h1("Twitch Streamers Dataset"),
  plotlyOutput(outputId = "scatterplot"),
  selectInput("x_var",
              label = "Select a statistic from xQcOW's stream",
              choices = c(
                "Watch time (Minutes)" = "Watch.time.Minutes.",
                "Stream time (Minutes)" = "Stream.time.minutes.",
                "Peak viewers" = "Peak.viewers",
                "Average viewers" = "Average.viewers",
                "Followers" = "Followers"
              )
  ),
  
  selectInput("y_var",
              label = "Select another statistic from xQcOW's stream",
              choices = c(
                "Watch time (Minutes)" = "Watch.time.Minutes.",
                "Stream time (Minutes)" = "Stream.time.minutes.",
                "Peak viewers" = "Peak.viewers",
                "Average viewers" = "Average.viewers",
                "Followers" = "Followers"
              )
  )
)

graph_2_tab <- tabPanel(
  "Viewership Graph",
  h1("Twitch Games Dataset"),
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
    plot_chat_plot
  ),
  h4("visual emote reference: "),
  splitLayout(
    img(src = "heart.png", height = 100, width = 150),
    img(src = "kekw.jpg", height = 100, width = 150),
    img(src = "lul.jpg", height = 100, width = 150),
    img(src = "Pogchamp.png", height = 100, width = 150),
    img(src = "sadge.png", height = 100, width = 150)
  ),
  splitLayout(
    p("heart"),
    p("kekw"),
    p("lul"),
    p("pog"),
    p("sadge"),
  ),
)

conclusion <- tabPanel(
  "Conclusion",
  fluidPage(
  h1("Major Takeaways:"),
  
  ## Ryan to-do
  p(HTML("<strong>"),
    "1. What makes xQcOW the number 1 channel on Twitch?", 
    HTML("</strong><br>"),  
    "We figured that it would be very helpful in answering this question if we 
    were able to compare summary statistics of the top streamer in the world 
    right now. In other words, we wanted to figure out which statistic of the 
    data is the reason why xQcOW is the top channel on Twitch. Through our
    findings, the total watch time in minutes is the difference maker while the
    follower count is not as impactful."),
  
  p(HTML("<strong>"),
    "2. What do people like to watch on Twitch?", 
    HTML("</strong><br>"), 
    "We noticed that in 2021, the 
    most populor category that was streamed was Just Chatting, which are 
    in-real-life streams where streamers are not playing video games. We also 
    noticed how even though even if a certain category is being streamed for
    more hours than others, it doesn't mean that it will get views. For example,
    even though Call of Duty: Warzone has around the same stream time Just
    Chatting, it only has about half of Just Chatting's hours watched every 
    month."),
  
  p(HTML("<strong>"),
    "3. How often do Twitch users send emotes in the chat?", 
    HTML("</strong><br>"),  
    "Twitch users often send similar emotes together in a short span of time.
    For example, near the beginning of the stream, many heart emotes were sent,
    while the other emotes were not used as much yet. 
    Surprisingly, heart was also the second most used emote after pog. 
    Together these findings suggest that Twitch communities can stand together
    to support the things they find important.")
  )
)


ui <- navbarPage(
  "Twitch Community",
  intro_tab,
  graph_1_tab,
  graph_2_tab,
  graph_3_tab,
  conclusion
)
