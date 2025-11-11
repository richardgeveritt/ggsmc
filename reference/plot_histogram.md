# A histogram of a single variable.

A histogram of a single variable.

## Usage

``` r
plot_histogram(
  output,
  parameter,
  dimension = 1,
  target = NULL,
  external_target = NULL,
  use_initial_points = TRUE,
  use_weights = TRUE,
  mcmc = FALSE,
  bins = 30,
  xlimits = NULL,
  ylimits = NULL,
  default_title = FALSE
)
```

## Arguments

- output:

  Output from the SMC or EnK algorithm.

- parameter:

  The parameter we wish to histogram.

- dimension:

  (optional) The dimension of the parameter we wish to histogram.
  (default is 1)

- target:

  (optional) The index of the target we wish to histogram. (default to
  all targets)

- external_target:

  (optional) The index of the external target to plot. (default is to
  use all external targets, or to ignore if the column is not present)

- use_initial_points:

  (optional) If target is not specified and this argument is TRUE, will
  add the initial unweighted proposed points to the output to be
  plotted. (default is TRUE)

- use_weights:

  (optional) If FALSE, will ignore particle weights in the histogram. If
  TRUE, will use the particle weights. (defaults to TRUE)

- mcmc:

  (optional) If TRUE, the user is indicating that the output is from an
  MCMC algorithm. This will set use_initial_points=FALSE and
  use_weights=FALSE no matter what the user sets these arguments to.
  (default is FALSE)

- bins:

  (optional) Number of bins for the histogram. (default 30)

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

A histogram in a ggplot figure.
