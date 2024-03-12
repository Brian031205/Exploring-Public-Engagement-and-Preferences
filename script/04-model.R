#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(tidyverse)




# Filter the data by application for, extract the rows that has "Traffic Calming" as its application and group by year
traffic_calming_data <- 
  summarized_poll_data[summarized_poll_data$application_for == "Traffic Calming", ] |> 
  group_by(open_date_year) |>
  summarise(across(c(ballots_in_favour, ballots_returned), sum))

# Create a new column to store the value of ballot in favour rate
traffic_calming_data$in_favour_rate <- round((traffic_calming_data$ballots_in_favour / traffic_calming_data$ballots_returned), 2)



# Create a line plot, x-axis is the date and the y-axis is the in favor rate
model_1 <- traffic_calming_data |>
  ggplot(aes(x = open_date_year, y = in_favour_rate)) +
  labs(x = "Year",
       y = "In favour rate",
       title = "Traffic calming ballot in favour rate from 2015 to 2023",
       caption = "Figure 4: Traffic calming ballot in favour rate from 2015 to 2023") +
  geom_point() + 
  theme_minimal()


# save model
saveRDS(
  model_1,
  file = "model/first_model.rds"
)

# Filter the data by application for, extract the rows that has "Traffic Calming" as its application and group by year
traffic_calming_data <- 
  summarized_poll_data[summarized_poll_data$application_for == "Traffic Calming", ] |> 
  group_by(open_date_year) |>
  summarise(across(c(ballots_in_favour, ballots_returned), sum))

# Create a new column to store the value of ballot in favour rate
traffic_calming_data$in_favour_rate <- round((traffic_calming_data$ballots_in_favour / traffic_calming_data$ballots_returned), 2)



# Create a line plot, x-axis is the date and the y-axis is the in favor rate
model_2 <- traffic_calming_data |>
  ggplot(aes(x = open_date_year, y = in_favour_rate)) +
  labs(x = "Year",
       y = "In favour rate",
       title = "Traffic calming ballot in favour rate from 2015 to 2023",
       caption = "Figure 4: Traffic calming ballot in favour rate from 2015 to 2023") +
  geom_point() + 
  geom_smooth(
    method = "lm",
    se = TRUE,
    linetype = "dashed",
    formula = "y ~ x"
  ) +
  theme_minimal()

# save model
saveRDS(
  model_2,
  file = "model/second_model.rds"
)


# Filter the data by application for, extract the rows that has "Traffic Calming" as its application and group by year
traffic_calming_data <- 
  summarized_poll_data[summarized_poll_data$application_for == "Traffic Calming", ] |> 
  group_by(open_date_year) |>
  summarise(across(c(ballots_returned, ballots_distributed), sum))

# Create a new column to store the value of ballot return rate
traffic_calming_data$return_rate <- round((traffic_calming_data$ballots_returned / traffic_calming_data$ballots_distributed), 2)



# Create a line plot, x-axis is the date and the y-axis is the return rate
model_3 <- traffic_calming_data |>
  ggplot(aes(x = open_date_year, y = return_rate)) +
  labs(x = "Year",
       y = "Ballot return rate",
       title = "Traffic calming ballot return rate from 2015 to 2023",
       caption = "Figure 4: Traffic calming ballot return rate from 2015 to 2023") +
  geom_point() + 
  geom_smooth(
    method = "lm",
    se = TRUE,
    linetype = "dashed",
    formula = "y ~ x"
  ) +
  theme_minimal()


# save model
saveRDS(
  model_3,
  file = "model/third_model.rds"
)