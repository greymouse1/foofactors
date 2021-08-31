test_that("Test that distance method is working for class mytrack", {
  test_object <- storetracks("Madrid-Kyiv", c("2009-12-25 18:39:21 CST",
                                              "2009-12-25 18:39:31 CST"),
                              4326,
                              data.frame(lon=c(-3.761989,30.415929),lat=c(40.415190,50.470800))
  )
  # distance with s2 turned off
  distance_no_s2 <- distance(test_object,FALSE)
  actual_no_s2 <- as.integer(2866199)
  expect_identical(distance_no_s2,actual_no_s2)

  # distance with s2 turned on
  distance_s2 <- distance(test_object,TRUE)
  actual_s2 <- as.integer(2859593)
  expect_identical(distance_s2,actual_s2)

          })

