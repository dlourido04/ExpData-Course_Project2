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

# Question 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Subset datasets for combustion related and coal related entries
combustionRelated <- grepl("comb", scc$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", scc$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- scc[coalCombustion,]$SCC
combustionNEI <- nei[nei$SCC %in% combustionSCC,]

png("plot4.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(combustionNEI,aes(factor(year),Emissions/10^3)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM2.5 Emission kilotons (10^3)")) + 
    labs(title=expression("PM2.5 Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

dev.off()