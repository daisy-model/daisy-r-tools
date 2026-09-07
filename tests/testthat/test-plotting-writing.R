test_that("plot_dlf returns ggplot objects for built-in plot types", {
    dlf <- make_test_dlf(
        data.frame(year=c(1990, 1991), value=c(1, 2), other=c(3, 4)),
        units=c(year="", value="kg", other="mm")
    )
    list_dlfs <- list(first=dlf, second=dlf)

    points_plot <- plot_dlf(dlf, "year", "value", "points")
    multi_plot <- plot_dlf(dlf, "year", c("value", "other"), "lines")
    list_plot <- plot_dlf(list_dlfs, "year", "value", "bar")

    expect_s3_class(points_plot, "ggplot")
    expect_equal(points_plot$labels$y, "value [kg]")
    expect_false(is.null(multi_plot))
    expect_s3_class(list_plot, "ggplot")
})

test_that("plot_dlf accepts a custom geom function", {
    dlf <- make_test_dlf(
        data.frame(year=c(1990, 1991), value=c(1, 2)),
        units=c(year="", value="kg")
    )

    plot <- plot_dlf(dlf, "year", "value",
                     function(gg) gg + ggplot2::geom_line())

    expect_s3_class(plot, "ggplot")
})

test_that("plot_dlf rejects unsupported type strings", {
    dlf <- make_test_dlf(
        data.frame(year=c(1990, 1991), value=c(1, 2)),
        units=c(year="", value="kg")
    )

    expect_error(plot_dlf(dlf, "year", "value", "unsupported"),
                 "Unknown plot type")
})

test_that("plot_dlf_depth and animate_dlf produce plot objects", {
    path <- extdata_path("daily", "DailyP", "DailyP-Daily-WaterFlux.dlf")
    dlf <- read_dlf(path)

    depth_plot <- plot_dlf_depth(dlf, x_var="q", time_points=dlf$time[1])
    animation <- animate_dlf(dlf, "q")

    expect_s3_class(depth_plot, "ggplot")
    expect_true(inherits(animation, "plotly"))
    expect_true(inherits(animation, "htmlwidget"))
})

test_that("plot_mass_balance returns a ggplot for a mass balance Dlf", {
    dlf <- make_test_dlf(
        data.frame(
            time=as.POSIXct(c("2020-01-01", "2020-01-02"), tz="UTC"),
            inflow=c(1, 2),
            outflow=c(0.5, 0.5),
            storage=c(10, 11)
        ),
        units=c(time="", inflow="kg", outflow="kg", storage="kg")
    )
    balance <- mass_balance(dlf, input="inflow", output="outflow",
                            content="storage")

    plot <- plot_mass_balance(balance, "time")

    expect_s3_class(plot, "ggplot")
    expect_equal(plot$labels$y, "Balance")
})

test_that("write_dlf writes units and optional header information", {
    dlf <- make_test_dlf(
        data.frame(year=c(1990, 1991), value=c(1.5, 2.5)),
        units=c(year="", value="kg"),
        header=list(RUN="demo")
    )

    path_no_header <- tempfile(fileext=".csv")
    path_with_header <- tempfile(fileext=".csv")

    write_dlf(dlf, path_no_header)
    write_dlf(dlf, path_with_header, include_dlf_header=TRUE)

    lines_no_header <- readLines(path_no_header)
    lines_with_header <- readLines(path_with_header)

    expect_match(lines_no_header[1], "year")
    expect_match(lines_no_header[1], "value")
    expect_match(lines_no_header[2], "kg")
    expect_equal(length(lines_no_header), 4)

    expect_match(lines_with_header[1], "RUN")
    expect_true(any(grepl("year", lines_with_header, fixed=TRUE)))
    expect_true(any(grepl("value", lines_with_header, fixed=TRUE)))
})

test_that("write_dlf roundtrips a Dlf through read_dlf", {
    source_path <- extdata_path(
        "annual", "Annual-FN", "HourlyP-Annual-FN-2-2b.dlf"
    )
    roundtrip_path <- tempfile(fileext=".dlf")

    original <- read_dlf(
        source_path,
        mode="file",
        convert_time=FALSE,
        convert_depth=FALSE
    )
    suppressWarnings(
        write_dlf(original, roundtrip_path, include_dlf_header=TRUE)
    )
    restored <- read_dlf(
        roundtrip_path,
        mode="file",
        convert_time=FALSE,
        convert_depth=FALSE
    )

    expect_equal(restored@header, original@header)
    expect_equal(restored@units, original@units)
    expect_equal(restored@data, original@data)
})
