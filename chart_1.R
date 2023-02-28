library(ggplot2)
accident_data <- read.csv("Accident Dataset (Cleaned).csv")

deaths_people_weather <- ggplot(data = accident_data) + 
  geom_bar(aes(x = Weather, y = FATALS), stat = 'identity') + 
  labs(title = 'Frequency of Fatal Accidents in Different Weathers') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

deaths_people_weather
