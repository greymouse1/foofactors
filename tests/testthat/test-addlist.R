test_that("addlist method adds an object of a class mytrack to an object of a class
          multitracks", {
            test_object1 <- storetracks("Madrid-Kyiv", c("2009-12-25 18:39:21 CST",
                                                         "2009-12-25 18:39:31 CST"),
                                        4326,
                                        data.frame(lon=c(-3.761989,30.415929),
                                                   lat=c(40.415190,50.470800))
            )
            test_object2 <- storetracks("Barcelona-London", c("2009-12-23 18:39:21 CST",
                                                          "2009-12-22 18:39:31 CST"),
                                         4326,
                                         data.frame(lon=c(-2.761989,31.415929),
                                                    lat=c(43.415190,55.470800))
            )

            # holder with first "mytrack" object
            holder <- multitracks(test_object1)

            # add second "mytrack" object
            addlist(holder,test_object2)

            # test that classes of new objects are in order
            expect_identical(class(holder),"multitracks")
            expect_identical(class(holder$lines$"Madrid-Kyiv"),"mytrack")
            expect_identical(class(holder$lines$"Barcelona-London"),"mytrack")
})
