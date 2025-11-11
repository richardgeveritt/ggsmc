# Convert IS, SMC or EnK output stored as a matrix to tidy format.

Convert IS, SMC or EnK output stored as a matrix to tidy format.

## Usage

``` r
matrix2tidy(output, parameter, target = 1, log_weights = NULL)
```

## Arguments

- output:

  Matrix output (one point per row) from an IS algorithm, or one target
  from a SMC or EnK algorithm.

- parameter:

  The name to assign the parameter in the tidy output.

- target:

  (optional) The target index to use in the tidy output (default 1).

- log_weights:

  (optional) The log_weights to use in the tidy output (default all
  equal).

## Value

The output in tidy format.
