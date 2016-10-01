# Reads a directory full of files and reports the number of completely
# observed cases in each data file. The function returns a data frame where
# the first column is the name of the file and
# the second column is the number of complete cases

complete <- function(directory, id = 1:332) {

  ## Initialize integer vector for sensor ids
  ids <- vector('integer')

  ## Initialize integer vector for complete cases
  complete_cases <- vector('integer')

  ## Get a list of relative file paths
  files <- list.files(directory, pattern = '*.csv', full.names = T)

  ## Loop over given ids
  for (i in id) {
    ## Load samples for given sensor id
    samples <- read.csv(files[i], header=T)

    ## Append id to sensor ids
    ids <- c(ids, i)

    ## Append complete cases count
    complete_cases <- c(complete_cases, sum(complete.cases(samples)))
  }

  ## Return data frame
  data.frame(ids = ids, nobs = complete_cases)
}
