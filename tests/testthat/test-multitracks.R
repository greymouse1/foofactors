test_that("multitracks function creates an object of class multitracks and stores inside
          object of class mytrack", {
            test_object <- storetracks("Madrid-Kyiv", c("2009-12-25 18:39:21 CST",
                                                         "2009-12-25 18:39:31 CST"),
                                        4326,
                                        data.frame(lon=c(-3.761989,30.415929),
                                                   lat=c(40.415190,50.470800))
            )
            # holder holding "mytrack" object
            holder <- multitracks(test_object)

            # test that classes are correct
            expect_identical(class(holder),"multitracks")
            expect_identical(class(holder$lines$"Madrid-Kyiv"),"mytrack")

})
