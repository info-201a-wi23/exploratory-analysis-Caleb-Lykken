library(tidyverse)
library(plotly)
ac_data <- read.csv("accident.csv")

deaths_persons_correlation <- ggplot(ac_data, aes(PERSONS, FATALS)) + geom_point()

ggplotly(deaths_persons_correlation)
