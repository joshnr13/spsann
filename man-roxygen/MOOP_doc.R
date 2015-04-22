#  Template documentation for multi-objective optimization problems (MOOP)
################################################################################
#' @param nadir List with four named sub-arguments: \code{sim} -- the number of
#' random realizations to estimate the nadir point; \code{save.sim} -- logical 
#' for saving the simulated values and returning them as an attribute of the 
#' optimized sample configuration; \code{user} -- a list of user-defined 
#' values named after the objective function to which they apply; 
#' \code{abs} -- logical for calculating the nadir point internally. 
#' Defaults to \code{sim = 1000}, \code{save.sim = TRUE}, \code{user = NULL}, 
#' and \code{abs = NULL}.
#'
#' @param utopia List with two named sub-arguments: \code{user} -- a list of
#' user-defined values named after the objective function to which they apply, 
#' and \code{abs} -- logical for calculating the utopia point internally. 
#' Defaults to \code{user = NULL} and \code{abs = NULL}.
#'
#' @references
#' Arora, J. \emph{Introduction to optimum design}. Waltham: Academic Press, p. 
#' 896, 2011.
#'
#' Marler, R. T.; Arora, J. S. Survey of multi-objective optimization methods 
#' for engineering. \emph{Structural and Multidisciplinary Optimization}, v. 26,
#' p. 369-395, 2004.
#' 
#' Marler, R. T.; Arora, J. S. Function-transformation methods for 
#' multi-objective optimization. \emph{Engineering Optimization}, v. 37, p. 
#' 551-570, 2005.
#'
#' Marler, R. T.; Arora, J. S. The weighted sum method for multi-objective 
#' optimization: new insights. \emph{Structural and Multidisciplinary 
#' Optimization}, v. 41, p. 853-862, 2009.

