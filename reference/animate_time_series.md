# Plot animated line graph showing parameter value vs dimension across targets from algorithm output.

Plot animated line graph showing parameter value vs dimension across
targets from algorithm output.

## Usage

``` r
animate_time_series(
  output,
  parameters,
  target = NULL,
  external_target = NULL,
  use_initial_points = TRUE,
  use_weights = TRUE,
  max_line_width = 1,
  alpha = 0.1,
  xlimits = NULL,
  ylimits = NULL,
  duration = NULL,
  animate_plot = TRUE,
  save_filename = NULL,
  save_path = NULL
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

- duration:

  (optional) The duration of the animation. (defaults to producing an
  animation that uses 10 frames per second)

- animate_plot:

  (optiional) If TRUE, will return an animation. If FALSE, returns a
  gganim object that can be further modified before animating. (defaults
  to FALSE)

- save_filename:

  (optional) If specified, the animation will be saved to a gif with
  this filename. (default is not to save)

- save_path:

  (optional) If specified along with save_filename, will save the gif to
  save_path/save_filename. (defaults to working directory)

## Value

An animated line graph, showing how the lines evolve through the
sequence of targets.
