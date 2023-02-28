ac_data <- read.csv("Accident Dataset (Cleaned).csv")

Dt.LinePlot <- ac_data %>% group_by(MONTH) %>% select(States) %>% count()
Accident_Trend_Month <- ggplot(data = Dt.LinePlot) + 
  geom_line(aes(x = MONTH, y = n)) + 
  scale_x_continuous(breaks = 1:12) + 
  labs(x = 'Month', y = 'No. of Accidents', title = 'Frequency of Accidents in Different Months') + 
  theme_bw()
Accident_Trend_Month