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
default_columns <- c('Hospital.Name')

## Function that takes an outcome and a ranking
## returns a hospital in each U.S. state for the given outcome at the given rank
rankall <- function(outcome, num = 'best') {
  ## Check that outcome and num are valid
  if (!outcome %in% names(valid_outcomes)) stop('invalid outcome')
  if (!num %in% valid_rankings && num < 1) stop('invalid ranking')
  
  ## Map given outcome to a column name
  outcome_column <- valid_outcomes[[outcome]]
  
  ## Logical vector for present observations
  criteria <- observations[, outcome_column] != 'Not Available'
  
  ## Initialize vector of columns
  columns <- c(default_columns, outcome_column)
  
  state_and_hospital <- sapply(valid_states, function(state) {
    ## Logical vector for state and previous criteria
    criteria <- observations$State == state & criteria
    
    ## Subset samples by given criteria and columns
    samples <- observations[criteria, columns]
    
    ## Order vector by outcome then name
    samples_order <- order(as.numeric(samples[, outcome_column]), samples$Hospital.Name)
    
    ## Order samples by outcome then name
    samples <- samples[samples_order, ]
    
    ## If ranking is greater than the number of samples
    if (is.numeric(num) && num > nrow(samples)) { 
      NA
    } else {
      sample <- if (is.character(num)) {
        switch(num, 
               best = head(samples, n = 1),
               worst = tail(samples, n = 1))
      } else {
        samples[num, ]
      }
      sample$Hospital.Name
    }
  })
  
  ## Re-order results by state vector
  state_order_vector <- order(names(state_and_hospital))
  
  ## Re-order results by state
  state_and_hospital <- state_and_hospital[state_order_vector]
  
  ## Return data frame of hospital and state
  data.frame(hospital = state_and_hospital, state = names(state_and_hospital))
}
