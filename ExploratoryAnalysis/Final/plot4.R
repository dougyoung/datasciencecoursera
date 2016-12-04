library(ggplot2)

source('readSamples.R')

# Read NEI PM2.5 data frame
NEI <- readNEI()

# Read NEI PM2.5 classifiction codes
SCC <- readSCC()

# Subset classification codes by those referring to coal
SCC <- SCC[grepl('coal', SCC$Short.Name, ignore.case=TRUE), ]

# Merge NEI PM2.5 data frame with classification codes
coalNEI <- merge(NEI, SCC, by='SCC')

# Calculate total coal combustion emissions by year
totalCoalEmissionsByYear <- 
  aggregate(coalNEI$Emissions, by=list(coalNEI$year), sum)

# Rename columns
names(totalCoalEmissionsByYear) <- c('Year', 'Emissions')

# Question: 
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Construct the plot.
g <- ggplot(data=totalCoalEmissionsByYear, aes(x=totalCoalEmissionsByYear$Year, y=totalCoalEmissionsByYear$Emissions / 1000))
g <- g + geom_point(aes(col=Emissions, size=2), show.legend=F)
g <- g + geom_line(aes(col=Emissions), show.legend=F)
g <- g + ggtitle('Total U.S. coal PM 2.5 emissions')
g <- g + xlab('Year')
g <- g + ylab('Coal PM2.5 emissions (in kilotons)')

# Display the plot
print(g)

# Persist rendering as a png
dev.print(png, 'plot4.png', width=480, height=480)

# Answer:
# Between 1999-2008 coal related emissions have fallen drastically, 
# especially between 2005-2008. There was, however, a small increase between 2002-2005.

dev.off()
