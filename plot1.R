## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
#NEI<-transform(NEI, year = factor(year))
NEI<-subset(NEI,year >= "1999" & year<= "2008", select=c("year","Emissions"))
library(reshape2)
#NEI <- melt(NEI, id=c("year"), measure.vars=c("Emissions"))
tbl <- aggregate(NEI$Emissions, by=list(NEI$year), FUN="sum", na.rm=TRUE)
rm(NEI)
plot(tbl$Group.1,tbl$x,type="n",xlab="Year",ylab="Emissions")
lines(tbl$Group.1,tbl$x)

