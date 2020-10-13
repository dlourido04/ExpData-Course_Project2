library(ggplot2)
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

# Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 

# Use the ggplot2 plotting system to make a plot answer this question

# Looking Baltimore's info using the fip code
baltimore <- nei[nei$fips=="24510",]

png("plot3.png",width=600,height=540,units="px",bg="transparent")

baltimore_ggp <- ggplot(baltimore, aes(factor(year), Emissions, fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(.~type,scales = "free",space="free") + 
    labs(x="year", y=expression("Total PM2.5 Emission (Tons)")) + 
    labs(title=expression("PM2.5 Emissions, Baltimore City 1999-2008 by Source Type"))

print(baltimore_ggp)

dev.off()