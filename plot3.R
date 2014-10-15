## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
NEI<-subset(NEI,year >= "1999" & year<= "2008" & fips == "24510", select=c("year","Emissions","type"))
NEI<-transform(NEI, year = factor(year), type = factor(type))
library(reshape2)
#NEI <- melt(NEI, id=c("year"), measure.vars=c("Emissions"))
tbl <- aggregate(NEI$Emissions, by=list(NEI$type,NEI$year), FUN="sum", na.rm=TRUE)
rm(NEI)
library(ggplot2)
qplot(Group.2, x, data=tbl, color = Group.1, geom=c("point","line"), facets = .~Group.1, group=Group.1)
dev.copy(png, file ="plot3.png")
dev.off()
