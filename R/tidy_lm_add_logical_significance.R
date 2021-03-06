#' @title \code{tidy_lm_add_logical_significance}
#' @description add a logical column of significance comparing p-values to alpha
#' @author Ekarin Eric Pongpipat
#' @param tidy_df a \code{tidy} table of \code{lm} results
#' @param p_values = "p.value" (default). can specificy another column of p.values
#' @param alpha = 0.05 (default). can specify another alpha value
#' @param sig_column_name = "sig.05" (default). can specify another name for the new column (e.g., sig.alpha.value).
#'
#' @return logical column of significance (i.e., TRUE or FALSE) by comparing p
#' to the cut-off alpha. this column is added to a \code{tidy} table of a \code{lm}
#' @export
#'
#' @examples
#' packages <- c("broom", "broomExtra", "dplyr", "modelr", "tibble")
#' xfun::pkg_attach2(packages, message = F)
#'
#' data <- tibble(
#'   a = scale(sample.int(100), scale = F),
#'   b = scale(sample.int(100), scale = F),
#'   c = b^2,
#'   d = scale(sample.int(100), scale = F)
#' )
#'
#' lm(a ~ b, data) %>%
#'   tidy() %>%
#'   tidy_lm_add_logical_significance()
tidy_lm_add_logical_significance <- function(tidy_df, p_values = "p.value", alpha = 0.05, sig_column_name = "sig.05") {

  # load packages if not already ----
  packages <- c("broom", "dplyr", "modelr", "tibble")
  xfun::pkg_attach2(packages, message = F)

  tidy_df %>%
    rowwise() %>%
    mutate(!!sig_column_name := ifelse(as.numeric(eval(as.name(p_values))) < alpha, TRUE, FALSE)) %>%
    ungroup()
}
