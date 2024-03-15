#### Preamble ####
# Purpose: Cleans the raw poll data
# Author: Bolin Shen
# Date: March 3 2024
# Contact: bolin.shen@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)

#### Read in raw data ####

# Read in the raw polls data. 
readr::read_csv("data/raw_poll_data.csv")

#### Basic cleaning - polls data ####
raw_poll_data <-
  read_csv(
    file = "data/raw_poll_data.csv",
    show_col_types = FALSE
  )

# creating a new column to reformat the open date to year only
data_year = as.Date(data$OPEN_DATE, format = "%Y-%m-%d")|> format("%Y")
cleaned_poll_data = raw_poll_data |> mutate(OPEN_DATE_YEAR = data_year)


# creating a new column to store the value of the number of ballots returned
cleaned_poll_data$ballots_returned <- cleaned_poll_data$BALLOTS_IN_FAVOUR + cleaned_poll_data$BALLOTS_OPPOSED


# organize name #
cleaned_poll_data <-
  clean_names(cleaned_poll_data)

head(cleaned_poll_data)



# select columns of interest #
cleaned_poll_data <-
  cleaned_poll_data |>
  select(
    application_for,
    open_date_year,
    response_rate_met,
    ballots_in_favour,
    ballots_opposed,
    ballots_returned,
    ballots_distributed,
    poll_result
  )

# Filter the data by response rate met
summarized_poll_data <- cleaned_poll_data[cleaned_poll_data$response_rate_met == "Yes", ]


summarized_poll_data <-
  summarized_poll_data |>
  select(
    open_date_year,
    application_for,
    ballots_in_favour,
    ballots_distributed,
    ballots_returned,
    poll_result
    
  )



# save cleaned polls data #
write_csv(
  x = cleaned_poll_data,
  file = "data/cleaned_poll_data.csv"
)

# save summarized polls data #
write_csv(
  x = summarized_poll_data,
  file = "data/summarized_poll_data.csv"
)

