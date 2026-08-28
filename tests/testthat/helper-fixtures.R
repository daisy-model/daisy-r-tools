extdata_path <- function(...) {
    base <- system.file("extdata", package="daisytools")
    if (base == "") {
        base <- testthat::test_path("../../inst/extdata")
    }
    file.path(base, ...)
}

make_test_dlf <- function(data, units=NULL, header=list(info="dlf test")) {
    data <- as.data.frame(data, check.names=FALSE)
    if (is.null(units)) {
        units <- setNames(rep("", ncol(data)), colnames(data))
    }
    units_df <- as.data.frame(as.list(units), stringsAsFactors=FALSE)
    colnames(units_df) <- colnames(data)
    methods::new("Dlf", header=header, units=units_df, data=data)
}

write_test_dlf_file <- function(path, columns, units, rows,
                                header=c("dlf version 1",
                                         "RUN: test fixture")) {
    rows <- as.data.frame(rows, check.names=FALSE)
    body <- apply(as.matrix(rows), 1, function(row) {
        paste(row, collapse="\t")
    })
    lines <- c(header,
               "--------------------",
               paste(columns, collapse="\t"),
               paste(units, collapse="\t"),
               body)
    writeLines(lines, path, useBytes=TRUE)
    path
}
