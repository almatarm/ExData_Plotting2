#Reading the data
#Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data, and selecting only the needed columns
N.sub <- NEI[NEI$fips == "24510", ]
N.sub <- N.sub[, c(4, 6)]

#Aggregate the sum, and fix columns names in the new data
N.agg <- aggregate(N.sub$Emissions, by= list(N.sub$year), "sum")
names(N.agg) <- c("year", "Emissions");

#plot and save the data
png(filename="plot2.png", height=480, width=480)
model <- lm(Emissions ~ year, N.agg);
plot(N.agg$year, N.agg$Emissions, type="b", col="blue",
     ylab = expression("Total PM"[2.5]*" Emission in Baltimore City"),
     xlab = "Year",
     main = expression("Total Emissions from PM"[2.5]*" in Baltimore City from 1999 to 2008"));
abline(model, lwd =2, col="Red")
dev.off();