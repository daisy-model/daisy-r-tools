# Plot one or more timepoints from one or more dlfs containing depth dependent time series

Plot one or more timepoints from one or more dlfs containing depth
dependent time series

## Usage

``` r
plot_dlf_depth(
  dlfs,
  x_var = NULL,
  time_points = NULL,
  y_var = "z",
  time_var = "time",
  x_label = "",
  y_label = "",
  legend_name = "dlf",
  title = "",
  num_samples = 4
)
```

## Arguments

- dlfs:

  An S4 object of class Dlf or a list of Dlf objects

- x_var:

  Name of variable on x axis. If NULL assume it is the column that is
  not y_var or time_var

- time_points:

  List or vector of time points to plot. All dlfs must have data for all
  time points. If NULL then sample random time points.

- y_var:

  Name of variable on y axis

- time_var:

  Name of time variable

- x_label:

  Label for x axis (unit will be appended)

- y_label:

  Label for y axis (unit will be appended)

- legend_name:

  Name to use for legend

- title:

  Plot title (time point will be appended)

- num_samples:

  How many time points to sample when time_points is NULL

## Value

ggplot2 object
