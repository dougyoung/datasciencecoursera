# A function that takes a directory of data files and a threshold for
# complete cases and calculates the correlation between sulfate and nitrate
# for monitor locations where the number of completely observed cases
# (on all variables) is greater than the threshold.
# The function returns a vector of correlations for the monitors
# that meet the threshold requirement.
# If no monitors meet the threshold requirement, then the function returns a
# numeric vector of length 0.

corr <- function(directory, threshold = 0) {

  ## Initialize a numeric vector for correlation
  correlation <- vector('numeric')

  ## Get a list of relative file paths
  files <- list.files(directory, pattern = '*.csv', full.names = T)

  ## Loop over all csv files
  for (file in files) {
    ## Load samples for given sensor id
    samples <- read.csv(file, header=T)

    ## Find all complete cases for samples
    complete_cases <- complete.cases(samples)

    ## If the number of complete cases exceeds the threshold
    if (sum(complete_cases) > threshold) {
      ## Retrieve sulfate reading
      sulfate <- samples$sulfate[complete_cases]

      ## Retrieve nitrate reading
      nitrate <- samples$nitrate[complete_cases]

      ## Append correlation
      correlation <- c(correlation, cor(sulfate, nitrate))
    }
  }

  ## Return correlation
  correlation
}
