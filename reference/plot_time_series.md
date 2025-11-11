# Plot line graph showing parameter value vs dimension from algorithm output.

Plot line graph showing parameter value vs dimension from algorithm
output.

## Usage

``` r
plot_time_series(
  output,
  parameters,
  target = NULL,
  external_target = NULL,
  use_initial_points = TRUE,
  use_weights = TRUE,
  mcmc = FALSE,
  max_line_width = 1,
  alpha = 0.1,
  xlimits = NULL,
  ylimits = NULL
)
```

## Arguments

- output:

  Output from the SMC or EnK algorithm.

- parameters:

  The parameters we wish to be on the y-axis of the line graph.

- target:

  (optional) The target to plot. (default is to use all targets)

- external_target:

  (optional) The external target to plot. (default is to use all
  external targets, or to ignore if the column is not present)

- use_initial_points:

  (optional) If target is not specified and this argument is TRUE, will
  add the initial unweighted proposed points to the output to be
  plotted. (default is TRUE)

- use_weights:

  (optional) If FALSE, will ignore particle weights in the line graph.
  If TRUE, will use the particle weights. (defaults to TRUE)

- mcmc:

  (optional) If TRUE, the user is indicating that the output is from an
  MCMC algorithm. This will set use_initial_points=FALSE and
  use_weights=FALSE no matter what the user sets these arguments to.
  (default is FALSE)

- max_line_width:

  (optional) The maximum size of the points in the plot. (default=1)

- alpha:

  (optional) The transparency of the lines in the plot. (default=0.1)

- xlimits:

  (optional) Input of the form c(start,end), which specifies the ends of
  the x-axis.

- ylimits:

  (optional) Input of the form c(start,end), which specifies the ends of
  the y-axis.

## Value

A line graph in a ggplot figure.
