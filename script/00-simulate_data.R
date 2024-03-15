#### Preamble ####
# Purpose: Simulate the scenario: Support for a political party is a binary (yes/no), and is related to age-group, gender, income group, and highest education.
# Author: Bolin Shen
# Date: March 3 2024


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(modelsummary)
library(ggplot2)
library(knitr)

## Creating simulated data

# Set seed for reproducibility
set.seed(42)

# Sample number
n = 1000

# Simulate data, predictors associated are age group, gender, income group and education.
simulate = tibble(
  voted_for = sample(c("Yes", "No"), n, replace = TRUE),
  is_support = if_else(voted_for == "Yes", 1, 0),
  age_group = sample(c("18-24", "25-34", "35-44", "45-54", "55+"), n, replace = TRUE),
  gender = sample(c("Male", "Female"), n, replace = TRUE),
  income_group = sample(c("Low", "Medium", "High"), n, replace = TRUE),
  education = sample(c("High School", "Bachelor's Degree", "Master's Degree", "Some colledge"), n, replace = TRUE)
)



# Test 1: test class
is.character(simulate$age_group) == TRUE

# Test 2: test class
is.character(simulate$gender) == TRUE

# Test 3: test class 
is.character(simulate$income_group) == TRUE

# Test 4: test class 
is.character(simulate$education) == TRUE

# Test 5: test there are 1000 observations.
nrow(simulate) == 1000

# Test 6: test class

is.character(simulate$age_group) & is.character(simulate$gender)  == TRUE

# Test 7: test class

is.character(simulate$age_group) & is.character(simulate$education) == TRUE

# Test 8: test class
is.character(simulate$age_group) & is.character(simulate$income_group) == TRUE

# Test 9: test class
is.numeric(simulate$is_support) == TRUE

# Test 10: test class
is.character(simulate$voted_for) == TRUE


# Build the graph

sim_population <-
  tibble(
    edu = rbinom(n, size = 5, prob = 0.2),
    gender = rbinom(n, size = 1, prob = 0.5),
    probability = (edu + gender + 0.1) / 6.2, # prevent certainty
    is_support = rbinom(n, 1, prob = probability)
  ) 

sim_population


sample <- 
  sim_population |> 
  slice_sample(n = n, weight_by = probability)

sample <-
  sample |>
  mutate(
    is_support = if_else(is_support == 1, "Yes", "No"),
    is_support = as_factor(is_support),
    gender = if_else(gender == 1, "Male", "Female"),
  )


# Bar Plot
sample |>
  ggplot(aes(x = edu, fill = as_factor(is_support))) +
  stat_count(position = "dodge") +
  facet_wrap(facets = vars(gender)) +
  theme_minimal() +
  labs(
    x = "Highest education",
    y = "Number of respondents",
    fill = "Is support"
  ) +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  theme(legend.position = "bottom")

# Build the model
political_preferences <-
  stan_glm(
    is_support ~ gender + education + income_group + age_group,
    data = simulate,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 42
  )




modelsummary(political_preferences)

# plot model

modelplot(political_preferences, conf_level = 0.9) +
  labs(x = "90 per cent credibility interval")


summary(political_preferences)