#' dumbr function
#'
#' Shuffles your data set and makes it anonymous
#'
#' NB! Note that the function uses the values in your data. If it contains ID variables such as
#' social security numbers its values will still appear in the output.
#' If you use a n that is higher than the number of rows in your original data,
#' duplicates may appear which may be relevant for ID variables.
#'
#' @param x a data set of class data.frame, tibble or matrix
#' @param n the number of rows in the returned object
#' @param slow randomization method. If TRUE, the function uses a randomizing function from the random package, which takes a little more computing time. If FALSE, the function uses R´s built in random number generator, which teoretically is less safe. Defaults to TRUE.
#'
#' @return An object of the same class as x.
#'
#' @examples
#' dumbr(starwars, n = 10, slow = TRUE)
#'
#' @export
### dumbr function

dumbr <- function(x, n = nrow(x), slow = TRUE, sens_cols = NULL){
if("data.frame" %in% class(x) | "matrix" %in% class(x)){
  # require packages
  require(magrittr)
  require(dplyr)

  # drop sens cols
  if(!is.null(sens_cols)){
    x <- x %>%
      select(-sens_cols)
  }

  # Get random number to base shuffling on
  if(slow == TRUE) { # Really randomized shuffling
    # depends on random pkg
    require(random)
    randomnums <- randomSequence(min = 1, max = dim(x)[1] * dim(x)[2]) %>%
      matrix(ncol = dim(x)[2]) %>%
      apply(2, rank)
  }
  else { # not so randomized shuffling
    randomnums <- sample(1:(dim(x)[1] * dim(x)[2])) %>%
      matrix(ncol = dim(x)[2]) %>%
      apply(2, rank)
  }

  # reorder data according to random number matrix
  out_data <- tibble(do.call(cbind,lapply(1:ncol(x), function(y)  x[randomnums[y,],][,y]))) %>%
    # sample n rows
    slice_sample(., n = n)

  return(out_data)
}
  else{
    stop("x is not of class matrix or data.frame")
  }
}

