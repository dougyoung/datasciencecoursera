## All observations of the Outcome of Care Measures data
## Since this is static data we only read it into memory once
observations <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')

## Mapping from valid outcome inputs to column names
valid_outcomes <- c(
  'heart attack' = 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack', 
  'heart failure' = 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure', 
  'pneumonia' = 'Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia'
)

## List of valid states
valid_states <- unique(observations$State)

## Important columns
default_columns <- c('State', 'Hospital.Name')

## Function that takes a U.S. state and an outcome
## returns the best hospital in the given state for the given outcome
best <- function(state, outcome) {
  ## Check that state and outcome are valid
  if (!state %in% valid_states) stop('invalid state')
  if (!outcome %in% names(valid_outcomes)) stop('invalid outcome')
  
  ## Map given outcome to a column name
  outcome_column <- valid_outcomes[[outcome]]
  
  ## Logical vector for state and present observations
  criteria <- 
    observations$State == state & 
    observations[, outcome_column] != 'Not Available'
  
  ## Initialize vector of columns
  columns <- c(default_columns, outcome_column)
  
  ## Subset samples by given criteria and columns
  samples <- observations[criteria, columns]
  
  ## Subset samples to outcome only
  samples_outcome <- as.numeric(samples[, outcome_column])
  
  ## Find mininum value amongst samples
  samples_min <- min(samples_outcome)
  
  ## Find all hospitals with minimum sample
  samples_min_vector <- 
    samples$Hospital.Name[samples_outcome == samples_min]
  
  ## Return first hospital ordered alphabetically
  head(sort(samples_min_vector), n = 1)
}
