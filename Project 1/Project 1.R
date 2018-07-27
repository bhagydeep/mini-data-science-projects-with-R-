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
  mutate(company = 
           sub("phillips|phllips|phillps|fillips|phlips", "philips", x=company)) %>%
  mutate(company = sub("akz0|ak zo", "akzo", x=company)) %>%
  mutate(company = sub("van.*", "van houten", x=company)) %>%
  mutate(company = sub("unilver", "unilever", x=company))

# Seprate product code and product number 
clean_company <- 
  clean_company %>%
  separate ('Product code / number', c("product_code", "product_number"), sep = "-")
  
# adding product category
clean_company <-
  clean_company %>%
  mutate(product_category = case_when (
  product_code == "p" ~ "Smartphone",
  product_code == "v" ~ "Tv",
  product_code == "x" ~ "Laptop",
  product_code == "q" ~ "Tablet"))

# Full address grocoding
clean_company <- 
  clean_company %>% 
  unite("full_address", address, city,country, sep = ",", remove = FALSE) 

# dummy varibles for company category and product category
clean_company <- 
  clean_company %>% 
  mutate(company_philips = ifelse(company %in% "philips", yes = 1, no = 0),
        company_akzo = ifelse(company %in% "akzo", yes = 1, no = 0),
        company_van_houten = ifelse(company %in% "van houten", yes = 1, no = 0),
        company_unilever = ifelse(company %in% "unilever", yes = 1, no = 0),
        product_smartphone = ifelse(product_category %in% "Smartphone", yes = 1, no = 0),
        product_tv = ifelse(product_category %in% "Tv", yes = 1, no = 0),
        product_laptop = ifelse(product_category %in% "Laptop", yes = 1, no = 0),
        product_tablet = ifelse(product_category %in% "Tablet", yes = 1, no = 0)) 

str (clean_company)

write.csv(clean_company, "refine_original.csv")
