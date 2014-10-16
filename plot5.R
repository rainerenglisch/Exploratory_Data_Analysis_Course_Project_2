## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC_Code <- SCC$SCC[grep("Motor",SCC$Short.Name)]
NEI<-subset(NEI,year >= "1999" & year<= "2008" & SCC %in% SCC_Code & fips == "24510", select=c("year","Emissions"))
#NEI<-transform(NEI, year = factor(year), type = factor(type))
library(reshape2)
#NEI <- melt(NEI, id=c("year"), measure.vars=c("Emissions"))
tbl <- aggregate(NEI$Emissions, by=list(NEI$year), FUN="sum", na.rm=TRUE)
rm(NEI)
library(ggplot2)
qplot(Group.1, x, data=tbl, geom=c("point","line"), xlab="Year", ylab="Emissions", main="Emissions from motor vehicle sources")
dev.copy(png, file ="plot5.png")
dev.off()
