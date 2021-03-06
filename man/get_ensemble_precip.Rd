\name{get_ensemble_precip}
\alias{get_ensemble_precip}
\title{Download ensemble precipitation data}
\usage{
  get_ensemble_precip(locator, type, start, end)
}
\arguments{
  \item{locator}{A vector of either watershed basin ID's
  from
  http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf
  It can be just a single basin id, or a vector of ids.
  ids should be strings.}

  \item{type}{the type of data to retrieve, must be "mavg"
  for monthly averages, "annualavg" for annual averages,
  "manom" for monthly anomaly, and "annualanom" for annual
  anomaly.}

  \item{start}{the start year to gather data for.}

  \item{end}{the end year to gather data to.}
}
\value{
  a dataframe with precipitation predictions in mm for all
  scenarios, gcms, for each time period.
}
\description{
  Function wraps get_ensemble_climate_data() and returns
  precipitation by basin or country in mm.  Output is the
  10th 50th and 90th percentile for all gcm's for the a1
  and b2 scenarios.
}
\details{
  start and end year can be any years, but all years will
  be coerced into periods outlined by the API
  (http://data.worldbank.org/developers/climate -data-api)
  anomaly periods are only valid for future scenarios and
  based on a reference period of 1969 - 1999, see API for
  full details.
}
\examples{
\dontrun{
# Get data for 2 basins, annual average precipitation for all valid time periods
# then subset them, and plot
precip_dat <- get_ensemble_precip(c("2","231"),"annualavg",1900,3000)
precip_dat <- subset(precip_dat,precip_dat$scenario!="b1")
precip_dat$uniqueGroup <- paste(precip_dat$percentile,precip_dat$locator,sep="-")
ggplot(precip_dat,aes(x=fromYear,y=annualVal,group=uniqueGroup,colour=as.factor(locator),linetype=as.factor(percentile)))+geom_path()

### Get data for 2 countries with monthly precipitation values
precip_dat <- get_ensemble_precip(c("USA","BRA"),"mavg",2020,2030)
precip_dat <- subset(precip_dat,precip_dat$scenario!="b1")
precip_dat$uniqueGroup <- paste(precip_dat$percentile,precip_dat$locator,sep="-")
ggplot(precip_dat,aes(x=as.factor(month),y=monthVals,group=uniqueGroup,colour=locator))+geom_path()
}
}

