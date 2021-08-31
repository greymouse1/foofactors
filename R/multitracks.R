#' Constructor for an object of a class \code{multitracks}
#'
#' @param lineobject Object of a class \code{mytrack}
#'
#' @return Object of a class \code{multitracks} which holds multiple \code{mytrack} objects
#' @export
#'
#' @examples
#' \dontrun{
#' my_tracks <- multitracks(line1)
#' }
multitracks <- function(lineobject) {
  my_dictionary <- hash::hash()
  my_dictionary[[lineobject$my_name]] <- lineobject
  value <- list(lines = my_dictionary)
  attr(value, "class") <- "multitracks"
  value

}

#' Generic function for adding new track of class \code{mytrack} to object of class
#' \code{multitracks}
#'
#' @param existing_list This is object of a class \code{multitracks} which holds
#' multiple lines or only one line so far
#' @param new_line object of a class \code{mytrack} which we wish to add
#'
#' @return Does not return new object, instead it adds new_line to existing_list
#' @export
addlist <- function(existing_list,new_line) {
  UseMethod("addlist")
}

#' \code{print} method for class \code{multitracks}
#'
#' @param x object of class \code{multitracks}
#' @param ... further arguments passed to or from other methods.
#'
#' @return prints a list of all tracks in the container
#' @export
#'
#' @examples
#' \dontrun{
#' print(my_tracks)
#' }
print.multitracks <- function(x, ...) {
  cat("Your object contains the following tracks: ", "\n")
  for (key in hash::keys(x$lines)){
    cat(key, "\n" )
  }
}

#' \code{summary} method for class \code{multitracks}
#'
#' @param object object of class \code{multitracks}
#' @param ... further arguments passed to or from other methods.
#'
#' @return gives summary of all tracks in the container
#' @export
#'
#' @examples
#' \dontrun{
#' summary(my_tracks)
#' }
summary.multitracks <- function(object, ...) {
  cat("Your object holds ", length(hash::keys(object$lines)), "tracks", "\n")
  for (key in hash::keys(object$lines)){
    current_distance <- distance(object$lines[[key]],TRUE)
    cat("Track ", key, " holds ", nrow(object$lines[[key]]$my_coords), "points and has
length of ", current_distance , "meters", "\n" )
  }
}

#' Addlist method for adding new track to \code{multitracks} object
#'
#' @param existing_list This is object of a class \code{multitracks} which holds
#' multiple lines or only one line so far
#' @param new_line object of a class \code{multitracks} which we wish to add
#'
#' @return Does not return new object, instead it adds new_line to existing_list
#' @export
#'
#' @examples
#' \dontrun{
#' addlist(my_tracks,line2)
#' }
addlist.multitracks <- function(existing_list,new_line) {
  existing_list$lines[[new_line$my_name]] <- new_line
}
