#' Constructor for object of a type \code{mytrack}
#'
#' @param name Name of the track
#' @param time Timestamps for points
#' @param crs CRS code
#' @param coordinates LON-LAT coordinates
#'
#' @return Object of a class \code{mytrack}
#' @export
#'
#' @examples
#' \dontrun{
#' obj1 <- storetracks("Track1", my_timestamps, 4326, my_coordinates)
#' }
storetracks <- function(name,time,crs,coordinates) {
  value <- list(my_name = name, my_time = time, my_crs = crs, my_coords=coordinates)
  attr(value, "class") <- "mytrack"
  value
}


#' \code{\link{print}} method for class \code{mytrack}
#'
#' @param x object of a class \code{mytrack}
#' @param ... further arguments passed to or from other methods.
#'
#' @return Prints elements of object of a class \code{mytrack}
#' @export
#'
#' @examples
#' \dontrun{
#' print(obj1)}
print.mytrack <- function(x, ...) {
  cat("Name of this object is",x$my_name, "\n")
  cat("Timestamps are ", x$my_time, "\n")
  cat("CRS used is ", x$my_crs, "\n")
  print(x$my_coords)
}


#' \code{\link{summary}} method for class \code{mytrack}
#'
#' @param object object of a class \code{mytrack}
#' @param ... further arguments passed to or from other methods.
#'
#' @return Prints summary of objects of a class \code{mytrack}
#' @export
#'
#' @examples
#' \dontrun{
#' summary(obj1)}
summary.mytrack <- function(object, ...) {
cat("Object has ", nrow(object$my_coords), " coordinates." )
}


#' \code{\link{plot}} method for class \code{mytrack}
#'
#' @param x Object of a class \code{mytrack}
#' @param y Not used
#' @param ... Not used
#'
#' @return Plot in Cartesian xy system where Longitude is plotted on x and
#' latitude is plotted on y
#' @export
#'
#' @examples
#' \dontrun{
#' plot(obj1)}
plot.mytrack <- function(x,y, ...) {
  plot(x$my_coords,type="l")
}

#' Generic distance function
#'
#' @param obj Object of class \code{mytrack}
#' @param status TRUE for using S2 for distance calculation, or FALSE for not using it
#'
#' @return Distance in meters
#' @export
#'
distance <- function(obj,status) {
  UseMethod("distance")
}

#' Distance method for \code{mytrack} class objects
#'
#' @param obj Object of class \code{mytrack}
#' @param status TRUE for using S2 for distance calculation, or FALSE for not using it
#'
#' @return Distance in meters
#'
#' @export
#' @import sf
#' @examples
#' \dontrun{
#' distance.mytrack(obj1,TRUE)
#' }
distance.mytrack <- function(obj,status) {
  # this line of code is nulling geom and data variables and piping operator "."
  # in order to remove a note which R CMD check gives because they aren't declared
  # as variables, instead they are part of data frame
  # I found this workaround on stackoverflow on the following link:
  # https://stackoverflow.com/questions/9439256/how-can-i-handle-r-cmd-check-no-visible-binding-for-global-variable-notes-when
  geom <- data <- . <- NULL
  sf::sf_use_s2(status)
  points <- list()
  for(row in 1:nrow(obj$my_coords)) {
    point <- sf::st_point(c(obj$my_coords[c(row),c(1)],obj$my_coords[c(row),c(2)]))
    points[[row]] <- point
  }
  sfc_object <- sf::st_sfc(points, crs=obj$my_crs)
  sf_object <- sf::st_sf(geom=sfc_object)
  points.nested <- sf_object %>% tidyr::nest(data=geom)
  to_line <- function(tr) sf::st_cast(sf::st_combine(tr), "LINESTRING") %>% .[[1]]
  (tracks <- points.nested %>% dplyr::pull(data) %>% purrr::map(to_line) %>% sf::st_sfc(crs = obj$my_crs))
  return(as.integer(sf::st_length(tracks)))
}
