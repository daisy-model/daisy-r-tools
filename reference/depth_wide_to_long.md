# Transform wide format time series to a long format time series It is assumed that dlf@data only contains `time_name` columns and depth columns with the format `<var_name>_<depth-below-surface>` e.g. "q_100"

Transform wide format time series to a long format time series It is
assumed that dlf@data only contains `time_name` columns and depth
columns with the format `<var_name>_<depth-below-surface>` e.g. "q_100"

## Usage

``` r
depth_wide_to_long(
  dlf,
  var_name,
  time_name = "time",
  depth_name = "z",
  depth_unit = "unknown"
)
```

## Arguments

- dlf:

  An S4 object of class Dlf or a list of Dlf objects

- var_name:

  Name of variable in columns

- time_name:

  Name of time column

- depth_name:

  Name to use for new depth column

- depth_unit:

  Unit of depth

## Value

An S4 object of class Dlf

The data of the returned Dlf object contains one row for each time/depth
combination.

## Examples

``` r
data_dir <- system.file("extdata", package="daisytools")
path <- file.path(data_dir, "daily/DailyP/DailyP-Daily-WaterFlux.dlf")
dlf <- read_dlf(path, convert_depth=FALSE)
dlf@data[1,]
#>   year month mday hour q..AT..0 q..AT.._1 q..AT.._2 q..AT.._3 q..AT.._5.5
#> 1 1990     4    2    0 0.686972  0.664115   0.63981  0.613606    0.544964
#>   q..AT.._10.5 q..AT.._17 q..AT.._25 q..AT.._27 q..AT.._29 q..AT.._32
#> 1     0.395473   0.175839  -0.137307  -0.191751  -0.246702  -0.330268
#>   q..AT.._41 q..AT.._51 q..AT.._61 q..AT.._70 q..AT.._80 q..AT.._90 q..AT.._100
#> 1  -0.559167  -0.754909  -0.884317  -0.942759    -0.9329  -0.843949   -0.702253
#>   q..AT.._106 q..AT.._113 q..AT.._120 q..AT.._130 q..AT.._140 q..AT.._150
#> 1   -0.617684   -0.542156   -0.506693   -0.485376   -0.474339   -0.468794
#>   q..AT.._160 q..AT.._170 q..AT.._180 q..AT.._190 q..AT.._200       time
#> 1   -0.465219   -0.461336   -0.455971    -0.44889   -0.440634 1990-04-02
dlf <- depth_wide_to_long(dlf, "q")
head(dlf@data)
#>   year month mday hour       time     z        q
#> 1 1990     4    2    0 1990-04-02   0.0 0.686972
#> 2 1990     4    2    0 1990-04-02  -1.0 0.664115
#> 3 1990     4    2    0 1990-04-02  -2.0 0.639810
#> 4 1990     4    2    0 1990-04-02  -3.0 0.613606
#> 5 1990     4    2    0 1990-04-02  -5.5 0.544964
#> 6 1990     4    2    0 1990-04-02 -10.5 0.395473
```
