
<!-- README.md is generated from README.Rmd. Please edit that file -->

# foofactors

<!-- badges: start -->
<!-- badges: end -->

This package is made as final project for Spatial data with R. Package
is focused on two classes:

-   **mytrack** object which will hold some metadata for a line as well
    as coordinates of points of a line
-   **multitracks** object which is intended to be a container for
    multiple objects of a class **mytrack**

**mytrack** has the following methods included:

-   *print* which prints metadata and coordinates of points
-   *summary* gives count of points in line
-   *plot* plots line
-   *distance* calculates distance of the line either on flat surface(S2
    is FALSE) or on a sphere(S2 is TRUE)

**multitracks** has the following methods included:

-   *print* will print names of all tracks in the container
-   *summary* will provide with number of tracks in container, their
    names, number of points they have and the distance on S2.
-   *addlist* adds new line of class **mytrack** to container of class
    **multitracks**

### Installation

You can install this package with:

``` r
install.packages("foofactors")
```

### Example for class *mytrack*

This example shows how to create object of a type **mytrack**. We have
coordinates of two cities, Madrid and Kyiv, and use function
**storetracks** to create the object:

``` r
library(foofactors)
test_object1 <- storetracks("Madrid-Kyiv", c("2009-12-25 18:39:21 CST",
                                              "2009-12-25 18:39:31 CST"),
                              4326,
                              data.frame(lon=c(-3.761989,30.415929),lat=c(40.415190,50.470800))
  )
```

In the above example, 4326 is code for WGS84 Ellipsoid. Another code can
be used as well. We can calculate distance with or without using S2. To
use S2 we type:

``` r
distance(test_object1,TRUE)
#> [1] 2859593
```

Or for distance without S2 we type:

``` r
distance(test_object1,FALSE)
#> Linking to GEOS 3.8.1, GDAL 3.1.4, PROJ 6.3.1
#> [1] 2866199
```

Package also uses few of the methods generate from existing generic
functions, for example plot, print and summary.

**print** method prints information about what is stored in the object’s
slots

``` r
print(test_object1)
#> Name of this object is Madrid-Kyiv 
#> Timestamps are  2009-12-25 18:39:21 CST 2009-12-25 18:39:31 CST 
#> CRS used is  4326 
#>         lon      lat
#> 1 -3.761989 40.41519
#> 2 30.415929 50.47080
```

**summary** method will summarize how many points we have stored in our
object

``` r
summary(test_object1)
#> Object has  2  coordinates.
```

**plot** method plots line graph, with the line connecting subsequent
points.

``` r
plot(test_object1)
```

<img src="man/figures/README-example6-1.png" width="100%" />

### Example for class *multitracks*

First we create object of a class **multitracks** and add our first line
to it by using **multitracks** function:

``` r
holder <- multitracks(test_object1)
```

Now we can create second **mytrack** object:

``` r
test_object2 <- storetracks("Moscow-Oslo", c("2009-12-25 19:39:21 CST",
                                              "2009-12-25 20:39:31 CST"),
                              4326,
                              data.frame(lon=c(-3.761989,30.415929),lat=c(40.415190,50.470800))
  )
```

When we want to add a subsequent line to our container, we use method
**addlist**, with first argument being **multitracks** object, and
second argument being **mytrack** object:

``` r
addlist(holder,test_object2)
```

As we can see, our container will hold these lines of a **mytrack**
class in a **hash**, type of dictionary structure used in R. Access is
made by using key-value system, in this case, keys would be names of
tracks:

``` r
holder$lines
#> <hash> containing 2 key-value pair(s).
#>   Madrid-Kyiv : Madrid-Kyiv 2009-12-25 18:39:21 CST, 2009-12-25 18:39:31 CST 4326 -3.761989, 30.415929, 40.415190, 50.470800
#>   Moscow-Oslo : Moscow-Oslo 2009-12-25 19:39:21 CST, 2009-12-25 20:39:31 CST 4326 -3.761989, 30.415929, 40.415190, 50.470800
holder$lines$"Moscow-Oslo"
#> Name of this object is Moscow-Oslo 
#> Timestamps are  2009-12-25 19:39:21 CST 2009-12-25 20:39:31 CST 
#> CRS used is  4326 
#>         lon      lat
#> 1 -3.761989 40.41519
#> 2 30.415929 50.47080
```

Two generic methods used for **multitracks** objects are **print**:

``` r
print(holder)
#> Your object contains the following tracks:  
#> Madrid-Kyiv 
#> Moscow-Oslo
```

and **summary**:

``` r
summary(holder)
#> Your object holds  2 tracks 
#> Track  Madrid-Kyiv  holds  2 points and has
#> length of  2859593 meters 
#> Track  Moscow-Oslo  holds  2 points and has
#> length of  2859593 meters
```
