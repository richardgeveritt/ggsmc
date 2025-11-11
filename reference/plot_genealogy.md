# Plot an SMC or EnK genealogy from algorithm output.

Plot an SMC or EnK genealogy from algorithm output.

## Usage

``` r
plot_genealogy(
  output,
  parameter,
  dimension = 1,
  target = NULL,
  external_target = NULL,
  use_initial_points = TRUE,
  use_weights = TRUE,
  alpha_points = 0.1,
  alpha_lines = 0.1,
  axis_limits = NULL,
  vertical = TRUE,
  arrows = TRUE,
  default_title = FALSE
)
```

## Arguments

- output:

  Output from the SMC or EnK algorithm.

- parameter:

  The parameter we wish to see the evolution of.

- dimension:

  (optional) The dimension of the parameter we wish to see the evolution
  of. (default is 1)

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

- alpha_points:

  (optional) The transparency of the points in the plot. (default=0.1)

- alpha_lines:

  (optional) The transparency of the lines in the plot. (default=0.1)

- axis_limits:

  (optional) Input of the form c(start,end), which specifies the ends of
  the parameter axis.

- vertical:

  (optional) If TRUE (default), plots a genealogy vertically. If FALSE,
  plots horizontally.

- arrows:

  (optional) If TRUE (default), includes arrowheads. If FALSE,
  arrowheads are omitted.

- default_title:

  (optional) If TRUE, will provide a default title for the figure. If
  FALSE, no title is used. (defaults to FALSE)

## Value

A particle genealogy in a ggplot figure.
