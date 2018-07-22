library(dplyr)
library(tidyr)
library(readr)

refine <- read_csv("refine_original.csv")

summary(refine)
str(refine)
select(refine, company)

# Clean up the 'company' column and transform the values in the column to be: philips, akzo, van houten and unilever (all lowercase).
clean_company <- 
  refine %>% 
  mutate(company = tolower(company)) %>% 
  mutate(company = sub("phillips|phllips|phillps|fillips|phlips", "philips", x=company)) %>%
  mutate(company = sub("akz0|ak zo", "akzo", x=company)) %>%
  mutate(company = sub("van.*", "van houten", x=company)) %>%
  mutate(company = sub("unilver", "unilever", x=company))

#
clean_company <- 
  clean_company %>%
  separate ('Product code / number', c("product_code", "product_number"), sep = "-")
  

#
clean_company <-
  clean_company %>%
  mutate(product_category = case_when (
  product_code == "p" ~ "Smartphone",
  product_code == "v" ~ "Tv",
  product_code == "x" ~ "Laptop",
  product_code == "q" ~ "Tablet"))

#


clean_company 

