# Option not to print the input in the .Rout file
options(echo = FALSE)

# First read in the arguments listed at the command line
args <- (commandArgs(TRUE))

# args is now a list of character vectors
# First check to see if arguments are passed.
# Then cycle through each element of the list and evaluate the expressions.
if(length(args) == 0){
  stop("No arguments supplied.")
}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
}

## Make sure to have downloaded recently data and responses.
## This has been done automatically if you have been running ../do-qualitycontrol.sh

# LOAD THE DATA IN R
# Load the data 
datatab <- read.csv("../data/data.csv", stringsAsFactors = FALSE)

# Load the responses 
resptab <- read.csv("../data/responses.csv", stringsAsFactors = FALSE)

#===============================================

# INSERTION OF THE RESPONSES
# Double-check that responses have been entered: do not proceed further if it has not been the case
resp.names <- sort(unique(resptab$Event.name))
data.names <- sort(datatab[!is.na(datatab$Org_reply1) & datatab$Include==TRUE, 1])

cat("1)    Check insertion of the responses in AllData file:\n\n")
# 1) Check numbers
resp.nb <- length(resp.names)
data.nb <- length(data.names)
if(resp.nb != data.nb){
  stop("Not all responses have been entered! Aborting.")
}else cat("- All responses have been entered\n")

# 2) Check names
if(any(resp.names != data.names)){
  print(cbind(resp.names[resp.names != data.names], data.names[resp.names != data.names]))
  stop("Problems with names on some lines")
}else cat("- Names are OK\n") 

#===============================================

cat("\n============================================\n")
cat("2)    Looking for duplicates\n\n")
# LOOKING FOR DUPLICATES
# Look at only the beginning of the Ad name
getbeginname <- function(str, stt=1, stp = 17){
  substr(str, stt, stp)
}
shorternames <- vapply(datatab$Ad_ID, getbeginname, "a", USE.NAMES = FALSE)
potentialduplicatedlines1 <- (duplicated(shorternames) | duplicated(shorternames, fromLast=TRUE))

# Looking at websites
tmp <- (duplicated(datatab$Website) | duplicated(datatab$Website, fromLast=TRUE))
potentialduplicatedlines2 <- tmp & !is.na(datatab$Website)

# Combine the two
potentialduplicatedlines <- potentialduplicatedlines1 | potentialduplicatedlines2

# Show the lines that are potentially duplicated
subtab <- datatab[potentialduplicatedlines, ] # Subset of the table
tmp.order <- sort(subtab$Ad_ID, index.return = TRUE) # Sort by Ad_ID to facilitate identification
subdup <- subtab[tmp.order$ix, c(1, 2, 8)] # Print only a few columns
subdup[subdup$Include==TRUE,] # And only the ones for which Include=TRUE
cat("\n-- Check in the above table that there are no duplicates --\nNote: Girona.EvolutionMarineMicrobes.Jun18-24_2 in Apr is normal.\n")

#===============================================

cat("\n============================================\n")
cat("3)    Checking that all columns are OK\n\n")

# CHECK THAT ALL COLUMNS ARE OK 
# (Before sending first email)

getmonth <- function(str){
  head(strsplit(str, split=" ")[[1]],1)
}
months <- vapply(datatab$Ad_date[datatab$Include==TRUE], getmonth, "a", USE.NAMES = FALSE)

data.includeonly <- datatab[datatab$Include==TRUE, c(1, 2, 6, 7, 20, 21)]
print(data.includeonly)

# If you only want to show a specific month
cat("--    Printing only the output for ", toString(themonth), "\n\n")
mymon <- themonth
data.io.mon <- data.includeonly[months==mymon,]
print(data.io.mon)

cat("\n============================================\n")
