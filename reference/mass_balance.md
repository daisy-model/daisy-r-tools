# Calculate mass balance

Calculate mass balance

## Usage

``` r
mass_balance(
  dlfs,
  input,
  output,
  content,
  use_initial_content_as_reference = TRUE
)
```

## Arguments

- dlfs:

  Either a list of Dlf or a single Dlf

- input:

  Name(s) of variable(s) containing mass input

- output:

  Name(s) of variable(s) containing mass output

- content:

  Name(s) of variable(s) containing mass content

- use_initial_content_as_reference:

  If TRUE subtract the initial content from the content sum before
  calculating balance.

## Value

A list of Dlf or a single Dlf. Four variables are added to each Dlf,
input_sum, output_sum, content_sum, and balance, which hold the sum and
balance of the input/output/content variables calculated for each time
point.

## Examples

``` r
data_dir <- system.file("extdata", package="daisytools")
path <- file.path(data_dir, "hourly/P2D-Daily-Soil_Chemical_110cm.dlf")
dlf <- read_dlf(path)
input <- c("In_Matrix", "In_Biopores", "External", "Transform", "Tillage")
output <- c("Decompose", "Leak_Matrix", "Leak_Biopores", "Drain_Soil",
            "Drain_Biopores", "Uptake")
content <- c("Content", "Biopores")
dlf <- mass_balance(dlf, input, output, content)
```
