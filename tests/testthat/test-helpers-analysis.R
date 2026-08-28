test_that("filter and naming helpers reshape Dlf collections", {
    dlf_crop <- make_test_dlf(
        data.frame(year=1990, Crop=1),
        units=c(year="", Crop="kg")
    )
    dlf_other <- make_test_dlf(
        data.frame(year=1990, Water=2),
        units=c(year="", Water="mm")
    )
    named_dlfs <- list(
        "annual/Annual-FN/log"=dlf_crop,
        "annual/Annual-Water/log"=dlf_other
    )

    filtered <- filter_dlfs(named_dlfs, function(dlf) {
        "Crop" %in% colnames(dlf@data)
    })
    dropped <- drop_dir_from_names(named_dlfs)
    stripped <- strip_common_prefix_from_names(named_dlfs)

    expect_equal(names(filtered), "annual/Annual-FN/log")
    expect_equal(names(dropped), c("log", "log"))
    expect_equal(names(stripped), c("FN/log", "Water/log"))
})

test_that("dir_names_to_columns stores one directory level in the data slot", {
    dlf_a <- make_test_dlf(data.frame(value=1), units=c(value="kg"))
    dlf_b <- make_test_dlf(data.frame(value=2), units=c(value="kg"))

    result <- dir_names_to_columns(list("sim_a/log"=dlf_a, "sim_b/log"=dlf_b))

    expect_type(result, "list")
    expect_equal(names(result), c("log", "log"))
    expect_true(all(vapply(result, function(dlf) "dir" %in% colnames(dlf@data),
                            logical(1))))
    expect_equal(result[[1]]$dir[1], "sim_a")
    expect_equal(result[[2]]$dir[1], "sim_b")
    expect_true(all(vapply(result, function(dlf) dlf@units$dir == "",
                            logical(1))))
})

test_that("merge_dlfs merges same-schema Dlfs and tracks source names by default", {
    dlf_a <- make_test_dlf(
        data.frame(year=1990, value=1),
        units=c(year="", value="kg")
    )
    dlf_b <- make_test_dlf(
        data.frame(year=1991, value=2),
        units=c(year="", value="kg")
    )

    merged <- merge_dlfs(list(first=dlf_a, second=dlf_b))

    expect_s4_class(merged, "Dlf")
    expect_equal(merged$value, c(1, 2))
    expect_equal(merged$name, c("first", "second"))
})

test_that("merge_dlfs rejects collections with incompatible columns", {
    dlf_a <- make_test_dlf(
        data.frame(year=1990, value=1),
        units=c(year="", value="kg")
    )
    dlf_b <- make_test_dlf(
        data.frame(year=1990, other=2),
        units=c(year="", other="kg")
    )

    expect_error(merge_dlfs(list(first=dlf_a, second=dlf_b)),
                 "Cannot merge")
})

test_that("mass_balance computes cumulative sums and balances", {
    dlf <- make_test_dlf(
        data.frame(inflow=c(1, 2), outflow=c(0.5, 0.5), storage=c(10, 11)),
        units=c(inflow="kg", outflow="kg", storage="kg")
    )

    balance <- mass_balance(dlf, input="inflow", output="outflow",
                            content="storage")

    expect_s4_class(balance, "Dlf")
    expect_equal(balance$input_sum, c(1, 3))
    expect_equal(balance$output_sum, c(0.5, 1))
    expect_equal(balance$content_sum, c(0, 1))
    expect_equal(balance$balance, c(-0.5, -1))
    expect_equal(balance@units$balance, "kg")
})

test_that("mass_balance rejects mixed units", {
    dlf <- make_test_dlf(
        data.frame(inflow=1, outflow=1, storage=1),
        units=c(inflow="kg", outflow="g", storage="kg")
    )

    expect_error(mass_balance(dlf, input="inflow", output="outflow",
                              content="storage"),
                 "Unit mismatch")
})

test_that("mass_balance_summary returns documented totals for a single Dlf", {
    dlf <- make_test_dlf(
        data.frame(inflow=c(1, 2), outflow=c(0.5, 0.5), storage=c(10, 11)),
        units=c(inflow="kg", outflow="kg", storage="kg")
    )

    summary <- mass_balance_summary(dlf, input="inflow", output="outflow",
                                    content="storage")

    expect_named(summary,
                 c("Inputs", "Outputs", "InitialContent", "FinalContent",
                   "Balance"),
                 ignore.order=FALSE)
    expect_equal(unname(summary$Inputs["Total"]), 3)
    expect_equal(unname(summary$Outputs["Total"]), 1)
    expect_equal(summary$Balance$InitialContent, 10)
    expect_equal(summary$Balance$FinalContent, 11)
    expect_equal(summary$Balance$Balance, -1)
})
