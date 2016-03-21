library(datasets)

#importing and filtering data
NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_code.rds")

#subsetting Maryland
Maryland<-subset(NEI,fips=="24510")

#creating the table containing total emissions per year
Maryland.emissions<-tapply(Maryland$Emissions,Maryland$year,sum)

#ploting data and saving plot
plot(names(Maryland.emissions),Maryland.emissions,type='l',xlab='Year',ylab='Emissions', main = 'Baltimore City Emissions per Year')
dev.copy(png, file = "plot2.png")
dev.off()
