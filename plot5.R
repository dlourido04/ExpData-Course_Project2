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

# Question 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Subseting SCC datasets for Vehicle entries
vehicles <- grepl(pattern = "vehicle",x = scc$SCC.Level.Two,ignore.case = TRUE)
vehiclesSCC <- scc[vehicles,]$SCC
vehiclesNEI <- nei[nei$SCC %in% vehiclesSCC,]

baltimorevehicles <- (vehiclesNEI[vehiclesNEI$fips == "24510",])

png(filename = "plot5.png",width = 480, height = 480,units = "px",)

g <- ggplot(data = baltimorevehicles, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity",fill = "grey", width = 0.75) +
  theme_grey(base_size = 14,base_family = "") +
  labs(x="Year", y=expression("Total PM2.5 Emission (tons)")) + 
  labs(title=expression("PM2.5 Baltimore City Vehicle Source Emissions"))

print(g)
dev.off()
