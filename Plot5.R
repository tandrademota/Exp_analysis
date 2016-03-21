library(datasets)
library(reshape)

#importing and filtering data
NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_code.rds")

#preparing the SCC table
# I concluded that the variable "EI.Sector" in "SCC" table is the best to point the source of emissions
SCC.short <- cbind(as.character(SCC$SCC),as.character(SCC$EI.Sector))
colnames(SCC.short)<-c("SCC","EI.Sector")

#merging NEI and SCC tables
NEI.merged <- merge(NEI, SCC.short, by.x="SCC", by.y="SCC")

#Filtering the emissions due to motor vehicle related sources
vehicle <- grepl("Mobile", NEI.merged$EI.Sector)
NEI.vehicle <- NEI.merged[vehicle,]

#creating the table containing total emissions due to motor vehicles related sources per year in Baltimore City
NEI.Baltimore.vehicle <- subset(NEI.vehicle, NEI.vehicle$fips == "24510")
year.vehicle.Baltimore.emissions<-tapply(NEI.Baltimore.vehicle$Emissions,NEI.Baltimore.vehicle$year,sum)

#ploting data and saving plot
plot(names(year.vehicle.Baltimore.emissions), year.vehicle.Baltimore.emissions, type='l', xlab='Year', ylab='Emissions', main = 'Motor Vehicle related Emissions in Baltimore City per Year')
dev.copy(png, file = "plot5.png")
dev.off()

