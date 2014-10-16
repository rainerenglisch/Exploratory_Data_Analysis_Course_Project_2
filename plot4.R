## Across the United States, how have emissions from coal combustion-related sources
## changed from 1999–2008?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC_Code <- SCC$SCC[grep("Coal(.*)Comb",SCC$Short.Name)]
NEI<-subset(NEI,year >= "1999" & year<= "2008" & SCC %in% SCC_Code, select=c("year","Emissions"))
#NEI<-transform(NEI, year = factor(year), type = factor(type))
library(reshape2)
#NEI <- melt(NEI, id=c("year"), measure.vars=c("Emissions"))
tbl <- aggregate(NEI$Emissions, by=list(NEI$year), FUN="sum", na.rm=TRUE)
rm(NEI)
library(ggplot2)
qplot(Group.1, x, data=tbl, geom=c("point","line"))
dev.copy(png, file ="plot4.png")
dev.off()
