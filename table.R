# count of cases
state_case <- table(Dt.Table$States, useNA = 'ifany')
State.Name <- names(state_case)
state_case <- matrix(state_case, ncol = 1, nrow = length(State.Name), dimnames = list(State.Name, 'Number_of_Cases'))
state_case <- data.frame('States' = rownames(state_case), state_case)

# case in Rain
Death_in_Rain <- Dt.Table %>% group_by(States) %>% filter(Weather == "Rain") %>% select(States) %>% count()
colnames(Death_in_Rain)[2] <- 'Number_of_Cases_in_Rainy_Day' 

Summary_Table <- left_join(state_case, Death_in_Rain, by = 'States')

# case in 2018
Case_in_2015 <- Dt.Table %>% group_by(States) %>% filter(YEAR == 2015) %>% select(States) %>% count()
colnames(Case_in_2015)[2] <- 'Number_of_Cases_in_2015' 

Summary_Table <- left_join(Summary_Table, Case_in_2015, by = 'States')

# case involved drunk driver
Case_involved_Drunk_Driver <- Dt.Table %>% group_by(States) %>% filter(DRUNK_DR != 0) %>% select(States) %>% count()
colnames(Case_involved_Drunk_Driver)[2] <- 'Number_of_Cases_involved_Drunk_Driver' 

Summary_Table <- left_join(Summary_Table, Case_involved_Drunk_Driver, by = 'States')

# Longest EMS arrival time
Longest_EMS_Arrival_Time <- Dt.Table %>% group_by(States) %>% summarise(EMS_Arrival_Time = max(EMS_Arrival_Time, na.rm = T))

Summary_Table <- left_join(Summary_Table, Longest_EMS_Arrival_Time, by = 'States')

Summary_Table

# write.csv(Dt.Table, 'Accident Dataset (Cleaned).csv')