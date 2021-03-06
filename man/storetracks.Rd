% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/storetracks.R
\name{storetracks}
\alias{storetracks}
\title{Constructor for object of a type \code{mytrack}}
\usage{
storetracks(name, time, crs, coordinates)
}
\arguments{
\item{name}{Name of the track}

\item{time}{Timestamps for points}

\item{crs}{CRS code}

\item{coordinates}{LON-LAT coordinates}
}
\value{
Object of a class \code{mytrack}
}
\description{
Constructor for object of a type \code{mytrack}
}
\examples{
\dontrun{
obj1 <- storetracks("Track1", my_timestamps, 4326, my_coordinates)
}
}
