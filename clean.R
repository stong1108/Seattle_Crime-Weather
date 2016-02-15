require(dplyr)
require(stringr)
require(lubridate)
options(stringsAsFactors = FALSE)

# Function to be used later in script
getTime <- function(x, year, mon, day)
{
  y <- str_pad(x, 4, "left", pad = "0")
  h <- substr(y, 1, 2)
  m <- substr(y, 3, 4)
  info <- ISOdate(year, mon, day, h, m)
  return(info)
}

myDF <- data.frame()
years <- c(2008:2015)

for (i in seq_along(years))
{
  yr <- years[i]
  
  # Read csv
  file <- paste(yr, '.csv', sep = "")
  current <- read.csv(file)
  
  # Parse datetime
  for (col in 2:ncol(current))
  {
    month <- floor(col/2)
    days <- length(current[,col])
    
    for (day in 1:days)
    {
      blah <- getTime(current[day, col], yr, month, day)
      date <- as.character(format(blah, '%Y/%m/%d'))
      #time <- as.character(format(blah, '%H:%M'))
      df <- data.frame(date = ymd(date), time = as.character(format(blah, '%H:%M')))
      myDF <- rbind(myDF, df)
    }
    
  }

}

# Remove NA
keep <- myDF[complete.cases(myDF),]

# Rearrange data frame into [date, sunrise time, sunset time]
keep <- arrange(keep, date)
riseRows<- keep[seq(1, nrow(keep), 2),]
rise <- as.character(riseRows[,2])
set <- as.character(keep[seq(2, nrow(keep), 2),2])

sunDF <- data.frame(date = riseRows[,1], rise, set)
sunDF <- mutate(sunDF, dayhours = as.numeric(strptime(paste(date, set), format = '%Y-%m-%d %H:%M') - strptime(paste(date, rise), format = '%Y-%m-%d %H:%M')))

# Load crime dataset
crime <- read.csv('Seattle_Police_Department_Police_Report_Incident.csv')

# Get rid of unnecessary columns
crime <- crime[, -c(1:6, 11, 14, 17:19)]

# Only keep observations in relevant years
reportedDatetime <- strptime(crime[,3], format = '%m/%d/%Y %I:%M:%S %p')
crime <- crime[year(reportedDatetime) %in% years,]

# Get rid of observations whose crime types are unclear or unnecessary
index <- grep("INC - CASE DC USE ONLY|FALSE REPORT", crime[,1], ignore.case = TRUE)
crime <- crime[-index,]


