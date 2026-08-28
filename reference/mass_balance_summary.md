# Mass balance summary for a set of specified variables

Mass balance summary for a set of specified variables

## Usage

``` r
mass_balance_summary(dlfs, input, output, content)
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

## Value

Either a single list or a list of lists, with the nested lists having
five elements: Inputs, Outputs, InitialContent, FinalContent, and
Balance.

## Examples

``` r
data_dir <- system.file("extdata", package="daisyrVis")
path <- file.path(data_dir, "hourly/P2D-Daily-Soil_Chemical_110cm.dlf")
dlf <- read_dlf(path)
input <- c("In_Matrix", "In_Biopores", "External", "Transform", "Tillage")
output <- c("Decompose", "Leak_Matrix", "Leak_Biopores", "Drain_Soil",
            "Drain_Biopores", "Uptake")
content <- c("Content", "Biopores")
mass_balance_summary(dlf, input, output, content)
#> $Inputs
#>   In_Matrix In_Biopores    External   Transform     Tillage       Total 
#>     0.00000     0.00000     0.00000    68.19174     0.00000    68.19174 
#> 
#> $Outputs
#>      Decompose    Leak_Matrix  Leak_Biopores     Drain_Soil Drain_Biopores 
#>     44.3881377     13.4851340      0.3371014      0.3095327     13.5879370 
#>         Uptake          Total 
#>      0.0000000     72.1078427 
#> 
#> $InitialContent
#>   Content    Biopores   Total
#> 1 60.5101 9.80239e-19 60.5101
#> 
#> $FinalContent
#>   Content   Biopores    Total
#> 1  56.593 0.00147698 56.59448
#> 
#> $Balance
#>      Input   Output InOutChange InitialContent FinalContent ContentChange
#> 1 68.19174 72.10784    3.916101        60.5101     56.59448     -3.915623
#>        Balance
#> 1 0.0004779899
#> 
```
