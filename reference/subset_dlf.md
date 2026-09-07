# Select the subset of measurements in a specific time range.

Select the subset of measurements in a specific time range.

## Usage

``` r
subset_dlf(
  dlfs,
  date_from = "",
  date_to = "",
  time_from = "00:00:00",
  time_to = "23:59:59",
  time_zone = "UTC",
  time_col = "time"
)
```

## Arguments

- dlfs:

  Either a list of Dlf or a single Dlf

- date_from:

  Start date (included). ISO 8601 format (yyyy-mm-dd), e.g 1999-01-31.
  Can be the empty string "" in which case only dates after date_to are
  excluded

- date_to:

  End date (included). ISO 8601 format (yyyy-mm-dd), e.g 1999-01-31. Can
  be the empty string "" in which case only dates before date_from are
  excluded

- time_from:

  Start time (included). ISO 8601 format (hh:mm:ss), e.g. 07:54:20

- time_to:

  End time (included). ISO 8601 format (hh:mm:ss), e.g. 07:54:20

- time_zone:

  Name of time zone.

- time_col:

  Name of time column in dlfs. Must be in POSIXct format. See
  `daisy_time_to_timestamp` for converting daisy time columns to POSIXct

## Value

Dlfs with data slot containing the selected rows

## Examples

``` r
# Load dlf data with read_dlf
data_dir <- file.path(system.file("extdata", package="daisytools"),
                      "annual/Annual-FN")
dlfs <- read_dlf_dir(data_dir)
dlfs <- daisy_time_to_timestamp(dlfs)
data.frame(lapply(dlfs, function(dlf) { dlf$time}))
#>    HourlyP.Annual.FN.2.2b HourlyP.Annual.FN.2.3b HourlyP.Annual.FN.2.4b
#> 1              1990-04-01             1990-04-01             1990-04-01
#> 2              1991-04-01             1991-04-01             1991-04-01
#> 3              1992-04-01             1992-04-01             1992-04-01
#> 4              1993-04-01             1993-04-01             1993-04-01
#> 5              1994-04-01             1994-04-01             1994-04-01
#> 6              1995-04-01             1995-04-01             1995-04-01
#> 7              1996-04-01             1996-04-01             1996-04-01
#> 8              1997-04-01             1997-04-01             1997-04-01
#> 9              1998-04-01             1998-04-01             1998-04-01
#> 10             1999-04-01             1999-04-01             1999-04-01
#> 11             2000-04-01             2000-04-01             2000-04-01
#>    HourlyP.Annual.FN.2.5b
#> 1              1990-04-01
#> 2              1991-04-01
#> 3              1992-04-01
#> 4              1993-04-01
#> 5              1994-04-01
#> 6              1995-04-01
#> 7              1996-04-01
#> 8              1997-04-01
#> 9              1998-04-01
#> 10             1999-04-01
#> 11             2000-04-01
dlfs <- subset_dlf(dlfs, "1995-04-01", "1999-04-01", time_zone="CEST")
data.frame(lapply(dlfs, function(dlf) { dlf$time}))
#>   HourlyP.Annual.FN.2.2b HourlyP.Annual.FN.2.3b HourlyP.Annual.FN.2.4b
#> 1             1995-04-01             1995-04-01             1995-04-01
#> 2             1996-04-01             1996-04-01             1996-04-01
#> 3             1997-04-01             1997-04-01             1997-04-01
#> 4             1998-04-01             1998-04-01             1998-04-01
#> 5             1999-04-01             1999-04-01             1999-04-01
#>   HourlyP.Annual.FN.2.5b
#> 1             1995-04-01
#> 2             1996-04-01
#> 3             1997-04-01
#> 4             1998-04-01
#> 5             1999-04-01
```
