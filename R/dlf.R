## nolint start: object_name_linter
#' Class encapsulating Daisy log file (dlf) data
#' @slot header  A list with named components containing meta information
#' @slot units  A data.frame with the units of the values in data
#' @slot data  A data.frame with the values from the dlf file
#' @export Dlf
Dlf <- setClass("Dlf", slots=list(header="list",
                                  units="data.frame",
                                  data="data.frame"))
## nolint end

#' $ indexing on the data part of the dlf
#' @param x The dlf object
#' @param name Name of column in data part
#' @return The selected column from the data slot as the underlying column
#'   vector.
#' @export
setMethod("$", "Dlf", function(x, name) {
    x@data[[name, exact=FALSE]]
})

#' $ assignment on the data part of the dlf
#' @param x The dlf object
#' @param name Name of column in data part
#' @param value New value to assign
#' @return An updated `Dlf` object with the selected column replaced in the
#'   data slot.
#' @export
setMethod("$<-", "Dlf", function(x, name, value) {
    x@data[[name]] <- value
    x
})

#' [[ indexing on the data part of the dlf
#' @param x The dlf object
#' @param i Name or index of row OR if j is missing, name or index of column
#' @param j Name or index of column
#' @return If `j` is missing, the selected column from the data slot as the
#'   underlying column vector. Otherwise, the single value stored at row `i`
#'   and column `j`.
#' @export
setMethod("[[", "Dlf", function(x, i, j) {
    if (missing(j)) {
        x@data[[i]]
    } else {
        x@data[[i, j]]
    }
})

#' [[ assignment on the data part of the dlf
#' @param x The dlf object
#' @param i Name or index of row OR if j is missing, name or index of column
#' @param j Name or index of column
#' @param value New value to assign
#' @return An updated `Dlf` object with the selected column or single cell
#'   replaced in the data slot.
#' @export
setMethod("[[<-", "Dlf", function(x, i, j, value) {
    if (missing(j)) {
        x@data[[i]] <- value
    } else {
        x@data[[i, j]] <- value
    }
    x
})

#' [ indexing on the data part of the dlf
#' @param x The dlf object
#' @param i Name or index of row OR if j is missing, name or index of column
#' @param j Name or index of column
#' @return If `j` is missing, a `data.frame` containing the selected rows from
#'   the data slot. Otherwise, the result of subsetting the data slot by rows
#'   and columns, typically a vector for a single selected column or a
#'   `data.frame` for multiple columns.
#' @export
setMethod("[", "Dlf", function(x, i, j) {
    if (missing(j)) {
        x@data[i, ]
    } else {
        x@data[i, j]
    }
})

#' [ assignment on the data part of the dlf
#' @param x The dlf object
#' @param i Name or index of row OR if j is missing, name or index of column
#' @param j Name or index of column
#' @param value New value to assign
#' @return An updated `Dlf` object with the selected rows, columns, or cells
#'   replaced in the data slot.
#' @export
setMethod("[<-", "Dlf", function(x, i, j, value) {
    if (missing(j)) {
        x@data[i, ] <- value
    } else {
        x@data[i, j] <- value
    }
    x
})
