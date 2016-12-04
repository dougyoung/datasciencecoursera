library(ggplot2)

source('readSamples.R')

# Read NEI PM2.5 data frame
NEI <- readNEI()

# Subset NEI PM2.5 samples to those ON-ROAD sensors in Baltimore City or LA
# Baltimore City is coded as fips '24510'
# Los Angeles is coded as fips '06037'
baltimoreCityOrLA <- NEI$fips == '24510' | NEI$fips == '06037'
baltimoreCityOrLAVehicleNEI <- NEI[baltimoreCityOrLA & NEI$type == 'ON-ROAD', ]

# Set region names
baltimoreCityOrLAVehicleNEI$region <- 
  ifelse(baltimoreCityOrLAVehicleNEI$fips == '24510', 'Baltimore City, MD', 'Los Angeles, CA')

# Question: 
# Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California.
# Which city has seen greater changes over time in motor vehicle emissions?

#####

# Const# Construct the plot.
g <- ggplot(data=baltimoreCityOrLAVehicleNEI, aes(x=factor(year), y=Emissions))
g <- g + geom_bar(aes(fill=year), stat='identity')
g <- g + facet_grid(. ~ region)
g <- g + guides(fill=F)
g <- g + ggtitle('Total Vehicle Emissions \nLos Angeles, CA vs Baltimore City, MD')
g <- g + xlab('Year')
g <- g + ylab('PM2.5 (in tons)')

# Print the plot
print(g)

# Persist rendering as a png
dev.print(png, 'plot6.png', width=480, height=480)

# Answer:
# Los Angeles has seen a creater change in Vehicle PM2.5, especially between 2002-2005.
# Unfortunately the change was an increase between those years.

dev.off()
