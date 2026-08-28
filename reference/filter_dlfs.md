# Filter a list of Dlfs

Filter a list of Dlfs

## Usage

``` r
filter_dlfs(dlfs, FUN)
```

## Arguments

- dlfs:

  List of Dlfs

- FUN:

  Function mapping dlf to a boolean of length 1

## Value

A list of Dlfs where FUN is TRUE

## Examples

``` r
data_dir <- system.file("extdata", package="daisyrVis")
dlfs <- read_dlf_dir(file.path(data_dir, "annual"))
names(dlfs)
#> [1] "Annual-FN/HourlyP-Annual-FN-2-2b"        
#> [2] "Annual-FN/HourlyP-Annual-FN-2-3b"        
#> [3] "Annual-FN/HourlyP-Annual-FN-2-4b"        
#> [4] "Annual-FN/HourlyP-Annual-FN-2-5b"        
#> [5] "Annual-Tracer/HourlyP-Annual-Tracer-2-2b"
#> [6] "Annual-Tracer/HourlyP-Annual-Tracer-2-3b"
#> [7] "Annual-Tracer/HourlyP-Annual-Tracer-2-4b"
#> [8] "Annual-Tracer/HourlyP-Annual-Tracer-2-5b"
## We only want the dlfs that have a "Crop" column
dlfs <- filter_dlfs(dlfs, function(dlf) {
    "Crop" %in% colnames(dlf@data)
})
names(dlfs)
#> [1] "Annual-FN/HourlyP-Annual-FN-2-2b" "Annual-FN/HourlyP-Annual-FN-2-3b"
#> [3] "Annual-FN/HourlyP-Annual-FN-2-4b" "Annual-FN/HourlyP-Annual-FN-2-5b"
```
