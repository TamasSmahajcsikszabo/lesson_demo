library(TNG)
library(dplyr)
library(readr)
source("./getCharacterReference.R")

names <- readRDS("../data/character_names.RDS")

tng_dataset <- TNG::TNG
print(head(tng_dataset))

data_to_save <- tng_dataset %>%
    filter(type=='speech') %>%
    select(episode, act,scenenumber, characters, who, text, Episode) %>%
    rowwise() %>%
    mutate(referenced_characters = get_character_reference(text, names))

write_csv(tng_dataset %>% filter(Season == 3 ) %>% filter(!is.na(who) & who != "NA"), "../data/TNGAbbr.csv")
