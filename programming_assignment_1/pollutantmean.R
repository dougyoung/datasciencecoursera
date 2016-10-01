# Calculates the mean of a pollutant (sulfate or nitrate) across
# a specified list of monitors.
# Takes three arguments: 'directory', 'pollutant', and 'id'.
# Given a vector monitor ID numbers, 'pollutantmean' reads that monitors'
# particulate matter data from the directory specified in the 'directory'
# argument and returns the mean of the pollutant across all of the monitors,
# ignoring any missing values coded as NA.

pollutantmean <- function(directory = 'specdata', pollutant = 'sulfate', id = 1:332) {

  ## Initialize a numeric vector for all samples
  all_samples <- vector('numeric')

  ## Get a list of relative file paths
  files <- list.files(directory, pattern = '*.csv', full.names = T)

  ## Loop over given ids
  for (i in id) {
    ## Load samples for given sensor id
    samples <- read.csv(files[i], header=T)

    ## Select all samples
    samples <- samples[, pollutant]

    ## Select all present samples
    samples <- samples[!is.na(samples)]

    ## Append samples to samples vector
    all_samples <- c(all_samples, samples)
  }

  ## Return mu of our samples
  mean(all_samples)
}
