library(readr)
library(dplyr)
library(tidyr)

titanic_orginal <- read_csv("Project 2/titanic3.csv")
titanic_orginal
summary (titanic_orginal)

# Port of embarkation - replace missing values in column embarked with "S"
titanic_orginal <-
  titanic_orginal %>%
  mutate (embarked = replace(embarked, is.na(embarked), "S"))
View(titanic_orginal)

# Calculate the mean of the Age column and use that value to populate the missing values  
titanic_orginal <-
  titanic_orginal %>%
  mutate (age = replace(age, is.na(age), mean (as.numeric(age), na.rm = TRUE)))
View(titanic_orginal)

# Replacing empty slots of Lifeboat column with a dummy value e.g. the string 'None' or 'NA'
titanic_orginal <-
  titanic_orginal %>%
  mutate (boat = replace(boat, is.na(boat), "None"))
View(titanic_orginal)

# Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
titanic_orginal <-
  titanic_orginal %>%
  mutate(has_cabin_number = ifelse(!is.na(cabin), 1, 0 ))

View(titanic_orginal)

# Loading Final Output to Output_titanic
write_csv(titanic_orginal, "Project 2/Output_titanic.csv")

