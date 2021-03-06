\name{get_historical_data_recursive}
\alias{get_historical_data_recursive}
\title{Download historical climate data recursively}
\usage{
  get_historical_data_recursive(locator, cvar, time_scale)
}
\arguments{
  \item{locator}{The ISO3 country code that you want data
  about.
  (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or
  the basin ID [1-468]. The historical period for country
  is 1901 - 2009, and 1960 - 2009 for basin}

  \item{cvar}{The climate variable you're interested in.
  "\emph{pr}" for precipitation, "\emph{tas}" for
  temperature in celcius.}

  \item{time_scale}{The time scale you want to return
  values on.  Must be "\emph{month}", "\emph{year}" or
  "\emph{decade}"}
}
\value{
  a dataframe with historical climate data
}
\description{
  Recursively get historical data
}
\details{
  The time_scale parameter returns a different number of
  variables depending on the input timescale. \emph{Month}
  will return 12 values, a historical average for that
  month across all years.  \emph{Year} will return yearly
  averages for each year, and \emph{decade} will return
  decade averages.
}

