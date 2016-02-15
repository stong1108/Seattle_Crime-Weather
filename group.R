# Group crime offense types after looking at unique "Summarized.Offense.Description" entries for our dataset
crime$type <- rep(0, nrow(crime))
index <- grep("CAR PROWL|THEFT|BURGLARY|ROBBERY|SHOPLIFTING|STOLEN PROPERTY|PURSE SNATCH|PICKPOCKET", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Theft"

index <- grep("PROSTITUTION|PORNOGRAPHY", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Sexual Misconduct"

index <- grep("NARCOTICS|LIQUOR|DUI|DRUGS", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Drugs/Alcohol"

index <- grep("DISTURBANCE|NUISANCE|DISORDERLY|LOITERING|FIREWORK", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Public Disturbance"

index <- grep("FRAUD|FORGERY|COUNTERFEIT|EMBEZZLE", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Fraud"

index <- grep("ASSAULT|WEAPON|INJURY", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Assault"

index <- grep("PROPERTY DAMAGE|TRESPASS|RECKLESS BURNING|ILLEGAL DUMPING", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Property"

index <- grep("THREATS|EXTORTION", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Threats"

index <- grep("ELUDING|ESCAPE", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Escape"

index <- grep("GAMBLE", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Gambling"

index <- grep("BIAS INCIDENT", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Bias/Prejudice"

index <- grep("TRAFFIC", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Traffic"

index <- grep("ANIMAL COMPLAINT", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Animal"

index <- grep("HOMICIDE", crime[,1], ignore.case = TRUE)
crime$type[index] <- "Homicide"

# Get rid of observations whose crime types are unclear or unnecessary
crime <- crime[crime$type != 0,]