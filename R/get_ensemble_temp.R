#'Download ensemble temperature data
#'@description Function wraps get_ensemble_climate_data() and returns precipitation
#'by basin or country in mm.  Output is the 10th 50th and 90th percentile for all 
#'gcm's for the a1 and b2 scenarios. 
#'
#'@param locator A vector of either watershed basin ID's from http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf
#'       It can be just a single basin id, or a vector of ids.  ids should be strings.
#'@param type the type of data to retrieve, must be "mavg" for monthly averages,
#'       "annualavg" for annual averages, "manom" for monthly anomaly, and "annualanom" for 
#'       annual anomaly.        
#'@param start the start year to gather data for.
#'@param end the end year to gather data to.
#'@return a dataframe with precipitation predictions in mm for all scenarios, gcms, for each time period.
#'
#'@details start and end year can be any years, but all years will be coerced
#'         into periods outlined by the API (http://data.worldbank.org/developers/climate  -data-api)
#'         anomaly periods are only valid for future scenarios and based on a 
#'         reference period of 1969 - 1999, see API for full details.
#'@examples \dontrun{
#'# Get data for 2 basins, annual average precipitation for all valid time periods
#'# then subset them, and plot
#' temp_dat <- get_ensemble_temp(c("2","231"),"annualavg",1900,3000)
#' temp_dat <- subset(temp_dat,temp_dat$scenario!="b1")
#' temp_dat$uniqueGroup <- paste(temp_dat$percentile,temp_dat$locator,sep="-")
#' ggplot(temp_dat,aes(x=fromYear,y=annualVal,group=uniqueGroup,colour=as.factor(locator),linetype=as.factor(percentile)))+geom_path()
#' 
#' ### Get data for 2 countries with monthly precipitation values
#' temp_dat <- get_ensemble_temp(c("USA","BRA"),"mavg",2020,2030)
#' temp_dat <- subset(temp_dat,temp_dat$scenario!="b1")
#' temp_dat$uniqueGroup <- paste(temp_dat$percentile,temp_dat$locator,sep="-")
#' ggplot(temp_dat,aes(x=as.factor(month),y=monthVals,group=uniqueGroup,colour=locator))+geom_path()
#'}
#'@export


get_ensemble_temp <- function(locator,type, start, end){
  ### check type is valid
  typevec <- c("mavg","annualavg","manom","annualanom")
  if(!type%in%typevec){
    stop("Please enter a valid data type to retrieve, see help for details")
  }
  
  if(start < 2000 && type%in%typevec[3:4]){
    stop("Anomaly requests are only valid for future scenarios")
  }
  #Convert numeric basin numbers to strings if they were entered incorrectly
  locator <- as.character(locator)
  geo_ref <- rWBclimate:::check_locator(locator)
  
  output <- rWBclimate:::get_ensemble_data_recursive(locator,geo_ref,type, "tas", start, end)
  return(output)
}

