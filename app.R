library(shiny)
library(dplyr)
library(tidyverse)
library(rsconnect)
library(plotly)

source("my_server.R")
source("my_ui.R")

shinyApp(ui = ui, server = server)