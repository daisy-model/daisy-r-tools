test_that("Dlf accessors expose the data slot", {
    dlf <- make_test_dlf(
        data.frame(year=c(1990, 1991), Crop=c(1, 2)),
        units=c(year="", Crop="kg N/ha")
    )

    expect_equal(dlf$Crop, c(1, 2))
    expect_equal(dlf[["Crop"]], c(1, 2))
    expect_equal(dlf[[2, "Crop"]], 2)
    expect_equal(dlf[1, "Crop"], 1)
    expect_equal(dlf[1:2, c("year", "Crop")], dlf@data[1:2, c("year", "Crop")])
})

test_that("Dlf assignment methods return updated objects", {
    dlf <- make_test_dlf(
        data.frame(year=c(1990, 1991), Crop=c(1, 2)),
        units=c(year="", Crop="kg N/ha")
    )

    dlf2 <- dlf
    dlf2$Crop <- c(5, 6)
    expect_equal(dlf2$Crop, c(5, 6))

    dlf3 <- dlf
    dlf3[["Crop"]] <- c(7, 8)
    expect_equal(dlf3$Crop, c(7, 8))

    dlf4 <- dlf
    dlf4[[2, "Crop"]] <- 9
    expect_equal(dlf4$Crop, c(1, 9))

    dlf5 <- dlf
    dlf5[1, "Crop"] <- 4
    expect_equal(dlf5$Crop, c(4, 2))
})
