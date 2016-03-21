library(datasets)

#importing and filtering data
NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_code.rds")


#creating the table containing total emissions per year
year.emissions<-tapply(NEI$Emissions,NEI$year,sum)

#ploting data and saving plot
plot(names(year.emissions),year.emissions,type='l',xlab='Year',ylab='Emissions', main = 'Total Emissions per Year')
dev.copy(png, file = "plot1.png")
dev.off()
