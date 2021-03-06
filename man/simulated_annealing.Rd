% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/changepoints.R
\docType{methods}
\name{simulated_annealing}
\alias{simulated_annealing}
\alias{simulated_annealing,changepointsMod-method}
\title{Single change-point simulated annealing method}
\usage{
simulated_annealing(object, niter = 500, min_beta = 1e-04, buff = 100)

\S4method{simulated_annealing}{changepointsMod}(object, niter = 500,
  min_beta = 1e-04, buff = 100)
}
\arguments{
\item{object}{Corresponding \code{changepointsMod} class.}

\item{niter}{Number of simulated annealing iterations.}

\item{min_beta}{Lowest temperature.}

\item{buff}{Distance from edge of sample to be maintained during search.}
}
\value{
An updated version of the change-point model.  The update will effect:
        1) the \code{part_values} and/or \code{whole_values} (depending on the initial
        values provided).  2) An estimate for the current change-point.  3) The trace
        for the search.
}
\description{
Estimates a single change-point using the simulated annealing
             method.
}
\examples{
set.seed(334)

scp_data = read.table(system.file("extdata", "scp.txt", package="changepointsHD"))
scp_data = as.matrix(scp_data)

# prox gradient black-box method
cov_est = cov(scp_data)
init = solve(cov_est)
res_map = prox_gradient_mapping(scp_data, init, 0.1, 0.99, 0.1, 100, 1e-20)

# prox gradient black-box ll
res_ll = prox_gradient_ll(scp_data, res_map, 0.1)

prox_gradient_params=list()
prox_gradient_params$update_w = 0.1
prox_gradient_params$update_change = 0.99
prox_gradient_params$regularizer = 0.1
prox_gradient_params$max_iter = 1
prox_gradient_params$tol = 1e-5

prox_gradient_ll_params=list()
prox_gradient_ll_params$regularizer = 0.1

changepoints_mod = changepointsMod(bbmod=prox_gradient_mapping,
                                 log_likelihood=prox_gradient_ll,
                                 bbmod_params=prox_gradient_params,
                                 ll_params=prox_gradient_ll_params,
                                 part_values=list(init, init),
                                 data=list(scp_data))
changepoints_mod = simulated_annealing(changepoints_mod, buff=10)

}
\author{
\packageMaintainer{changepointsHD}
}
