#' An S4 class for holding coordinates of a track
#' @slot name Name of track
#' @slot time Timestamps for points
#' @slot crs Code for CRS
#' @slot coordinates Data frame holding coordinates
setClass("track", representation(
  name = "character",
  time = "character",
  crs = "numeric",
  coordinates = "data.frame"
  ) )

# Here should somehow add visible comment which says that format of coordinates is lon/lat

#' Creates new object of a class "track".
#'
#' @param my_name Name of track of a "character" type
#' @param timestamp Vector holding timestamps of a "character" type
#' @param coordinate_system EPSG number for datum and projection
#' @param coords Data frame with longitude and latitude
#'
#' @return Object of a type "track"
#' @export
#' @examples
#' ## Create vector with timestamps
#' my_timestamps <- c("2009-12-25 18:39:21 CST","2009-12-25 18:39:31 CST","2009-12-25 18:39:41 CST")
#'
#' ## Create data frame with coordinates
#' my_coordinates <- data.frame("longitude"= c(22.23,34.21,45.34),"latitude" = c(33.16,12.32,22.21))
#'
#' ## Create object of class "track"
#' storetrack("Track1",my_timestamps,4326,my_coordinates)
storetrack <- function(my_name, timestamp, coordinate_system, coords) {
  new_object = methods::new("track",
                   name = my_name,
                   time = timestamp,
                   crs = coordinate_system,
                   coordinates = coords
)
}
#' Distance generic
#'
#' @param obj Object of class track
#' @param status Object of class logical
distance <- function(obj,status) UseMethod("distance")

#' @describeIn distance Method for calculating distance of a track

setMethod("distance","track", function(obj,status) {
  sf::sf_use_s2(status)
  points <- list()
  for(row in 1:nrow(obj@coordinates)) {
    point <- sf::st_point(c(obj@coordinates[c(row),c(1)],obj@coordinates[c(row),c(2)]))
    points[[row]] <- point
  }
  sfc_object <- sf::st_sfc(points, crs=obj@crs)
  print(sfc_object)
  sf_object <- sf::st_sf(geom=sfc_object)
  print(sf_object)
  points.nested <- sf_object %>% tidyr::nest(data=geom)
  print(points.nested)
  to_line <- function(tr) sf::st_cast(sf::st_combine(tr), "LINESTRING") %>% .[[1]]
  (tracks <- points.nested %>% dplyr::pull(data) %>% purrr::map(to_line) %>% sf::st_sfc(crs = obj@crs))
  print("Distance of this route is")
  sf::st_length(tracks)
})
