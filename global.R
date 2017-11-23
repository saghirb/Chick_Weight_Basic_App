# Load packages
library(tidyverse)
library(DT)
library(shiny)


## Convert ChickWeight data into a tibble with desirable properties
CW <- ChickWeight %>%
  as_tibble() %>%
  mutate(Chick = as.numeric(as.character(Chick))) %>% 
  mutate(Diet = paste("Diet", as.character(Diet))) %>%
  rename(Weight = weight) %>%
  select(Chick, Diet, Time, Weight) %>%
  arrange(Chick, Diet, Time)

## Range for the slider App
rWgt <- range(CW$Weight)

# Summary Statistics by Diet and Time
CW_sum_stats <- CW %>% 
  group_by(Diet, Time) %>%
  summarise(N = n(),
            Mean = mean(Weight),
            SD = sd(Weight),
            Min = min(Weight),
            Median = median(Weight),
            Max = max(Weight))

# Create HTML Version of ChickWeight help page
# From: https://stackoverflow.com/questions/8918753/r-help-page-as-object

getHTMLhelp <- function(...){
  thefile <- help(...)
  capture.output(
    tools:::Rd2HTML(utils:::.getHelpFile(thefile))
  )
}

helpCW <- getHTMLhelp(ChickWeight) %>% 
  paste(collapse = " ")

