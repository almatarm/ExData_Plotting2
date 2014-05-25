#Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get the SCC for coal 
S <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE) |
           grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE), ]

#Subsetting the data, and selecting only the needed columns
N.sub <- NEI[NEI$SCC %in% S$SCC, c(4, 6)]

#Aggregate the sum, and fix columns names in the new data
N.agg <- aggregate(N.sub$Emissions, by= list(N.sub$year), "sum")
names(N.agg) <- c("year", "Emissions");

model <- lm(Emissions/1e3 ~ year, N.agg);

plot(N.agg$year, N.agg$Emissions/1e3, type="b", col="blue",
     ylab = expression("Total PM"[2.5]*" Emission in US (Kelo Tons)"),
     xlab = "Year",
     main = expression("Total Emissions from PM"[2.5]*" in US from 1999 to 2008"));

abline(model, lwd =2, col='red')