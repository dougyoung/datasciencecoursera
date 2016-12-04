source('readSamples.R')

# Read NEI PM2.5 data frame
NEI <- readNEI()

# Subset NEI PM2.5 samples to those in Baltimore City
# Baltimore City is coded as fips '24510'
baltimoreCityNEI <- NEI[NEI$fips == '24510', ]

# Calculate total emissions in Baltimore City by year, ignoring missing values
totalEmissionsByYear <- 
  with(baltimoreCityNEI, 
       tapply(Emissions, year, sum, rm.na=T))

# Question:
# Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# ase plotting system to make a plot answering this question.

# Plot.
#   X: Years between 1999 and 2008
#   Y: Total PM2.5 emissions in Baltimore City in tons
barplot(
  totalEmissionsByYear,
  main='Baltimore City PM2.5 emissions',
  ylab='PM2.5 (in tons)',
  col='red'
)

# Persist rendering as a png
dev.print(png, 'plot2.png', width=480, height=480)

# Answer:
# From looking at the summarized data contained in the plot it seems clear
# that the total emissions of PM2.5 at the recorded locations have decreased from previous
# years records.

dev.off()