% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Game_periodtiming.R
\name{ctimeLeft}
\alias{ctimeLeft}
\alias{ctimeLeft0}
\title{Gate Keeper}
\usage{
ctimeLeft(startTime = Sys.time(), etime, tfreq = 1000,
  ctime_title = "Minutes Remaining: ", TradePeriod = Sys.time(),
  savepath = paste0(getwd(), "/"), GameName = "Game_")

ctimeLeft0(startTime = Sys.time(), etime, tfreq = 1000,
  ctime_title = "Minutes Remaining: ")
}
\arguments{
\item{startTime}{a time object of what time this game started}

\item{etime}{a time object EndTime}

\item{tfreq}{how often to update in milliseconds}

\item{ctime_title}{what to print}

\item{TradePeriod}{which trading period is this?}

\item{savepath}{file to save to, normally tempdir() or getwd()}

\item{GameName}{name of file}
}
\value{
Message of time left in trading session or Save and Exit

Message of time left in trading session or Message
}
\description{
Gate Keeper

Gate Keeper
}
