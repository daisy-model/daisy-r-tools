# \[\[ indexing on the data part of the dlf

\[\[ indexing on the data part of the dlf

## Usage

``` r
# S4 method for class 'Dlf'
x[[i, j]]
```

## Arguments

- x:

  The dlf object

- i:

  Name or index of row OR if j is missing, name or index of column

- j:

  Name or index of column

## Value

If `j` is missing, the selected column from the data slot as the
underlying column vector. Otherwise, the single value stored at row `i`
and column `j`.
