# Merge a list of Dlfs

Merge a list of Dlfs

## Usage

``` r
merge_dlfs(dlfs, dlf_name_column = "name")
```

## Arguments

- dlfs:

  List of Dlfs

- dlf_name_column:

  Name of column to store name of dlf each row came from

## Value

A Dlf object with the data of the dlfs merged into a single dlf.

## Examples

``` r
data_dir <- system.file("extdata", package="daisytools")
dlfs <- read_dlf_dir(file.path(data_dir, "annual"))
dlfs <- dlfs[startsWith(names(dlfs), "Annual-FN")]
dlfs <- dir_names_to_columns(dlfs)
dlf <- merge_dlfs(dlfs)
head(dlf@data)
#>   year month mday hour Min_Surface_Fertilizer Min_Soil_Fertilizer Deposition
#> 1 1990     4    1    0                      0                   0    0.00000
#> 2 1991     4    1    0                    320                   0   12.84530
#> 3 1992     4    1    0                    335                   0   13.63430
#> 4 1993     4    1    0                      0                   0   14.95130
#> 5 1994     4    1    0                    229                   0   13.11080
#> 6 1995     4    1    0                    261                   0    9.70281
#>   Matrix_Leaching Biopore_Leaching Soil_Drain Biopore_Drain Surface_Loss
#> 1          0.0000                0          0             0    0.0000000
#> 2         12.2287                0          0             0    0.0698144
#> 3         14.2757                0          0             0    0.3711250
#> 4         33.3356                0          0             0    0.2864740
#> 5         13.7377                0          0             0    0.5379290
#> 6         13.4554                0          0             0    0.0230469
#>   Min_Surface Min_Soil Min_Biopores Error Mineralization Immobilization
#> 1   0.0645808 109.5910            0     0          0.000      0.0000000
#> 2   1.7593100 225.1570            0     0        119.125     22.9180000
#> 3   0.0698340 206.3060            0     0        129.158      0.0533642
#> 4   0.0428871 120.8470            0     0        155.922      5.9254000
#> 5   0.0730760  51.4192            0     0        114.886     26.7863000
#> 6   0.0337658 109.7640            0     0        148.570     25.3838000
#>   Crop_Uptake Volatilization N2O_Nitrification Denitrification Fixated
#> 1       0.000              0           0.00000         0.00000       0
#> 2     287.626              0           3.22254         8.64584       0
#> 3     476.260              0           4.93958         2.43211       0
#> 4     193.243              0           3.97177        19.59800       0
#> 5     376.475              0           3.89785         4.95836       0
#> 6     316.212              0           4.47952         1.41352       0
#>   Org_Fertilizer Seed Harvest Residuals_Surface Residuals_Soil Org_Surface
#> 1              0    0   0.000            0.0000         0.0000 1.47873e-27
#> 2              0    8 220.693           28.2517        18.7245 1.61339e-01
#> 3              0    2 239.467           96.1887        32.4722 2.59990e+01
#> 4              0    4 163.288          132.1440        28.4171 8.95188e-04
#> 5              0    4 235.210           96.6249        35.4884 1.03445e-03
#> 6              0    0 216.008           91.1801        33.6577 1.50152e-27
#>   Org_Soil     Crop       dir                   name
#> 1  26614.8   0.0000 Annual-FN HourlyP-Annual-FN-2-2b
#> 2  26565.4  27.9559 Annual-FN HourlyP-Annual-FN-2-2b
#> 3  26539.1 138.0880 Annual-FN HourlyP-Annual-FN-2-2b
#> 4  26575.7  11.4810 Annual-FN HourlyP-Annual-FN-2-2b
#> 5  26619.7  24.6333 Annual-FN HourlyP-Annual-FN-2-2b
#> 6  26621.3   0.0000 Annual-FN HourlyP-Annual-FN-2-2b
```
