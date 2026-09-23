# \[ indexing on the data part of the dlf

\[ indexing on the data part of the dlf

## Usage

``` r
# S4 method for class 'Dlf'
x[i, j]
```

## Arguments

- x:

  The dlf object

- i:

  Name or index of row OR if j is missing, name or index of column

- j:

  Name or index of column

## Value

If `j` is missing, a `data.frame` containing the selected rows from the
data slot. Otherwise, the result of subsetting the data slot by rows and
columns, typically a vector for a single selected column or a
`data.frame` for multiple columns.
