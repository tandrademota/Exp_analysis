library(datasets)
library(ggplot2)
library(reshape)

#importing and filtering data
NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_code.rds")


#creating the table containing total emissions per year and per type
type.year<-list(NEI$year, NEI$type)
year.type.emissions<-tapply(NEI$Emissions,type.year,sum)
melt.year.type.emissions <- melt(year.type.emissions)
names(melt.year.type.emissions) <- c("year","type","emissions"))

#ploting data and saving plot
qplot(year, emissions, data=melt.year.type.emissions,xlab='Year',ylab='Emissions', main = 'Baltimore City Emissions per Year per Type',geom=c("point","smooth"))+facet_grid(type~.,scales='free_y')
dev.copy(png, file = "plot3.png")
dev.off()

