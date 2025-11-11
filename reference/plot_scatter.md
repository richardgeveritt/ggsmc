# A histogram of a single variable from a single target

A histogram of a single variable from a single target

## Usage

``` r
plot_scatter(
  output,
  x_parameter,
  x_dimension = 1,
  y_parameter,
  y_dimension = 1,
  target = NULL,
  external_target = NULL,
  use_initial_points = TRUE,
  use_weights = TRUE,
  mcmc = FALSE,
  max_size = 1,
  alpha = 0.1,
  xlimits = NULL,
  ylimits = NULL,
  default_title = FALSE
)
```

## Arguments

- output:

  Output from the SMC or EnK algorithm.

- x_parameter:

  The parameter indexed by the x-axis.

- x_dimension:

  (optional) The dimension of the x-parameter we wish to histogram.
  (default is 1)

- y_parameter:

  The parameter indexed by the y-axis.

- y_dimension:

  (optional) The dimension of the y-parameter we wish to histogram.
  (default is 1)

- target:

  (optional) The index of the target we wish to plot. (default is to use
  all targets)

- external_target:

  (optional) The index of the external target to plot. (default is to
  use all external targets, or to ignore if the column is not present)

- use_initial_points:

  (optional) If target is not specified and this argument is TRUE, will
  add the initial unweighted proposed points to the output to be
  plotted. (default is TRUE)

- use_weights:

  (optional) If FALSE, will ignore particle weights in the scatter plot.
  If TRUE, will use the particle weights. (defaults to TRUE)

- mcmc:

  (optional) If TRUE, the user is indicating that the output is from an
  MCMC algorithm. This will set use_initial_points=FALSE and
  use_weights=FALSE no matter what the user sets these arguments to.
  (default is FALSE)

- max_size:

  (optional) The maximum size of the points in the plot. (default=1)

- alpha:

  (optional) The transparency of the points in the plot. (default=0.1)

- xlimits:

  (optional) Input of the form c(start,end), which specifies the ends of
  the x-axis.

- ylimits:

  (optional) Input of the form c(start,end), which specifies the ends of
  the y-axis.

- default_title:

  (optional) If TRUE, will provide a default title for the figure. If
  FALSE, no title is used. (defaults to FALSE)

## Value

A scatter plot in a ggplot figure.
