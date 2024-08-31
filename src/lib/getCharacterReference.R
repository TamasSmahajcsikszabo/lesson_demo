source("./getReference.R")
get_character_reference <- function(text, names) {
    resultVector <- unlist(lapply(names, get_reference, text=text))
    return(resultVector)
    

}


