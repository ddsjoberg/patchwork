#' Prep Plot for Arithmetic
#'
#' @description
#' This function is used internally in the patchwork arithmetic operators,
#' e.g. `|` or `/`.
#' The default method wraps plot objects in `wrap_elements()` as needed, preparing
#' the plot to be processed by the arithmetic operators.
#'
#' Implement custom methods if you wish objects of other classes to be compatible
#' with the patchwork arithmetic operators.
#'
#' @param x a plot object
#' @param ... passed to other methods
#'
#' @return A `patchwork` object
#' @name arithmetic_prep
#'
#' @examples
#' library(ggplot2)
#'
#' p <- ggplot(mtcars, aes(x = mpg, y = hp)) + geom_point()
#'
#' arithmetic_prep(p)
NULL

#' @export
#' @rdname arithmetic_prep
arithmetic_prep <- function(x, ...) {
  UseMethod("arithmetic_prep")
}

#' @importFrom grid is.grob
#' @importFrom grDevices is.raster
#' @export
#' @rdname arithmetic_prep
arithmetic_prep.default <- function(x, ...) {
  # wrap input plot as needed
  if (is.grob(x) || inherits(x, 'formula') || is.raster(x) || inherits(x, 'nativeRaster')) {
    x <- wrap_elements(full = x)
  }
  x
}
