# A histogram of a single variable from a single target.

A histogram of a single variable from a single target.

## Usage

``` r
animate_scatter(
  output,
  x_parameter,
  x_dimension,
  y_parameter,
  y_dimension,
  target = NULL,
  external_target = NULL,
  use_initial_points = TRUE,
  use_weights = TRUE,
  mcmc = FALSE,
  max_size = 1,
  alpha = 0.1,
  xlimits = NULL,
  ylimits = NULL,
  default_title = FALSE,
  view_follow = FALSE,
  shadow_mark_proportion_of_max_size = NULL,
  shadow_wake_length = NULL,
  duration = NULL,
  animate_plot = TRUE,
  save_filename = NULL,
  save_path = NULL
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

  (optionaL) If specified, will fix to this target, and animate over
  ExternalTarget (if present in output).

- external_target:

  (optionaL) If specified, will fix to this external_target, and animate
  over Target.

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

- view_follow:

  (optional) If TRUE, the view will follow the particles. (default
  FALSE)

- shadow_mark_proportion_of_max_size:

  (optional) If set, the animation will leave behind shadow points, of a
  size (and transparency) specified by this proportion. (default to not
  set)

- shadow_wake_length:

  (optional) If set, the animation will leave a shadow wake behind each
  point, of a duration given by this parameter (proportion of the entire
  animation length). (default to not set)

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

A scatter plot in a ggplot figure.
