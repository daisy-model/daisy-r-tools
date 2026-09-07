#' Write a dlf object to a file
#'
#' @param dlf Dlf object to write
#' @param path Output path to write to
#' @param sep Separator to use in csv file
#' @param include_dlf_header If TRUE write the Dlf header to the beginning of
#' the csv file
#'
#' @export
write_dlf <- function(dlf, path, sep="\t", include_dlf_header=FALSE) {
    if (include_dlf_header) {
        header_lines <- format_dlf_header(dlf@header)
        writeLines(c(header_lines, "--------------------"), con = path,
                   useBytes = TRUE)
    }
    withCallingHandlers(
        utils::write.table(dlf@units, path, append=include_dlf_header, sep=sep,
                           row.names=FALSE, fileEncoding="UTF-8",
                           quote=FALSE),
        warning = function(cond) {
            if (identical(conditionMessage(cond),
                          "appending column names to file")) {
                invokeRestart("muffleWarning")
            }
        }
    )
    utils::write.table(dlf@data, path, append=TRUE, sep=sep, row.names=FALSE,
                       col.names=FALSE, fileEncoding="UTF-8", quote=FALSE)
}

format_dlf_header <- function(header, bare_field = "info") {
    unlist(lapply(names(header), function(name) {
        value <- header[[name]]
        lines <- strsplit(as.character(value), "\n", fixed=TRUE)[[1]]
        if (identical(name, bare_field)) {
            lines
        } else {
            paste0(name, ": ", lines)
        }
    }), use.names=FALSE)
}
