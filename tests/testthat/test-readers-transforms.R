test_that("read_dlf_file parses headers, column names, and units", {
    path <- tempfile(fileext=".dlf")
    write_test_dlf_file(
        path=path,
        columns=c("year", "Crop-rate @ 10", "MissingUnit"),
        units=c("", "kg/ha"),
        rows=data.frame(
            year=1990,
            check.names=FALSE,
            "Crop-rate @ 10"=1.5,
            MissingUnit=2
        )
    )

    dlf <- read_dlf_file(path)

    expect_s4_class(dlf, "Dlf")
    expect_true(all(c("info", "RUN") %in% names(dlf@header)))
    expect_named(dlf@data,
                 c("year", "Crop_rate..AT..10", "MissingUnit"),
                 ignore.order=FALSE)
    expect_named(dlf@units,
                 c("year", "Crop_rate..AT..10", "MissingUnit"),
                 ignore.order=FALSE)
    expect_equal(dlf@units$Crop_rate..AT..10, "kg/ha")
    expect_equal(dlf@units$MissingUnit, "")
    expect_equal(dlf$Crop_rate..AT..10, 1.5)
})

test_that("read_dlf_file preserves header values containing colons", {
    path <- extdata_path("annual", "Annual-FN", "HourlyP-Annual-FN-2-2b.dlf")

    dlf <- read_dlf_file(path)

    expect_equal(dlf@header$RUN, "Mon Aug 28 16:37:22 2023")
})

test_that("read_dlf supports documented file, directory, and spawn modes", {
    root <- tempfile("dlf-tree-")
    dir.create(root)

    file_path <- file.path(root, "single.dlf")
    write_test_dlf_file(
        path=file_path,
        columns=c("year", "month", "mday", "hour", "value"),
        units=c("", "", "", "", "kg"),
        rows=data.frame(year=1990, month=1, mday=1, hour=0, value=10)
    )

    dir_mode_root <- file.path(root, "dir-mode")
    dir.create(file.path(dir_mode_root, "scenario_a"), recursive=TRUE)
    dir.create(file.path(dir_mode_root, "scenario_b"), recursive=TRUE)
    write_test_dlf_file(
        path=file.path(dir_mode_root, "scenario_a", "log_a.dlf"),
        columns=c("year", "month", "mday", "hour", "value"),
        units=c("", "", "", "", "kg"),
        rows=data.frame(year=1990, month=1, mday=1, hour=0, value=1)
    )
    write_test_dlf_file(
        path=file.path(dir_mode_root, "scenario_b", "log_b.dlf"),
        columns=c("year", "month", "mday", "hour", "value"),
        units=c("", "", "", "", "kg"),
        rows=data.frame(year=1991, month=1, mday=2, hour=0, value=2)
    )

    spawn_root <- file.path(root, "spawn-mode")
    dir.create(file.path(spawn_root, "sim_a"), recursive=TRUE)
    dir.create(file.path(spawn_root, "sim_b"), recursive=TRUE)
    write_test_dlf_file(
        path=file.path(spawn_root, "sim_a", "shared_log.dlf"),
        columns=c("year", "month", "mday", "hour", "value"),
        units=c("", "", "", "", "kg"),
        rows=data.frame(year=1990, month=1, mday=1, hour=0, value=3)
    )
    write_test_dlf_file(
        path=file.path(spawn_root, "sim_b", "shared_log.dlf"),
        columns=c("year", "month", "mday", "hour", "value"),
        units=c("", "", "", "", "kg"),
        rows=data.frame(year=1990, month=1, mday=2, hour=0, value=4)
    )

    file_dlf <- read_dlf(file_path, mode="file",
                         convert_time=FALSE, convert_depth=FALSE)
    dir_dlfs <- read_dlf(dir_mode_root, mode="dir",
                         convert_time=FALSE, convert_depth=FALSE)
    spawn_dlfs <- read_dlf(spawn_root, mode="spawn",
                           convert_time=FALSE, convert_depth=FALSE)

    expect_s4_class(file_dlf, "Dlf")
    expect_type(dir_dlfs, "list")
    expect_equal(sort(names(dir_dlfs)),
                 c("scenario_a/log_a", "scenario_b/log_b"))
    expect_type(spawn_dlfs, "list")
    expect_equal(names(spawn_dlfs), "shared_log")
    expect_true("sim" %in% colnames(spawn_dlfs$shared_log@data))
    expect_setequal(unique(spawn_dlfs$shared_log$sim), c("sim_a", "sim_b"))
})

test_that("read_dlf rejects unknown mode values", {
    path <- extdata_path("annual", "Annual-FN", "HourlyP-Annual-FN-2-2b.dlf")

    expect_error(read_dlf(path, mode="invalid"),
                 "Unknown mode")
})

test_that("read_dlf converts bundled depth data into time and depth columns", {
    path <- extdata_path("daily", "DailyP", "DailyP-Daily-WaterFlux.dlf")

    dlf <- read_dlf(path)

    expect_s4_class(dlf, "Dlf")
    expect_named(dlf@data,
                 c("year", "month", "mday", "hour", "time", "z", "q"),
                 ignore.order=FALSE)
    expect_s3_class(dlf$time, "POSIXct")
    expect_true(is.numeric(dlf$z))
    expect_true(is.numeric(dlf$q))
    expect_equal(dlf@units$z, "unknown")
    expect_equal(dlf@units$q, "mm")
})

test_that("daisy_time_to_timestamp works for single Dlfs and lists", {
    dlf <- make_test_dlf(
        data.frame(
            year=c(2012, 2012),
            month=c(3, 3),
            mday=c(4, 5),
            hour=c(5, 6),
            value=c(10, 11)
        ),
        units=c(year="", month="", mday="", hour="", value="kg")
    )

    converted <- daisy_time_to_timestamp(dlf, "time",
                                         drop_daisy_time_cols=TRUE)
    converted_list <- daisy_time_to_timestamp(list(sample=dlf), "time",
                                              drop_daisy_time_cols=TRUE)

    expect_named(converted@data, c("value", "time"), ignore.order=FALSE)
    expect_s3_class(converted$time, "POSIXct")
    expect_equal(format(converted$time[1], "%Y%m%d%H%M%S"), "20120304050000")
    expect_type(converted_list, "list")
    expect_s4_class(converted_list$sample, "Dlf")
    expect_named(converted_list$sample@data, c("value", "time"),
                 ignore.order=FALSE)
})

test_that("daisy_time_to_timestamp errors when time columns are missing", {
    dlf <- make_test_dlf(
        data.frame(year=2012, month=3, value=10),
        units=c(year="", month="", value="kg")
    )

    expect_error(
        daisy_time_to_timestamp(
            dlf,
            year_col="year",
            month_col="month",
            day_col="mday",
            hour_col="hour"
        ),
        "Missing time columns"
    )
})

test_that("depth_wide_to_long converts bundled depth data to long format", {
    path <- extdata_path("daily", "DailyP", "DailyP-Daily-WaterFlux.dlf")
    dlf <- read_dlf(path, convert_depth=FALSE)

    converted <- depth_wide_to_long(dlf, "q")

    expect_s4_class(converted, "Dlf")
    expect_named(converted@data,
                 c("year", "month", "mday", "hour", "time", "z", "q"),
                 ignore.order=FALSE)
    expect_s3_class(converted$time, "POSIXct")
    expect_true(is.numeric(converted$z))
    expect_true(all(!is.na(converted$q)))
})

test_that("subset_dlf applies inclusive time filters to Dlfs and lists", {
    dlf <- make_test_dlf(
        data.frame(
            time=as.POSIXct(c("2020-01-01 00:00:00",
                              "2020-01-02 12:00:00",
                              "2020-01-03 23:59:59"), tz="UTC"),
            value=c(1, 2, 3)
        ),
        units=c(time="", value="kg")
    )

    subset_single <- subset_dlf(dlf, "2020-01-02", "2020-01-03",
                                time_from="12:00:00",
                                time_to="23:59:59")
    subset_list <- subset_dlf(list(a=dlf, b=dlf), "2020-01-01", "2020-01-02",
                              time_from="00:00:00", time_to="12:00:00")

    expect_equal(subset_single$value, c(2, 3))
    expect_type(subset_list, "list")
    expect_equal(subset_list$a$value, c(1, 2))
    expect_equal(subset_list$b$value, c(1, 2))
})
