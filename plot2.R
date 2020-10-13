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

# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

#Use the base plotting system to make a plot answering this question

# Looking Baltimore's info using the fip code
baltimore <- nei[nei$fips=="24510",]

# Aggregate using sum the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimore,sum)

png("plot2.png",width=480,height=480,units="px",bg="transparent")

barplot(
    aggTotalsBaltimore$Emissions,
    names.arg=aggTotalsBaltimore$year,
    xlab="Year",
    ylim=c(0,3500),
    ylab="PM2.5 Emissions (tons)",
    main="Total PM2.5 Emissions From all Baltimore City Sources"
)

dev.off()
