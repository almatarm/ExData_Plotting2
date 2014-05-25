#Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data, and selecting only the needed columns
N.sub <- NEI[NEI$type == "ON-ROAD" & 
               (NEI$fips == "24510"  | NEI$fips == "06037"), c(1, 4, 6)]

#Aggregate the sum, and fix columns names in the new data
N.agg <- aggregate(N.sub$Emissions, by= list(N.sub$year, N.sub$fips), "sum")
names(N.agg) <- c("year", "City", "Emissions");

N.agg$City <- gsub("24510", "Baltimore City",     N.agg$City)
N.agg$City <- gsub("06037", "Los Angeles County", N.agg$City)

library(ggplot2)

png(filename="plot6.png", height=480, width=480)

qplot(year, Emissions, data = N.agg, facets = .~City, geom = c("point", "smooth"), 
      method = "lm", 
      main=expression("Total Emissions (Baltimore City vs. Los Angeles County)"))

dev.off();