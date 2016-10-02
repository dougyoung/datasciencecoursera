## Function that returns a special matrix with memoizable inverses
makeCacheMatrix <- function(m = matrix()) {
  ## Initialize empty memoized matrix inverse
  inverse_memo <- NULL

  ## Setter to reset the matrix
  set <- function(new_matrix) {
    m <<- new_matrix
    inverse_memo <<- NULL
  }

  ## Getter to get the original matrix
  get <- function() m

  ## Set the matrix's memoized inverse
  set_inverse <- function(inverse) inverse_memo <<- inverse

  ## Get the matrix's memoized inverse
  get_inverse <- function(...) {
    if (is.null(inverse_memo)) {
      set_inverse(solve(get(), ...))
    }
    inverse_memo
  }

  ## Return a list of functions
  list(set = set, get = get,
       set_inverse = set_inverse,
       get_inverse = get_inverse)
}

## Function that takes a makeCacheMatrix and computes its inverse
## Subsequent calls with the same matrix will return memoized results
cacheSolve <- function(m, ...) {
  ## Attempt to get inverse from the matrix
  inverse <- m$get_inverse()

  ## If memoized inverse is null
  if (is.null(inverse)) {
    ## Then get the original matrix
    matrix <- m$get()

    ## Compute and store the inverse
    inverse <- solve(matrix, ...)

    ## Memoize the inverse
    m$set_inverse(inverse)
  } else {
    ## Else return the memoized inverse
    message("Returning inverse from cache")
  }

  ## inverse is now computed or is the memoized version
  inverse
}
