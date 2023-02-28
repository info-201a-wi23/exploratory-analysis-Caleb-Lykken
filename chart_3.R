library(ggplot2)
ac_data <- read.csv("Accident Dataset (Cleaned).csv")
ggplot(data = ac_data) + geom_boxplot(aes(x = Weather, y = EMS_Arrival_Time)) + 
  labs(y = 'EMS Arrival Time (hours)', title = 'Boxplot of EMS Arrival Time in Different Weather') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))