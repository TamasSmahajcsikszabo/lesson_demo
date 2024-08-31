#' Get name reference
#' @param name 'name' string that is looked up
#' @param text the string text the parameter name is looked up
#' @returns Boolean
get_reference <- function(name, text) {
    return(grepl(name, text, ignore.case = TRUE))
}

