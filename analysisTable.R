install.packages("readxl")
library("readxl")
library("stringr")
library(dplyr)
my_data <- read_excel(file.choose("twitchdata-update.xlsx"))

table <- matrix(c(6196161750,3246298,"English",6091677300,5310163,"English",
                  5644590915,1767635,"Portuguese",3970318140,1767635,"English",
                  3671000070,8938903,"English",3668799075,554201,"English",3360675195
                  ,4074287, "English",3301867485,508816,"English",2928356940,3530767,"English"),ncol=3,byrow=TRUE)
colnames(table) <- c("Watch Time","Followers", "Language")
rownames(table) <- c("xQcOW","summit1g","Gaules", "ESL_CSGO", "Tfue", "Asmongold", 
                     "NICKMERCS", "Fextralife", "loltyler1")

View(table)
