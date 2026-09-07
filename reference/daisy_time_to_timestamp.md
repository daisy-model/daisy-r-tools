# Transform daisy time columns to a single timestamp

Transform daisy time columns to a single timestamp

## Usage

``` r
daisy_time_to_timestamp(
  dlf,
  time_col_name = "time",
  year_col = NULL,
  month_col = NULL,
  day_col = NULL,
  hour_col = NULL,
  drop_daisy_time_cols = FALSE
)
```

## Arguments

- dlf:

  An S4 object of class Dlf or a list of Dlf objects

- time_col_name:

  The name of the new timestamp column

- year_col:

  Name of year column, set to NULL if no year column

- month_col:

  Name of month column, set to NULL if no month column

- day_col:

  Name of day column, set to NULL if no day column

- hour_col:

  Name of hour column, set to NULL if no hour column

- drop_daisy_time_cols:

  If TRUE drop the year, month, day, hour columns

## Value

An S4 object of class Dlf

If all of year_col, month_col, day_col and hour_col are NULL, then an
attempt is made to guess the relevant names.

The returned object is identical to the dlf, except that the Columns
'year', 'month', 'mday' and 'hour' are dropped and replaced with a
column containing the corresponding POSIXct timestamp

## Examples

``` r
data_dir <- system.file("extdata", package="daisytools")
path <- file.path(data_dir, 'daily/DailyP/DailyP-Daily-WaterFlux.dlf')
dlf <- read_dlf(path)
dlf@data[1,]
#>   year month mday hour       time z        q
#> 1 1990     4    2    0 1990-04-02 0 0.686972
dlf <- daisy_time_to_timestamp(dlf)
dlf@data[1,]
#>   year month mday hour       time z        q
#> 1 1990     4    2    0 1990-04-02 0 0.686972
```
