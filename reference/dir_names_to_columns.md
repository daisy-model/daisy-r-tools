# Remove directory part of dlf name and store it in the data slot

Remove directory part of dlf name and store it in the data slot

## Usage

``` r
dir_names_to_columns(dlfs, column_name_prefix = NULL)
```

## Arguments

- dlfs:

  List of dlfs

- column_name_prefix:

  Prefix to use for storing directory structure

## Value

A list of S4 objects of class Dlf. Each dlf is named with the basename
of its original name

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
dlfs <- dir_names_to_columns(dlfs)
lapply(dlfs, function(dlf) {
    dlf@data[1, "dir"]
})
#> $`HourlyP-Annual-FN-2-2b`
#> [1] "Annual-FN"
#> 
#> $`HourlyP-Annual-FN-2-3b`
#> [1] "Annual-FN"
#> 
#> $`HourlyP-Annual-FN-2-4b`
#> [1] "Annual-FN"
#> 
#> $`HourlyP-Annual-FN-2-5b`
#> [1] "Annual-FN"
#> 
#> $`HourlyP-Annual-Tracer-2-2b`
#> [1] "Annual-Tracer"
#> 
#> $`HourlyP-Annual-Tracer-2-3b`
#> [1] "Annual-Tracer"
#> 
#> $`HourlyP-Annual-Tracer-2-4b`
#> [1] "Annual-Tracer"
#> 
#> $`HourlyP-Annual-Tracer-2-5b`
#> [1] "Annual-Tracer"
#> 
```
