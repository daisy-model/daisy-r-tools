# Read a dlf file (Daisy log file)

Read a dlf file (Daisy log file)

## Usage

``` r
read_dlf_file(path)
```

## Arguments

- path:

  Path to dlf file

## Value

An S4 object of class Dlf with three slots: header, units, data

header is list with everything in the dlf file before the data. key:
value pairs from the header are stored as named components of the list.
units is a data.frame containing the units of the values in data. data
is a data.frame containing the logged values

## Examples

``` r
data_dir <- system.file("extdata", package="daisytools")
path <- file.path(data_dir, "annual/Annual-FN/HourlyP-Annual-FN-2-2b.dlf")
dlf <- read_dlf_file(path)
slotNames(dlf)
#> [1] "header" "units"  "data"  
names(dlf@header)
#> [1] "info"     "VERSION"  "LOGFILE"  "RUN"      "COLUMN"   "INTERVAL" "LOG"     
#> [8] "SIMFILE"  "SIM"     
dlf@units$Crop
#> [1] "kg N/ha"
dlf$Crop # equivalent to dlf@data$Crop
#>  [1]   0.0000  27.9559 138.0880  11.4810  24.6333   0.0000  10.8504 133.5410
#>  [9]  34.2416  35.3079   0.0000
dlf[["Crop"]]
#>  [1]   0.0000  27.9559 138.0880  11.4810  24.6333   0.0000  10.8504 133.5410
#>  [9]  34.2416  35.3079   0.0000
```
