#' \code{fbind} merges two factors
#'
#' Create a new factor from two existing factors, where the new factor's
#' are the union of the levels of the input factors.
#'
#' This part is just to try out how comments work
#'
#' @param a factor
#' @param b factor
#'
#' @return factor
#' @export
#'
#' @examples
#' fbind(iris$Species[c(1, 51, 101)], PlantGrowth$group[c(1, 11, 21)])
fbind <- function(a, b) {
  factor(c(as.character(a), as.character(b)))
}
