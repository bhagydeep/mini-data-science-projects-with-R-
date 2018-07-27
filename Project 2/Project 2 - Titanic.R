library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

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

# 1 - Check the structure of titanic
str(titanic3)

# 2 - Use ggplot() for the first instruction
ggplot(titanic3, aes(x = pclass, fill = sex)) +
  geom_bar(position = "dodge")

# 3 - Plot 2, add facet_grid() layer
ggplot(titanic3, aes(x = pclass, fill = sex)) +
  geom_bar(position = "dodge") +
  facet_grid(.~ survived)

# 4 - Define an object for position jitterdodge, to use below
posn.jd <- position_jitterdodge(0.5, 0, 0.6)

# 5 - Plot 3, but use the position object from instruction 4
ggplot(titanic3, aes(x = pclass, y = age, col = sex)) +
  geom_point(position = posn.jd, size = 3, alpha = 0.5) +
  facet_grid(.~ survived)
