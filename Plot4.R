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

#Filtering the emissions due to Coal related sources
coal <- grepl("[Cc]oal", NEI.merged$EI.Sector)
NEI.coal <- NEI.merged[coal,]

#creating the table containing total emissions due to coal related sources per year
year.coal.emissions<-tapply(NEI.coal$Emissions,NEI.coal$year,sum)

#ploting data and saving plot
plot(names(year.coal.emissions),year.coal.emissions,type='l',xlab='Year',ylab='Emissions', main = 'Coal related Emissions per Year')
dev.copy(png, file = "plot4.png")
dev.off()

