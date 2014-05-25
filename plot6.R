setwd("~/Dropbox/edu/coursera/exdata-002/Assignments/02")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

N <- NEI
N <- N[N$type == "ON-ROAD" & NEI$fips == "24510" , c(4, 6)]

N_agg <- aggregate(N$Emissions, by= list(N$year), "sum")
names(N_agg) <- c("year", "Emissions");

model <- lm(Emissions/1e3 ~ year, N_agg);
plot(N_agg$year, N_agg$Emissions/1e3,
     ylab = expression("Total PM2.5 Emission in kelo Tons"),
     xlab = "Year");

abline(model, lwd =2, col='red')