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

# Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

## Subseting SCC datasets for Vehicle Entries

vehicles <- grepl(pattern = "vehicle",x = scc$SCC.Level.Two,ignore.case = TRUE)
vehiclesSCC <- scc[vehicles,]$SCC
vehiclesNEI <- nei[nei$SCC %in% vehiclesSCC,]

## Subsetion Baltimore and LA County vehicles

filteredvehicles <- (vehiclesNEI[vehiclesNEI$fips == "24510" | vehiclesNEI$fips == "06037",])
filteredvehicles[,1] <- as.factor(x = filteredvehicles[,1])
filteredvehicles <- filteredvehicles
levels(filteredvehicles$fips)[levels(filteredvehicles$fips)=="06037"] <- "Los Angeles"
levels(filteredvehicles$fips)[levels(filteredvehicles$fips)=="24510"] <- "Baltimore"

png(filename = "plot6.png",width = 480, height = 480,units = "px",)

g <- ggplot(data = filteredvehicles, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity",fill = "grey", width = 0.75) + 
  facet_grid(facets = .~fips,scales = "free", space = "free") +
  theme_grey(base_size = 14,base_family = "") +
  labs(x="Year", y=expression("Total PM2.5 Emission (Tons)")) + 
  labs(title=expression("PM2.5 LA County and Baltimore Vehicle Emissions"))

print(g)
dev.off()

