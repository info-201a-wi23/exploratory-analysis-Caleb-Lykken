library(tidyverse)
library(plotly)
accident_data <- read.csv("Accident Dataset (Cleaned).csv")

deaths_people_weather <- ggplot(data = accident_data) + 
  geom_col(mapping = aes(x = Weather, y = FATALS)) 

ggplotly(deaths_people_weather)
