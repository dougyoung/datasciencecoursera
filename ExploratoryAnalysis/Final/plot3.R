library(ggplot2)

source('readSamples.R')

# Read NEI PM2.5 data frame
NEI <- readNEI()

# Subset NEI PM2.5 samples to those in Baltimore City
# Baltimore City is coded as fips '24510'
baltimoreCityNEI <- NEI[NEI$fips == '24510', ]

# Question:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable: 
# 1. Which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# 2. Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Convert years to factors
baltimoreCityNEI$year <- as.factor(baltimoreCityNEI$year)

# Construct the plot.
g <- ggplot(data=baltimoreCityNEI, aes(x=year, y=log(Emissions)))
g <- g + geom_boxplot(aes(fill=type))
g <- g + facet_grid(. ~ type)
g <- g + stat_boxplot(geom ='errorbar')
g <- g + guides(fill=F)
g <- g + xlab('Year')
g <- g + ylab('Log of PM2.5 emissions')
g <- g + ggtitle('Emissions by type in Baltimore City MD')

# Display the plot
print(g)

# Persist rendering as a png
dev.print(png, 'plot3.png', width=480, height=480)

# Answer:
# 1. Non-road, On-road and Point emission types have seen clear decreases between
#    1999-2008 in Baltimore City MD
# 2. Nonpoint emission types have seen neither a significant increase or decrease
#    between 1999-2008 in Baltimore City MD

dev.off()
