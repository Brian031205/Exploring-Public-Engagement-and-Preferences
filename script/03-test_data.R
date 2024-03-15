#### Preamble ####
# Purpose: Test the cleaned dataset to verify that the data works as expected.
# Author: Bolin Shen
# Date: March 3 2024
# Contact: bolin.shen@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(here)

#### Read data ####
cleaned_poll_data = read_csv(
  file = here("data/cleaned_poll_data.csv"),
  show_col_types = FALSE
)

#### Start testing ####

# test there are 11 types of application in total
length(unique(cleaned_poll_data$application_for)) == 11

# test there are 2 answers for response_rate_met
length(unique(cleaned_poll_data$response_rate_met)) == 2

# test there are 3 types of poll result
length(unique(cleaned_poll_data$poll_result)) == 3

# test the variable type of ballots_distributed are numeric.

is.numeric(cleaned_poll_data$ballots_distributed) == TRUE

