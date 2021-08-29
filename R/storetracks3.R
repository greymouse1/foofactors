#' Constructor for object of a type "mytrack"
#'
#' @param name Name of the track
#' @param time Timestamps for points
#' @param crs CRS code
#' @param coordinates LON-LAT coordinates
#'
#' @return Object of a class "mytrack
#' @export
#'
#' @examples
#' \dontrun{
#' obj1 <- storetracks3("Track1", my_timestamps, 4326, my_coordinates)
#' }
storetracks3 <- function(name,time,crs,coordinates) {
  value <- list(my_name = name, my_time = time, my_crs = crs, my_coords=coordinates)
  attr(value, "class") <- "mytrack"
  value
}


#' Print method for class "mytrack"
#'
#' @param x object of a class "mytrack"
#' @param ... further arguments passed to or from other methods.
#'
#' @return Prints elements of object of a class "mytrack"
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


#' Summary method for class "mytrack"
#'
#' @param object object of a class "mytrack"
#' @param ... further arguments passed to or from other methods.
#'
#' @return Prints summary of objects of a class "mytrack"
#' @export
#'
#' @examples
#' \dontrun{
#' summary(obj1)}
summary.mytrack <- function(object, ...) {
cat("Object has ", nrow(object$my_coords), " coordinates." )
}


#' Plot method for class "mytrack"
#'
#' @param x Object of a class "mytrack"
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
#' @param obj Object of class "mytrack"
#' @param status TRUE for using S2 for distance calculation, or FALSE for not using it
#'
#' @return Distance in meters
#' @export
#'
distance2 <- function(obj,status) {
  UseMethod("distance2")
}

#' Distance method for "mytrack" class objects
#'
#' @param obj Object of class "mytrack"
#' @param status TRUE for using S2 for distance calculation, or FALSE for not using it
#'
#' @return Distance in meters
#'
#' @export
#' @import sf
#' @examples
#' \dontrun{
#' distance2.mytrack(obj1,TRUE)
#' }
distance2.mytrack <- function(obj,status) {
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
