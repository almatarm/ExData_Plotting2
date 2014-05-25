#Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data, and selecting only the needed columns
N.sub <- NEI[NEI$type == "ON-ROAD" & NEI$fips == "24510" , c(4, 6)]

#Aggregate the sum, and fix columns names in the new data
N.agg <- aggregate(N.sub$Emissions, by= list(N.sub$year), "sum")
names(N.agg) <- c("year", "Emissions");

png(filename="plot5.png", height=480, width=480)
model <- lm(Emissions ~ year, N.agg);
plot(N.agg$year, N.agg$Emissions, type="b", col="blue",
     ylab = expression("Total PM"[2.5]*" Emission in Tons"),
     xlab = "Year",
     main = expression("Total Emissions from Moter/Veh. in Baltimore City"));
abline(model, lwd =2, col='red')
dev.off();