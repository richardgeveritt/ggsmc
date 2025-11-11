# An animated histogram of a single variable across targets.

An animated histogram of a single variable across targets.

## Usage

``` r
animate_histogram(
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
  default_title = FALSE,
  duration = NULL,
  animate_plot = TRUE,
  save_filename = NULL,
  save_path = NULL
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

An animated histogram
