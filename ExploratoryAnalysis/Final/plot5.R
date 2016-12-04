library(ggplot2)

source('readSamples.R')

# Read NEI PM2.5 data frame
NEI <- readNEI()

# Subset NEI PM2.5 samples to those ON-ROAD sensors in Baltimore City
# Baltimore City is coded as fips '24510'
baltimoreCityVehicleNEI <- NEI[NEI$fips == '24510' & NEI$type == 'ON-ROAD', ]

# Calculate total coal vehicle emissions by year
totalVehicleEmissionsByYear <- 
  aggregate(baltimoreCityVehicleNEI$Emissions, by=list(baltimoreCityVehicleNEI$year), sum)

# Rename columns
names(totalVehicleEmissionsByYear) <- c('Year', 'Emissions')

# Question: 
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Construct the plot.
g <- ggplot(data=totalVehicleEmissionsByYear, aes(x=factor(Year), y=Emissions, col='red', fill='red'))
g <- g + geom_bar(stat='identity', show.legend=F)
g <- g + ggtitle('Baltimore City, MD vehicle PM 2.5 emissions')
g <- g + xlab('Year')
g <- g + ylab('Vehicle PM2.5 emissions (in tons)')

####

# Display the plot
print(g)

# Persist rendering as a png
dev.print(png, 'plot5.png', width=480, height=480)

# Answer:
# Between 1999-2008 vehicle related emissions fell drastically. Especially between 1999-2002.

dev.off()
