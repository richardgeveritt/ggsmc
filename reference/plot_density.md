# A density of a single variable.

A density of a single variable.

## Usage

``` r
plot_density(
  output,
  parameter,
  dimension = 1,
  target = NULL,
  external_target = NULL,
  use_initial_points = TRUE,
  use_weights = TRUE,
  mcmc = FALSE,
  xlimits = NULL,
  ylimits = NULL,
  default_title = FALSE
)
```

## Arguments

- output:

  Output from the SMC or EnK algorithm.

- parameter:

  The parameter for which we wish to view the density.

- dimension:

  (optional) The dimension of the parameter for which we wish to view
  the density. (default is 1)

- target:

  (optional) The index of the target for which we wish to view the
  density. (default to all targets)

- external_target:

  (optional) The index of the external target to plot. (default is to
  use all external targets, or to ignore if the column is not present)

- use_initial_points:

  (optional) If target is not specified and this argument is TRUE, will
  add the initial unweighted proposed points to the output to be
  plotted. (default is TRUE)

- use_weights:

  (optional) If FALSE, will ignore particle weights in the density. If
  TRUE, will use the particle weights. (defaults to TRUE)

- mcmc:

  (optional) If TRUE, the user is indicating that the output is from an
  MCMC algorithm. This will set use_initial_points=FALSE and
  use_weights=FALSE no matter what the user sets these arguments to.
  (default is FALSE)

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

A density in a ggplot figure.
