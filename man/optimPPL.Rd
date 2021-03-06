% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/optimPPL.R
\name{optimPPL}
\alias{PPL}
\alias{countPPL}
\alias{objPPL}
\alias{optimPPL}
\title{Optimization of sample configurations for variogram identification and estimation}
\usage{
optimPPL(points, candi, lags = 7, lags.type = "exponential",
  lags.base = 2, cutoff, criterion = "distribution", distri,
  pairs = FALSE, schedule = scheduleSPSANN(), plotit = FALSE,
  track = FALSE, boundary, progress = "txt", verbose = FALSE)

objPPL(points, candi, lags = 7, lags.type = "exponential", lags.base = 2,
  cutoff, distri, criterion = "distribution", pairs = FALSE, x.max, x.min,
  y.max, y.min)

countPPL(points, candi, lags = 7, lags.type = "exponential",
  lags.base = 2, cutoff, pairs = FALSE, x.max, x.min, y.max, y.min)
}
\arguments{
\item{points}{Integer value, integer vector, data frame or matrix. If \code{points} is an integer value, 
it defines the number of points that should be randomly sampled from \code{candi} to form the starting 
system configuration. If \code{points} is a vector of integer values, it contains the row indexes of 
\code{candi} that correspond to the points that form the starting system configuration. If \code{points} 
is a data frame or matrix, it must have three columns in the following order: \code{[, "id"]} the row 
indexes of \code{candi} that correspond to each point, \code{[, "x"]} the projected x-coordinates, and 
\code{[, "y"]} the projected y-coordinates. Note that in the later case, \code{points} must be a subset 
of \code{candi}.}

\item{candi}{Data frame or matrix with the candidate locations for the jittered points. \code{candi} must 
have two columns in the following order: \code{[, "x"]} the projected x-coordinates, and \code{[, "y"]} the 
projected y-coordinates.}

\item{lags}{Integer value, the number of lag-distance classes. Alternatively, a vector of numeric values 
with the lower and upper bounds of each lag-distance class, the lowest value being larger than zero 
(e.g. 0.0001). Defaults to \code{lags = 7}.}

\item{lags.type}{Character value, the type of lag-distance classes, with options \code{"equidistant"} and
\code{"exponential"}. Defaults to \code{lags.type = "exponential"}.}

\item{lags.base}{Numeric value, base of the exponential expression used to create exponentially spaced 
lag-distance classes. Used only when \code{lags.type = "exponential"}. Defaults to \code{lags.base = 2}.}

\item{cutoff}{Numeric value, the maximum distance up to which lag-distance classes are created. Used only
when \code{lags} is an integer value. If missing, it is set to be equal to the length of the diagonal of 
the rectagle with sides \code{x.max} and \code{y.max} as defined in \code{\link[spsann]{scheduleSPSANN}}.}

\item{criterion}{Character value, the feature used to describe the energy state of the system 
configuration, with options \code{"minimum"} and \code{"distribution"}. Defaults to 
\code{objective = "distribution"}.}

\item{distri}{Numeric vector, the distribution of points or point-pairs per lag-distance class that should 
be attained at the end of the optimization. Used only when \code{criterion = "distribution"}. Defaults to 
a uniform distribution.}

\item{pairs}{Logical value. Should the sample configuration be optimized regarding the number of 
point-pairs per lag-distance class? Defaults to \code{pairs = FALSE}.}

\item{schedule}{List with 11 named sub-arguments defining the control parameters of the cooling schedule. 
See \code{\link[spsann]{scheduleSPSANN}}.}

\item{plotit}{Logical for plotting the optimization results, including a) the progress of the objective
function, and b) the starting (gray) and current system configuration (black), and the maximum jitter in 
the x- and y-coordinates. The plots are updated at each 10 jitters. Defaults to \code{plotit = FALSE}.}

\item{track}{Logical value. Should the evolution of the energy state be recorded and returned with the 
result? If \code{track = FALSE} (the default), only the starting and ending energy states are returned with
the results.}

\item{boundary}{SpatialPolygon defining the boundary of the spatial domain. If missing and 
\code{plotit = TRUE}, \code{boundary} is estimated from \code{candi}.}

\item{progress}{Type of progress bar that should be used, with options \code{"txt"}, for a text progress 
bar in the R console, \code{"tk"}, to put up a Tk progress bar widget, and \code{NULL} to omit the progress
bar. A Tk progress bar widget is useful when using parallel processors. Defaults to 
\code{progress = "txt"}.}

\item{verbose}{Logical for printing messages about the progress of the optimization. Defaults to 
\code{verbose = FALSE}.}

\item{x.max}{Numeric value defining the minimum and maximum quantity of random noise to 
be added to the projected x- and y-coordinates. The minimum quantity should be equal to, at least, the 
minimum distance between two neighbouring candidate locations. The units are the same as of the projected 
x- and y-coordinates. If missing, they are estimated from \code{candi}.}

\item{x.min}{Numeric value defining the minimum and maximum quantity of random noise to 
be added to the projected x- and y-coordinates. The minimum quantity should be equal to, at least, the 
minimum distance between two neighbouring candidate locations. The units are the same as of the projected 
x- and y-coordinates. If missing, they are estimated from \code{candi}.}

\item{y.max}{Numeric value defining the minimum and maximum quantity of random noise to 
be added to the projected x- and y-coordinates. The minimum quantity should be equal to, at least, the 
minimum distance between two neighbouring candidate locations. The units are the same as of the projected 
x- and y-coordinates. If missing, they are estimated from \code{candi}.}

\item{y.min}{Numeric value defining the minimum and maximum quantity of random noise to 
be added to the projected x- and y-coordinates. The minimum quantity should be equal to, at least, the 
minimum distance between two neighbouring candidate locations. The units are the same as of the projected 
x- and y-coordinates. If missing, they are estimated from \code{candi}.}
}
\value{
\code{optimPPL} returns an object of class \code{OptimizedSampleConfiguration}: the optimized sample
configuration with details about the optimization.

\code{objPPL} returns a numeric value: the energy state of the sample configuration -- the objective 
function value.

\code{countPPL} returns a data.frame with three columns: a) the lower and b) upper limits of each 
lag-distance class, and c) the number of points or point-pairs per lag-distance class.
}
\description{
Optimize a sample configuration for variogram identification and estimation. A criterion is defined so that
the optimized sample configuration has a given number of points or point-pairs contributing to each 
lag-distance class (\bold{PPL}).
}
\details{
Details about the mechanism used to generate a new sample configuration out of the current sample 
configuration by randomly perturbing the coordinates of a sample point are available in the help page of
\code{\link[spsann]{spJitter}}.

\subsection{Lag-distance classes}{
Two types of lag-distance classes can be created by default. The first are evenly spaced lags 
(\code{lags.type = "equidistant"}). They are created by simply dividing the distance interval from 0.0001 
to \code{cutoff} by the required number of lags. The minimum value of 0.0001 guarantees that a point does 
not form a pair with itself. The second type of lags is defined by exponential spacings 
(\code{lags.type = "exponential"}). The spacings are defined by the base \eqn{b} of the exponential 
expression \eqn{b^n}, where \eqn{n} is the required number of lags. The base is defined using the argument 
\code{lags.base}. See \code{\link[pedometrics]{vgmLags}} for other details.

Using the default uniform distribution means that the number of point-pairs per lag-distance class 
(\code{pairs = TRUE}) is equal to \eqn{n \times (n - 1) / (2 \times lag)}, where \eqn{n} is the total 
number of points and \eqn{lag} is the number of lags. If \code{pairs = FALSE}, then it means that the 
number of points per lag is equal to the total number of points. This is the same as expecting that each 
point contributes to every lag. Distributions other than the available options can be easily implemented 
changing the arguments \code{lags} and \code{distri}.

There are two optimizing criteria implemented. The first is called using \code{criterion = "distribution"}
and is used to minimize the sum of the absolute differences between a pre-specified distribution and the
observed distribution of points or point-pairs per lag-distance class. The second criterion is called using
\code{criterion = "minimum"}. It corresponds to maximizing the minimum number of points or point-pairs 
observed over all lag-distance classes.
}
}
\note{
The distance between two points is computed as the Euclidean distance between them. This computation 
assumes that the optimization is operating in the two-dimensional Euclidean space, i.e. the coordinates of
the sample points and candidate locations should not be provided as latitude/longitude. \pkg{spsann} has no 
mechanism to check if the coordinates are projected: the user is responsible for making sure that this
requirement is attained.
}
\examples{
\dontrun{
# This example takes more than 5 seconds
require(sp)
data(meuse.grid)
candi <- meuse.grid[, 1:2]
schedule <- scheduleSPSANN(chains = 1, initial.temperature = 30,
                           x.max = 1540, y.max = 2060, x.min = 0, 
                           y.min = 0, cellsize = 40)
set.seed(2001)
res <- optimPPL(points = 10, candi = candi, schedule = schedule)
objSPSANN(res) - objPPL(points = res, candi = candi)
countPPL(points = res, candi = candi)
}
}
\author{
Alessandro Samuel-Rosa \email{alessandrosamuelrosa@gmail.com}
}
\references{
Bresler, E.; Green, R. E. \emph{Soil parameters and sampling scheme for characterizing soil hydraulic
properties of a watershed}. Honolulu: University of Hawaii at Manoa, p. 42, 1982.

Pettitt, A. N.; McBratney, A. B. Sampling designs for estimating spatial variance components. 
\emph{Applied Statistics}. v. 42, p. 185, 1993.

Russo, D. Design of an optimal sampling network for estimating the variogram. \emph{Soil Science Society of
America Journal}. v. 48, p. 708-716, 1984.

Truong, P. N.; Heuvelink, G. B. M.; Gosling, J. P. Web-based tool for expert elicitation of the variogram.
\emph{Computers and Geosciences}. v. 51, p.
390-399, 2013.

Warrick, A. W.; Myers, D. E. Optimization of sampling locations for variogram calculations. \emph{Water 
Resources Research}. v. 23, p. 496-500, 1987.
}
\concept{
simulated annealing

variogram
}
\keyword{iteration}
\keyword{optimize}
\keyword{spatial}

