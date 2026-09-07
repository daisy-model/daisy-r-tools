# Reading dlf files

``` r

library(daisytools)
```

Daisy log files (.dlf) can be read with `read_dlf`. `read_dlf` can read
a single dlf file, a directory tree of dlf files produced by the daisy
spawn program, or a directory tree of dlf files in any order. When
called with just a path the function will automatically guess how it
should process the path. You can also explicitly control how the path is
processed by setting the mode parameter.

## Reading a single dlf file

We start by reading a single dlf file and inspect the contents. We use
the Soil chemical log that is bundled with `daisytools`.

``` r

data_dir <- system.file("extdata", package="daisytools")
path <- file.path(data_dir, "hourly/P2D-Daily-Soil_Chemical_110cm.dlf")
dlf <- read_dlf(path)
head(dlf)
#>   year month mday hour In_Matrix In_Biopores Leak_Matrix Leak_Biopores
#> 1 1995     1    1    0         0           0 -0.00020812             0
#>   Biopores to matrix Matrix to biopores Tillage Drain_Soil Drain_Biopores
#> 1                  0                  0       0          0              0
#>   Drain_Biopores_Indirect External Uptake  Decompose  Transform Content
#> 1                       0        0      0 0.00301612 0.00227715 60.5101
#>      Biopores Error       time
#> 1 9.80239e-19     0 1995-01-01
```

`read_dlf` returns an S4 object of class `Dlf`. The data in the dlf file
is stored in three *slots* in the `Dlf` object, `header`, `units`,
`data`

``` r

slotNames(dlf)
#> [1] "header" "units"  "data"
```

The `header` slot is a list of the metadata that is stored before the
actual data in the dlf file. The `units` slot is a `data.frame` with
unit information for each data column. The `data` slot is a `data.frame`
containing the data. A slot is accessed with the `@` operator

``` r

dlf@header
#> $info
#> [1] "dlf-0.0 -- Soil chemical (defined in 'log-std.dai')."
#> 
#> $VERSION
#> [1] "6.41"
#> 
#> $LOGFILE
#> [1] "P2D-Daily-Soil Chemical_110cm.dlf"
#> 
#> $RUN
#> [1] "Thu Aug 31 10:50:37 2023"
#> 
#> $COLUMN
#> [1] "*"
#> 
#> $CHEMICAL
#> [1] "P2d"
#> 
#> $INTERVAL
#> [1] "box [-110; none]"
#> 
#> $LOG
#> [1] "Content, transport and transformation of chemicals in the soil."
#> 
#> $SIMFILE
#> [1] "Sim2-1d-Maize-P2p-d.dai"
```

``` r

dlf@units
#>   year month mday hour In_Matrix In_Biopores Leak_Matrix Leak_Biopores
#> 1                           g/ha        g/ha        g/ha          g/ha
#>   Biopores to matrix Matrix to biopores Tillage Drain_Soil Drain_Biopores
#> 1               g/ha               g/ha    g/ha       g/ha           g/ha
#>   Drain_Biopores_Indirect External Uptake Decompose Transform Content Biopores
#> 1                    g/ha     g/ha   g/ha      g/ha      g/ha    g/ha     g/ha
#>   Error time
#> 1  g/ha
```

``` r

head(dlf@data)
#>   year month mday hour In_Matrix In_Biopores  Leak_Matrix Leak_Biopores
#> 1 1995     1    1    0         0           0 -0.000208120             0
#> 2 1995     1    1    1         0           0 -0.000207217             0
#> 3 1995     1    1    2         0           0 -0.000206316             0
#> 4 1995     1    1    3         0           0 -0.000205415             0
#> 5 1995     1    1    4         0           0 -0.000204516             0
#> 6 1995     1    1    5         0           0 -0.000203618             0
#>   Biopores to matrix Matrix to biopores Tillage Drain_Soil Drain_Biopores
#> 1                  0                  0       0          0              0
#> 2                  0                  0       0          0              0
#> 3                  0                  0       0          0              0
#> 4                  0                  0       0          0              0
#> 5                  0                  0       0          0              0
#> 6                  0                  0       0          0              0
#>   Drain_Biopores_Indirect External Uptake  Decompose  Transform Content
#> 1                       0        0      0 0.00301612 0.00227715 60.5101
#> 2                       0        0      0 0.00300712 0.00225974 60.5095
#> 3                       0        0      0 0.00299438 0.00223681 60.5090
#> 4                       0        0      0 0.00297959 0.00221215 60.5084
#> 5                       0        0      0 0.00296299 0.00218613 60.5078
#> 6                       0        0      0 0.00294491 0.00215918 60.5073
#>      Biopores Error                time
#> 1 9.80239e-19     0 1995-01-01 00:00:00
#> 2 9.80239e-19     0 1995-01-01 01:00:00
#> 3 9.80239e-19     0 1995-01-01 02:00:00
#> 4 9.80239e-19     0 1995-01-01 03:00:00
#> 5 9.80239e-19     0 1995-01-01 04:00:00
#> 6 9.80239e-19     0 1995-01-01 05:00:00
```

We can also directly access and assign columns of the `data` slot with
the `$` and `[[` operators

``` r

head(dlf$year)
#> [1] 1995 1995 1995 1995 1995 1995
dlf$year <- dlf$year + 2
head(dlf[["year"]])
#> [1] 1997 1997 1997 1997 1997 1997
dlf[[1, "year"]] <- dlf[[1, "year"]] + 10
dlf[[1, "year"]]
#> [1] 2007
```

## Reading a depth distributed output

Some log files contain the distribution of a variable over depth and
time. By default, these are detected and converted automatically by
`read_dlf`

``` r

data_dir <- system.file("extdata", package="daisytools")
path <- file.path(data_dir, "daily/DailyP/DailyP-Daily-WaterFlux.dlf")
dlf <- read_dlf(path)
head(dlf)
#>   year month mday hour       time z        q
#> 1 1990     4    2    0 1990-04-02 0 0.686972
```

It is possible to disable this conversion

``` r

dlf <- read_dlf(path, convert_depth=FALSE)
head(dlf@data)
#>   year month mday hour q..AT..0 q..AT.._1 q..AT.._2 q..AT.._3 q..AT.._5.5
#> 1 1990     4    2    0 0.686972  0.664115  0.639810  0.613606    0.544964
#> 2 1990     4    3    0 0.329720  0.352970  0.366516  0.364938    0.348601
#> 3 1990     4    4    0 0.569315  0.516165  0.471405  0.439645    0.368329
#> 4 1990     4    5    0 0.552182  0.524524  0.498476  0.475034    0.417101
#> 5 1990     4    6    0 0.804888  0.646426  0.542673  0.485918    0.416079
#> 6 1990     4    7    0 1.570560  1.363380  1.210070  1.119550    0.930901
#>   q..AT.._10.5 q..AT.._17 q..AT.._25 q..AT.._27 q..AT.._29 q..AT.._32
#> 1     0.395473  0.1758390 -0.1373070 -0.1917510 -0.2467020  -0.330268
#> 2     0.282690  0.1381080 -0.1074000 -0.1521690 -0.1988810  -0.271746
#> 3     0.239977  0.0853382 -0.1161460 -0.1516110 -0.1881500  -0.245412
#> 4     0.299468  0.1396660 -0.0768022 -0.1141330 -0.1515970  -0.208488
#> 5     0.401543  0.2106090 -0.0299863 -0.0702949 -0.1097060  -0.168058
#> 6     0.630331  0.3376000  0.0331176 -0.0148375 -0.0595477  -0.123222
#>   q..AT.._41 q..AT.._51 q..AT.._61 q..AT.._70 q..AT.._80 q..AT.._90 q..AT.._100
#> 1  -0.559167  -0.754909  -0.884317  -0.942759  -0.932900  -0.843949   -0.702253
#> 2  -0.477825  -0.668107  -0.809770  -0.891153  -0.916981  -0.864004   -0.742204
#> 3  -0.417952  -0.596269  -0.741473  -0.836358  -0.888721  -0.869585   -0.774717
#> 4  -0.364315  -0.527612  -0.670777  -0.774113  -0.847243  -0.858932   -0.795311
#> 5  -0.317816  -0.468775  -0.604728  -0.709181  -0.794624  -0.830994   -0.799368
#> 6  -0.275118  -0.418583  -0.547307  -0.649482  -0.740437  -0.793534   -0.789338
#>   q..AT.._106 q..AT.._113 q..AT.._120 q..AT.._130 q..AT.._140 q..AT.._150
#> 1   -0.617684   -0.542156   -0.506693   -0.485376   -0.474339   -0.468794
#> 2   -0.658718   -0.575409   -0.531014   -0.500800   -0.483058   -0.472987
#> 3   -0.698181   -0.612140   -0.560251   -0.521052   -0.495913   -0.480430
#> 4   -0.731257   -0.648933   -0.592579   -0.545376   -0.512758   -0.491275
#> 5   -0.752059   -0.680330   -0.624036   -0.571390   -0.532342   -0.504967
#> 6   -0.759415   -0.702805   -0.650985   -0.596342   -0.552809   -0.520364
#>   q..AT.._160 q..AT.._170 q..AT.._180 q..AT.._190 q..AT.._200       time
#> 1   -0.465219   -0.461336   -0.455971   -0.448890   -0.440634 1990-04-02
#> 2   -0.466757   -0.461693   -0.456230   -0.449771   -0.442516 1990-04-03
#> 3   -0.470671   -0.463653   -0.457440   -0.451061   -0.444343 1990-04-04
#> 4   -0.477233   -0.467510   -0.459866   -0.452966   -0.446243 1990-04-05
#> 5   -0.486273   -0.473285   -0.463609   -0.455604   -0.448307 1990-04-06
#> 6   -0.497141   -0.480642   -0.468524   -0.458941   -0.450557 1990-04-07
```

## Reading Daisy spawn output

Daisy spawn produces a directory hierarchy where each directory contains
the same log files. We use the Daisy spawn outputs that are bundled with
`daisytools`.

``` r

data_dir <- system.file("extdata", package="daisytools")
path <- file.path(data_dir, "daisy-spawn-like")
list.files(path, recursive=TRUE)
#>  [1] "Pig_JB1_Free/FWater200-Y.dlf"   "Pig_JB1_Free/Harvest.dlf"      
#>  [3] "Pig_JB6_Free/FWater200-Y.dlf"   "Pig_JB6_Free/Harvest.dlf"      
#>  [5] "Pig_JB6_Pipe/FWater200-Y.dlf"   "Pig_JB6_Pipe/Harvest.dlf"      
#>  [7] "Plant_JB1_Free/FWater200-Y.dlf" "Plant_JB1_Free/Harvest.dlf"    
#>  [9] "Plant_JB6_Free/FWater200-Y.dlf" "Plant_JB6_Free/Harvest.dlf"    
#> [11] "Plant_JB6_Pipe/FWater200-Y.dlf" "Plant_JB6_Pipe/Harvest.dlf"
```

Notice that each directory contains the same log files.

``` r

dlfs <- read_dlf(path)
```

Instead of a single Dlf object, we now get a named list of Dlf objects

``` r

typeof(dlfs)
#> [1] "list"
dlf_names <- names(dlfs)
dlf_names
#> [1] "FWater200-Y" "Harvest"
```

The list names correspond to the log types that was read. All logs of
the same type are concatenated together, and an extra column is added to
the data field. The name of the column is “sim” by default, but can be
set by passing `col_name="MySimulationName"` to `read_dlf`.

``` r

name <- dlf_names[1]
name
#> [1] "FWater200-Y"
head(dlfs[[name]]@data)
#>   year month mday hour Precipitation Irrigation Potential evapotranspiration
#> 1 1998     4    1    1         0.000     0.0000                        0.000
#> 2 1999     4    1    0       780.275    32.0638                      432.102
#> 3 2000     4    1    0       694.900   154.1280                      540.430
#> 4 2001     4    1    0       613.400   120.0000                      461.553
#> 5 2002     4    1    0       741.100   182.0640                      555.994
#> 6 2003     4    1    0       667.500   152.0640                      550.955
#>   Actual evapotranspiration Matrix percolation Biopore percolation
#> 1                     0.000              0.000                   0
#> 2                   430.230            369.561                   0
#> 3                   525.957            310.769                   0
#> 4                   459.680            332.422                   0
#> 5                   554.361            352.533                   0
#> 6                   536.742            321.130                   0
#>   Matrix drain flow Biopore drain flow Runoff Biopore water Soil matrix water
#> 1                 0                  0      0             0           338.695
#> 2                 0                  0      0             0           351.230
#> 3                 0                  0      0             0           363.544
#> 4                 0                  0      0             0           304.808
#> 5                 0                  0      0             0           321.113
#> 6                 0                  0      0             0           282.804
#>   Surface water          sim                time
#> 1  -3.46945e-18 Pig_JB1_Free 1998-04-01 01:00:00
#> 2   1.27177e-02 Pig_JB1_Free 1999-04-01 00:00:00
#> 3   0.00000e+00 Pig_JB1_Free 2000-04-01 00:00:00
#> 4   3.43973e-02 Pig_JB1_Free 2001-04-01 00:00:00
#> 5   0.00000e+00 Pig_JB1_Free 2002-04-01 00:00:00
#> 6   0.00000e+00 Pig_JB1_Free 2003-04-01 00:00:00
unique(dlfs[[name]]$sim)
#> [1] "Pig_JB1_Free"   "Pig_JB6_Free"   "Pig_JB6_Pipe"   "Plant_JB1_Free"
#> [5] "Plant_JB6_Free" "Plant_JB6_Pipe"
```

## Reading a directory with dlf files

We use the tracer and field nitrogen logs that are bundled with
`daisytools` and read them with `read_dlf_dir`

``` r

data_dir <- system.file("extdata", package="daisytools")
path <- file.path(data_dir, "annual")
list.files(path, pattern=".*dlf", recursive=TRUE)
#> [1] "Annual-FN/HourlyP-Annual-FN-2-2b.dlf"        
#> [2] "Annual-FN/HourlyP-Annual-FN-2-3b.dlf"        
#> [3] "Annual-FN/HourlyP-Annual-FN-2-4b.dlf"        
#> [4] "Annual-FN/HourlyP-Annual-FN-2-5b.dlf"        
#> [5] "Annual-Tracer/HourlyP-Annual-Tracer-2-2b.dlf"
#> [6] "Annual-Tracer/HourlyP-Annual-Tracer-2-3b.dlf"
#> [7] "Annual-Tracer/HourlyP-Annual-Tracer-2-4b.dlf"
#> [8] "Annual-Tracer/HourlyP-Annual-Tracer-2-5b.dlf"
```

Notice that the directories contains a different set of log files.

``` r

dlfs <- read_dlf(path)
```

Instead of a single Dlf object, we now get a named list of Dlf objects

``` r

names(dlfs)
#> [1] "Annual-FN/HourlyP-Annual-FN-2-2b"        
#> [2] "Annual-FN/HourlyP-Annual-FN-2-3b"        
#> [3] "Annual-FN/HourlyP-Annual-FN-2-4b"        
#> [4] "Annual-FN/HourlyP-Annual-FN-2-5b"        
#> [5] "Annual-Tracer/HourlyP-Annual-Tracer-2-2b"
#> [6] "Annual-Tracer/HourlyP-Annual-Tracer-2-3b"
#> [7] "Annual-Tracer/HourlyP-Annual-Tracer-2-4b"
#> [8] "Annual-Tracer/HourlyP-Annual-Tracer-2-5b"
```

The list of names correspond to file paths, which can be a bit unwieldy.
We can either manually change the names or use the convenience functions
`drop_dir_from_names` and `strip_common_prefix_from_names`

``` r

dlfs <- drop_dir_from_names(dlfs)
names(dlfs)
#> [1] "HourlyP-Annual-FN-2-2b"     "HourlyP-Annual-FN-2-3b"    
#> [3] "HourlyP-Annual-FN-2-4b"     "HourlyP-Annual-FN-2-5b"    
#> [5] "HourlyP-Annual-Tracer-2-2b" "HourlyP-Annual-Tracer-2-3b"
#> [7] "HourlyP-Annual-Tracer-2-4b" "HourlyP-Annual-Tracer-2-5b"
dlfs <- strip_common_prefix_from_names(dlfs)
names(dlfs)
#> [1] "FN-2-2b"     "FN-2-3b"     "FN-2-4b"     "FN-2-5b"     "Tracer-2-2b"
#> [6] "Tracer-2-3b" "Tracer-2-4b" "Tracer-2-5b"
```

``` r

name <- names(dlfs)[1]
name
#> [1] "FN-2-2b"
dlfs[[name]]@header
#> $info
#> [1] "dlf-0.0 -- Field nitrogen (defined in 'log-std.dai')."
#> 
#> $VERSION
#> [1] "6.41"
#> 
#> $LOGFILE
#> [1] "Annual-FN.dlf"
#> 
#> $RUN
#> [1] "Mon Aug 28 16:37:22 2023"
#> 
#> $COLUMN
#> [1] "*"
#> 
#> $INTERVAL
#> [1] "box none"
#> 
#> $LOG
#> [1] "Nitrogen input, output, transformation and content for the system.\n\nThe intended use of this log is large scale nitrogen balance, for\nexample reservoir management. It provide information about how\nmuch nitrogen is in the field (down to a specified depth), where\nit is located in the field (surface, soil matrix or in biopores),\nwhat form is has (crop, soil organic matter, or mineral) as well\nas the sources, sinks and amounts of nitrogen entering or leaving\nthe system, and transformation between the four forms.  It does\nnot provide information about internal translocation of nitrogen\nbetween surface, soil matrix and biopores, use see the 'Soil\nnitrogen' log instead for that.\n\nFor the balances of this log to work, you must include the entire\nroot zone"
#> 
#> $SIMFILE
#> [1] "Runfile2b.dai"
#> 
#> $SIM
#> [1] "Arable farm rotation; Soil: 1D/ResFarm/Free; Weather: Daily values and P hourly values"
```

### Controlling which files are included

`read_dlf` takes an optional pattern parameter that is used for modes
“spawn” and “dir” and controls which files are included. By default all
files with the suffix `.dlf` are included. If we only want to read files
ending with `2b.dlf`, we can do

``` r

data_dir <- system.file("extdata", package="daisytools")
path <- file.path(data_dir, "annual")
dlfs <- read_dlf(path, pattern=".*2b\\.dlf")
names(dlfs)
#> [1] "Annual-FN/HourlyP-Annual-FN-2-2b"        
#> [2] "Annual-Tracer/HourlyP-Annual-Tracer-2-2b"
```

`pattern` is a regular expression. You should around with it and see if
you can find a shorter pattern that results in the same files being
read.
