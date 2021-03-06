% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Server_stopgame.R
\name{savegame}
\alias{savegame}
\title{Save Game}
\usage{
savegame(startTime = format(Sys.time(), "\%Y-\%m-\%d_\%H-\%M-\%S"),
  TradePeriod = format(Sys.time(), "\%Y-\%m-\%d_\%H-\%M-\%S"),
  savepath = paste0(tempdir(), "/"), GameName = "Game_",
  PeriodName = "_Period_")
}
\arguments{
\item{startTime}{what time did this game start at?}

\item{TradePeriod}{which trading period is this?}

\item{savepath}{file to save to}

\item{GameName, PeriodName}{name of file}
}
\value{
string, Name of Game File
}
\description{
Save Game
}
\details{
see https://shiny.rstudio.com/articles/persistent-data-storage.html
formerly used as.character(Sys.time()) , now format(Sys.time(), "%Y-%m-%d_%H-%M-%S")
}
