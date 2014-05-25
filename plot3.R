#Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data, and selecting only the needed columns
N.sub <- NEI[NEI$fips == "24510", ]
N.sub <- N.sub[, c(4, 5, 6)]
N.sub$type <- as.factor(N.sub$type)

#Aggregate the sum, and fix columns names in the new data
N.agg <- aggregate(N.sub$Emissions, by= list(N.sub$year, N.sub$type), "sum")
names(N.agg) <- c("year", "type", "Emissions");

library(ggplot2)

png(filename="plot3.png", height=480, width=480)
qplot(year, Emissions, data = N.agg, facets = .~type, geom = c("point", "smooth"), 
      method = "lm", 
      main=expression("Total Emissions in Baltimore City from 1999 to 2008 for All Sources"))
dev.off();