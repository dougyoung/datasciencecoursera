# File that contains PM2.5 data
dfPM25 <- 'summarySCC_PM25.rds'
# Memoized version of data set
readNEIMemo <- NULL;
readNEI <- function() {
  if (is.null(readNEIMemo)) {
    # Ensure file exists in current working directory
    if (!dfPM25 %in% dir()) stop(paste("Could not find ", dfPM25, " in current working directory"))
    
    # Return PM2.5 data frame
    readNEIMemo <- readRDS(dfPM25) 
  }
  readNEIMemo
}

# File containing PM2.5 classification codes
sccPM25 <- 'Source_Classification_Code.rds'
# Memoized version of data set
readSCCMemo <- NULL;
readSCC <- function() {
  if (is.null(readSCCMemo)) {
    # Ensure file exists in current working directory
    if (!sccPM25 %in% dir()) stop(paste("Could not find ", sccPM25, " in current working directory"))
    
    # Return PM2.5 classification codes
    readSCCMemo <- readRDS(sccPM25)  
  }
  readSCCMemo
}
