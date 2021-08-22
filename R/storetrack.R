# Set new class called "Track"
setClass("track", representation(
  name = "character",
  time = "character",
  crs = "numeric",
  coordinates = "data.frame"
  ) )

# Here should somehow add visible comment which says that format of coordinates is lon/lat

# Function "storetrack" will create new object of a class "track"
storetrack <- function(my_name, timestamp, coordinate_system, coords) {
  new_object = new("track",
                   name = my_name,
                   time = timestamp,
                   crs = coordinate_system,
                   coordinates = coords
)
}
# Declare new function for distance
distance <- function(obj,status) {}

# Create generic function from function "distance"
setMethod("distance","track", function(obj,status) {
  sf::sf_use_s2(status)
  points <- list()
  for(row in 1:nrow(obj@coordinates)) {
    point <- sf::st_point(c(obj@coordinates[c(row),c(1)],obj@coordinates[c(row),c(2)]))
    points[[row]] <- point
  }
  sfc_object <- sf::st_sfc(points, crs=obj@crs)
  sf_object <- sf::st_sf(geom=sfc_object)
  points.nested <- sf_object %>% tidyr::nest(data=geom)
  to_line <- function(tr) sf::st_cast(sf::st_combine(tr), "LINESTRING") %>% .[[1]]
  (tracks <- points.nested %>% dplyr::pull(data) %>% purrr::map(to_line) %>% sf::st_sfc(crs = obj@crs))
  print("Distance of this route is")
  sf::st_length(tracks)
})
