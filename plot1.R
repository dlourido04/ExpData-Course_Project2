# Getting datasets
# wk_dir <- getwd()
wk_dir <- "D:/Coursera/Exploratory Data Analysis/Week4"

data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filepath <- paste(wk_dir, "rawData.zip", sep = "/")

if (!file.exists(filepath)) {
    download.file(data_url, destfile = filepath)
    unzip(zipfile = filepath, exdir = wk_dir)
}

nei <- readRDS(paste(wk_dir, "summarySCC_PM25.rds", sep = "/"))
scc <- readRDS(paste(wk_dir, "Source_Classification_Code.rds", sep = "/"))

# Question 1:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

#Using the base plotting system, make a plot showing the total PM2.5 emission from all 
#sources for each of the years 1999, 2002, 2005, and 2008.
# Aggregate using sum all emissions data by year
aggTotals <- aggregate(Emissions ~ year,nei, sum)

png("plot1.png",width=480,height=480,units="px",bg="transparent")

barplot(
    (aggTotals$Emissions)/1000,
    names.arg=aggTotals$year,
    xlab="Year", 
    ylim=c(0,8000),
    ylab="PM2.5 Emissions in Kilotons (10^3)",
    main="Total PM2.5 Emissions From All US Sources"
)

dev.off()
