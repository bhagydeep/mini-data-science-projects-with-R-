library(dplyr)
summary(refine)
str(refine)
select(refine, company)
select(refine, company(starts_with("philp")))

clean_company <- refine %>% mutate(company = tolower(company)) %>% 
  mutate(company = gsub("phillips|phllips|phillps|fillips|phlips", "philips", x=company)) %>%
  mutate(company = gsub("akz0|ak zo", "akzo", x=company)) %>% 
  mutate(company = gsub("unilver", "unilever", x=company))
clean_company 

