## All observations of the Outcome of Care Measures data
## Since this is static data we only read it into memory once
observations <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')

## Mapping from valid outcome inputs to column names
valid_outcomes <- c(
  'heart attack' = 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack', 
  'heart failure' = 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure', 
  'pneumonia' = 'Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia'
)

## Valid ranking special inputs
valid_rankings <- c('best', 'worst')

## List of valid states
valid_states <- unique(observations$State)

## Important columns
default_columns <- c('State', 'Hospital.Name')

## Function that takes a U.S. state, an outcome and a ranking
## returns a hospital in the given state for the given outcome at the given rank
rankhospital <- function(state, outcome, num = 'best') {
  ## Check that state, outcome and num are valid
  if (!state %in% valid_states) stop('invalid state')
  if (!outcome %in% names(valid_outcomes)) stop('invalid outcome')
  if (!num %in% valid_rankings && num < 1) stop('invalid ranking')
  
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
  
  ## If ranking is greater than the number of samples return NA
  if (is.numeric(num) && num > nrow(samples)) return(NA)
  
  ## Order vector by outcome then name
  samples_order <- order(as.numeric(samples[, outcome_column]), samples$Hospital.Name)
  
  ## Order samples by outcome then name
  samples <- samples[samples_order, ]
  
  ## Find sample for given ranking
  sample <- if (is.character(num)) {
    switch(num, 
           best = head(samples, n = 1),
           worst = tail(samples, n = 1))
  } else {
    samples[num, ]
  }
  
  ## Return hospital name for given ranking
  sample$Hospital.Name
}
