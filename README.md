# ggsmc

This R package contains functions for plotting, and animating, the output of importance samplers, SMC samplers and ensemble-based methods. Functions for plotting and animating histograms, densities, scatter plots, time series are provided, along with a function for plotting the genealogy of an SMC or ensemble-based algorithms. These functions all rely on algorithm output to be supplied in tidy format. A function is provided to transform algorithm output from matrix format (one Monte Carlo point per row) to the tidy format required by the plotting and animating functions.

The package can be installed using:

```
devtools::install_github("richardgeveritt/ggsmc")
```

Examples of how to use the package can be found in [this vignette](https://richardgeveritt.github.io/ggsmc/articles/Visualising.html).

 <!-- badges: start -->
  [![R-CMD-check](https://github.com/richardgeveritt/ggsmc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/richardgeveritt/ggsmc/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->
