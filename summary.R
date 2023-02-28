# Packages
library(dplyr)
library(tidyr)
library(ggplot2)

# Read dataset
Dt <- read.csv('accident.csv')
head(Dt)

# Factor for categorical variables
## STATE
States <- read.csv('States.csv')
Dt <- left_join(Dt, States, by = 'STATE')
## WEATHER
Weather <- read.csv('weather.csv')
Dt <- left_join(Dt, Weather, by = 'WEATHER1')

# Extract columns
Variable <- c('States', "DAY", "MONTH", 'YEAR', 'DAY_WEEK','LATITUDE','LONGITUD','Weather','ARR_HOUR','ARR_MIN','DRUNK_DR', "FATALS", "PERSONS")
Dt.Table <- Dt[, Variable]
head(Dt.Table)


# write_csv(Dt.Table, "Accident Dataset (Cleaned).csv")

## Number_of_Cases_Stratified_Weather
summary_info <- list()
summary_info$'Number_of_Cases_Stratified_Weather' <- Dt.Table %>% group_by(States) %>% select(States, Weather) %>% table()
Rain_Cases <- sum(summary_info$Number_of_Cases_Stratified_Weather[, 'Rain'])

## Rank_of_Cases
Rank_of_Cases <- Dt.Table %>% group_by(States) %>% select(States) %>% count()
Rank_of_Cases <- Rank_of_Cases[order(Rank_of_Cases$n, decreasing = T), ]
summary_info$'Rank_of_Cases' <- Rank_of_Cases
most_cases_state <- summary_info$Rank_of_Cases[1, 'States']

## Max cases of accidents
summary_info$'Number_of_Cases_in_Each_Week'<- Dt.Table %>% select(DAY_WEEK) %>% table()
Week_Case <- max(summary_info$Number_of_Cases_in_Each_Week)
Week_Case <- names(summary_info$'Number_of_Cases_in_Each_Week')[which(summary_info$'Number_of_Cases_in_Each_Week' == Week_Case)]
Week_Case
## Case involved drunk driver
summary_info$'Case_involved_Drunk_Driver' <- Dt.Table %>% group_by(States) %>% filter(DRUNK_DR != 0) %>% select(States) %>% count()
Case_involved_Drunk_Driver <- Dt.Table %>% group_by(States) %>% filter(DRUNK_DR != 0) %>% select(States) %>% count()

Drunk_Most_State <- summary_info$Case_involved_Drunk_Driver[which(summary_info$Case_involved_Drunk_Driver$n == max(summary_info$Case_involved_Drunk_Driver$n)), 'States']

## Average arrival time
Dt.Table$ARR_MIN <- ifelse(Dt.Table$ARR_MIN < 60, Dt.Table$ARR_MIN / 60 , NA)
Dt.Table$ARR_HOUR <- ifelse(Dt.Table$ARR_HOUR < 24, Dt.Table$ARR_HOUR, NA)
Dt.Table$'EMS_Arrival_Time' <- round(Dt.Table$ARR_HOUR + Dt.Table$ARR_MIN, 2)

Average_Arrival_Time_for_Each_State <- Dt.Table %>% select(States, EMS_Arrival_Time) %>% group_by(States) %>% summarise(Mean = round(mean(EMS_Arrival_Time, na.rm = T), 2))

summary_info$'Average_Arrival_Time_for_Each_State' <- Dt.Table %>% select(States, EMS_Arrival_Time) %>% group_by(States) %>% summarise(Mean = round(mean(EMS_Arrival_Time, na.rm = T), 2))

shortest_arrival_time <- min(summary_info$Average_Arrival_Time_for_Each_State$Mean, na.rm = T)
longest_arrival_time <- max(summary_info$Average_Arrival_Time_for_Each_State$Mean, na.rm = T)