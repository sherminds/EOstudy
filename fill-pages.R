# First read in the arguments listed at the command line
args <- (commandArgs(TRUE))

# args is now a list of character vectors
# First check to see if arguments are passed.
# Then cycle through each element of the list and evaluate the expressions.
if(length(args) == 0){
  print("No arguments supplied.")
  # supply default values
  themonth <- "Apr"
}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
}

# Load the data
datatab <- read.csv("data.csv", stringsAsFactors = FALSE)

# Get the month information from the Ad_date column
getmonth <- function(str){
  head(strsplit(str, split=" ")[[1]],1)
}
months <- vapply(datatab$Ad_date, getmonth, "a", USE.NAMES = FALSE)
monthlines <- (months==themonth)

# Select also only the lines for which we want to send an email (Include column)
subdata <- datatab[monthlines & datatab$Include, ]
dim(subdata)

# Create directory with month name
system(paste("mkdir", themonth))

# Generate a personalized webpage for a given line of the table
generatepage <- function(i){
  v <- subdata[i,]
  ADNAME <- v$Ad_ID
  EVENTTYPE <- v$Type
  EVOLDIR <- paste("http://life.mcmaster.ca/~brian/evoldir/", v$Ad_Type, "/", ADNAME, sep = "")
  WEBSITE <- v$Website
  NBW <- v$Invited_W
  NBS <- v$Invited_nb
  PC <- NBW/NBS * 100

  # Edit index.html and save it under the ad's name
  system(paste("sed -e 's/XXADNAME/", ADNAME, "/g' -e 's/XXEVENTTYPE/", EVENTTYPE, "/g' -e 's,XXEVOLDIR,", EVOLDIR, ",g' -e 's,XXWEBSITE,", WEBSITE, ",g' -e 's/XXNBW/", NBW, "/g' -e 's/XXNBS/", NBS, "/g' -e 's/XXPC/", PC, "/g' -e 's,stylesheets/,../stylesheets/,g' -e 's,pics/,../pics/,g' < index.html > ", themonth, "/", ADNAME, ".html", sep=""))
}

# Generate the pages!
lapply(seq_along(subdata$Ad_ID), generatepage)


