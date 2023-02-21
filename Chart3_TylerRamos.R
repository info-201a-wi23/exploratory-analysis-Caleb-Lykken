library(ggplot2)
library(tidyverse)

ac_data <- read.csv("accident.csv")
#loading GSA_codes
gsa_codes <- read.csv("FRPP_GLC_-_United_States_fEB_16_20233.csv")

ac_data <- ac_data %>% mutate(States = states[STATE])
# Adding new column for all of the state names.
states <- c('Alabama','Alaska','Arizona','Arkansas', 
            'California','Colorado','Connecticut', 'Delaware', 
            'District of Columbia','Florida','Georgia','Hawaii', 
            'Idaho','Illinois','Indiana','Iowa','Kansas', 
            'Kentucky', 'Louisiana','Maine', 'Maryland', 
            'Massachusetts','Michigan', 'Minnesota', 
            'Mississippi','Missouri','Montana','Nebraska', 
            'Nevada','New Hampshire','New Jersey','New Mexico', 
            'New York','North Carolina','North Dakota','Ohio', 
            'Oklahoma', 'Oregon','Pennsylvania','Puerto Rico', 
            'Rhode Island', 'South Carolina','South Dakota','Tennessee', 
            'Texas','Utah','Vermont','Virginia','Virgin Islands', 
            'Washington','West Virginia','Wisconsin','Wyoming')
ac_data <- ac_data %>% mutate(States = states[STATE])

#creating a data frame with all of the county codes
county_codes <- gsa_codes %>% select( County.Code , County.Name )

ac_data <- ac_data %>% left_join(county_codes, by = c)
# data frame with states and total persons in accidents
states_and_persons <- ac_data %>% group_by(States) %>% summarize(sum = sum(PERSONS))
states_and_persons_clean <- na.omit(states_and_persons)

ggplot(data = states_and_persons_clean, aes(y = States, x = sum)) +
  geom_bar(stat="identity",width= 0.5, fill="steelblue") +
  theme_minimal()

