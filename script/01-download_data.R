#### Preamble ####
# Purpose: Download data of polls conducted by the city across Toronto from "https://open.toronto.ca/dataset/polls-conducted-by-the-city/"
# Author: Bolin Shen
# Date: 3 March 2024
# Contact: bolin.shen@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(tidyverse)

# get package
package <- show_package("7bce9bf4-be5c-4261-af01-abfbc3510309")
package

# get all resources for this package
resources <- list_package_resources("7bce9bf4-be5c-4261-af01-abfbc3510309")

# identify data resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the data
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data

# write data
write_csv(
  x = data,
  file = "data/raw_poll_data.csv"
)