% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Game_payouts.R
\name{random.payouts}
\alias{random.payouts}
\title{Payouts}
\usage{
random.payouts(Participants, base = 0, in0 = 2,
  out0 = length(Participants[[1]]$History), randseed = NULL)
}
\arguments{
\item{base}{a base rate to pay them (showup fee)}

\item{in0}{first period to sample from (ignore early histories)}

\item{out0}{last period to sample from}

\item{participants}{List of Participants}

\item{pass}{initial seed}
}
\value{
payouts for each person
}
\description{
Payouts
}
