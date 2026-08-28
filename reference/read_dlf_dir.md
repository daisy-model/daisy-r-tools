# Walk a directory tree and read all dlf files in it.

Walk a directory tree and read all dlf files in it.

## Usage

``` r
read_dlf_dir(directory, pattern = ".*\\.dlf")
```

## Arguments

- directory:

  Path to directory

- pattern:

  Regex pattern of files to include

## Value

A list of S4 objects of class Dlf. Each dlf is named with the relative
path to it

## Examples

``` r
data_dir <- system.file("extdata", package="daisyrVis")
dlfs <- read_dlf_dir(file.path(data_dir, "annual"))
print(names(dlfs))
#> [1] "Annual-FN/HourlyP-Annual-FN-2-2b"        
#> [2] "Annual-FN/HourlyP-Annual-FN-2-3b"        
#> [3] "Annual-FN/HourlyP-Annual-FN-2-4b"        
#> [4] "Annual-FN/HourlyP-Annual-FN-2-5b"        
#> [5] "Annual-Tracer/HourlyP-Annual-Tracer-2-2b"
#> [6] "Annual-Tracer/HourlyP-Annual-Tracer-2-3b"
#> [7] "Annual-Tracer/HourlyP-Annual-Tracer-2-4b"
#> [8] "Annual-Tracer/HourlyP-Annual-Tracer-2-5b"

dlfs <- drop_dir_from_names(dlfs)
print(names(dlfs))
#> [1] "HourlyP-Annual-FN-2-2b"     "HourlyP-Annual-FN-2-3b"    
#> [3] "HourlyP-Annual-FN-2-4b"     "HourlyP-Annual-FN-2-5b"    
#> [5] "HourlyP-Annual-Tracer-2-2b" "HourlyP-Annual-Tracer-2-3b"
#> [7] "HourlyP-Annual-Tracer-2-4b" "HourlyP-Annual-Tracer-2-5b"

dlfs <- strip_common_prefix_from_names(dlfs)
print(names(dlfs))
#> [1] "FN-2-2b"     "FN-2-3b"     "FN-2-4b"     "FN-2-5b"     "Tracer-2-2b"
#> [6] "Tracer-2-3b" "Tracer-2-4b" "Tracer-2-5b"
```
