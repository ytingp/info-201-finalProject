library(shiny)
library(dplyr)
library(rsconnect)

source("my_server.R")
source("my_ui.R")

shinyApp(ui = ui, server = server)