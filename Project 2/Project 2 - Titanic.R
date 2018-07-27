library(readr)
library(dplyr)
library(tidyr)

titanic_orginal <- read.csv("titanic3.csv")
titanic_orginal
summary (titanic_orginal)

#
titanic_orginal <-
  titanic_orginal %>%
  mutate (embarked = replace(embarked, is.na(embarked), "S"))

#
titanic_orginal <-
  titanic_orginal %>%
  mutate (age = replace(age, is.na(age), mean (as.numeric(age), na.rm = TRUE)))

#
titanic_orginal <-
  titanic_orginal %>%
  mutate (boat = replace(boat, is.na(boat), "None"))

#
titanic_orginal <-
  titanic_orginal %>%
  mutate(has_cabin_number = ifelse(!is.na(cabin), 1, 0 ))

select(titanic_orginal, has_cabin_number)

#
write_csv(titanic_orginal, "Final Output - Titanic.csv")

