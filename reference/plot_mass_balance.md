# Plot Dlf object with mass balance calculation in a control chart

Plot Dlf object with mass balance calculation in a control chart

## Usage

``` r
plot_mass_balance(dlfs, x_var, title_suffix = "")
```

## Arguments

- dlfs:

  Either a list of Dlf or a single Dlf. If a list of Dlfs each Dlf is
  plotted in a separate subplot.

- x_var:

  Name of variable for x axis

- title_suffix:

  A string that is appended to the title of all subplots

## Value

A ggplot2 object.

## Examples

``` r
data_dir <- system.file("extdata", package="daisyrVis")
path <- file.path(data_dir, "hourly/P2D-Daily-Soil_Chemical_110cm.dlf")
dlf <- read_dlf(path)
input <- c("In_Matrix", "In_Biopores", "External", "Transform", "Tillage")
output <- c("Decompose", "Leak_Matrix", "Leak_Biopores", "Drain_Soil",
            "Drain_Biopores", "Uptake")
content <- c("Content", "Biopores")
mb <- mass_balance(dlf, input, output, content)
mb <- daisy_time_to_timestamp(mb)
plot_mass_balance(mb, "time", " - Soil chemical @ 110cm")
#> Ignoring unknown labels:
#> • fill : "Dlf"
#> • colour : "Dlf"
#> • shape : "Dlf"
```
