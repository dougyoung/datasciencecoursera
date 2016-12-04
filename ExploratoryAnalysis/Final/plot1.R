source('readSamples.R')

# Read NEI PM2.5 data frame
NEI <- readNEI()

# Calculate total emissions by year, ignoring missing values
totalEmissionsByYear <- with(NEI, tapply(Emissions, year, sum, rm.na=T))

# Scale emissions from tons to kilotons
totalEmissionsByYear = 
  totalEmissionsByYear / 1000

# Choose not to show scientific notation for ease of consumption
options(scipen=5)

# Question:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Bar plot.
#   X: Years between 1999 and 2008
#   Y: Total PM2.5 emissions in tons
barplot(
  totalEmissionsByYear,
  main='Total U.S. PM2.5 emissions',
  xlab='Year',
  ylab='PM2.5 (in kilotons)',
  col='red'
)

# Persist rendering as a png
dev.print(png, 'plot1.png', width=480, height=480)

# Answer:
# From looking at the summarized data contained in the plot it seems clear
# that the total emissions of PM2.5 at the recorded locations have decreased from previous
# years records.

dev.off()

