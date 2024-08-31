library(TNG)
library(dplyr)
library(stringr)


characters <- TNG::TNG %>% filter(!is.na(who)) %>%  select(who) %>% unlist() %>% unname() %>% unique()
characters_present  <- paste((TNG::TNG %>% filter(!is.na(characters)) %>% select(characters)), collapse = "")
characters_present_vector <- strsplit(characters_present, ",") %>% unlist() %>% unique()
pattern  <- '\\"'
replaceSTR <- function(name, pattern){stringr::str_replace(name, pattern, "")}
characters_present_vector <- lapply(characters_present_vector, replaceSTR, pattern=pattern) %>% unlist()
characters_present_vector <- lapply(characters_present_vector, replaceSTR, pattern='c\\(') %>% unlist()
characters_present_vector <- lapply(characters_present_vector, replaceSTR, pattern='   *.') %>% unlist()

character_names <- c(characters, characters_present_vector) %>% unique()
saveRDS(character_names, "../../data/character_names.RDS")

