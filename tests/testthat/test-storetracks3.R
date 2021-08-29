test_that("Test that function storetrack is creating object of a class mytrack
          with slots for my_name of class character, my_time of class character,
          my_crs of class numeric and my_coords of class data.frame", {
            test_object <- storetracks3("Test track", c("2009-12-25 18:39:21 CST",
                                                        "2009-12-25 18:39:31 CST",
                                                        "2009-12-25 18:39:41 CST"),
                                        4326,
                                        data.frame(lon=c(11,12,13),lat=c(14,15,16))

            )
            expect_identical(class(test_object),"mytrack")
            expect_identical(class(test_object$my_name),"character")
            expect_identical(class(test_object$my_time),"character")
            expect_identical(class(test_object$my_crs),"numeric")
            expect_identical(class(test_object$my_coords),"data.frame")
            expect_identical(test_object$my_name,"Test track")
            expect_identical(test_object$my_time,c("2009-12-25 18:39:21 CST",
                                            "2009-12-25 18:39:31 CST",
                                            "2009-12-25 18:39:41 CST"))
            expect_identical(test_object$my_crs,4326)
            expect_identical(test_object$my_coords,data.frame(lon=c(11,12,13),lat=c(14,15,16)))
          })
