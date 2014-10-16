## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?
SCC <- readRDS("Source_Classification_Code.rds")
SCC_Code <- SCC$SCC[grep("Motor",SCC$Short.Name)]
NEI <- readRDS("summarySCC_PM25.rds")
NEI <- subset(NEI,year >= "1999" & year<= "2008" & SCC %in% SCC_Code & fips %in% c("24510","06037"), select=c("year","Emissions", "fips"))
NEI<-transform(NEI, year = factor(year), fips = factor(fips))
library(reshape2)
#NEI <- melt(NEI, id=c("year"), measure.vars=c("Emissions"))
tbl <- aggregate(NEI$Emissions, by=list(NEI$year,NEI$fips), FUN="sum", na.rm=TRUE)
rm(NEI)
library(ggplot2)
qplot(Group.1, x, data=tbl,  color = Group.2, geom=c("point","line"), facets = .~Group.2, group=Group.2,  xlab="Year", ylab="Emissions", main="Emissions from motor vehicle sources in Los Angeles and Baltimore")
dev.copy(png, file ="plot6.png")
dev.off()
