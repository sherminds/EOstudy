# First read in the arguments listed at the command line
args <- (commandArgs(TRUE))

# args is now a list of character vectors
# First check to see if arguments are passed.
# Then cycle through each element of the list and evaluate the expressions.
if(length(args) == 0){
  stop("No arguments supplied. You need to enter the 3-letter version of the month (Apr, May, ...)")
}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
}

# Load the data
datatab <- read.csv("../data/data.csv", stringsAsFactors = FALSE)

# Get the month information from the Ad_date column
getmonth <- function(str){
  head(strsplit(str, split=" ")[[1]],1)
}
months <- vapply(datatab$Ad_date, getmonth, "a", USE.NAMES = FALSE)
monthlines <- (months==themonth)

# Select also only the lines for which we want to send an email (Include column)
subdata <- datatab[monthlines & datatab$Include, ]
dim(subdata)

generateemail <- function(i){
  # Generate a personalized email for a given line of the table
  v <- subdata[i,]
  ADNAME <- v$Ad_ID
  ADDATE <- v$Ad_date
  EVENTTYPE <- v$Type
  CONTACTNAME <- v$Org_name1
  CONTACTEMAIL <- v$Org_email1
  QADDRESS <- paste("https://flodebarre.github.io/EOstudy/", themonth, "/", ADNAME, ".html", sep = "")
  EVENTSHORTNAME <- v$Short_name
  
  emailtxt <- "Dear Dr. XXNAME,

As part of the Equal Opportunity Initiative of the European Society for Evolutionary Biology (ESEB), we are currently investigating the potential factors affecting the proportion of invited female speakers in scientific events advertised on the Evoldir mailing list.
  
We saw the post about the XXEVENTTYPE that you organize, and we would like to ask if you could answer a very short questionnaire, available at 
XXQADDRESS ; 
filling it in should take no more than 2 minutes.
  
We thank you in advance for your time.
Please feel free to contact us should you have any question.
  
Best wishes,
  
Flo Debarre, Nicolas Rode, Shermin de Silva, Line Ugelvig.

-------------------------------------------------
 EO-study
  website: http://flodebarre.github.io/EOstudy
  email: eostudy.2017@gmail.com
-------------------------------------------------"
  
 # Fill in the blanks
  tmp <- gsub("XXNAME", CONTACTNAME, emailtxt)
  tmp <- gsub("XXEVENTTYPE", tolower(EVENTTYPE), tmp)
  tmp <- gsub("XXQADDRESS", QADDRESS, tmp)
  wholeemail <- paste("Subject: Questions on ", EVENTSHORTNAME, "\n\n", tmp, "\n", sep="")
  
  # Write the whole command to send the email
  cmdemail <- paste('printf "From: EO study <eostudy.2017@gmail.com>\nTo: ', CONTACTEMAIL, '\n', wholeemail, '" | /usr/sbin/sendmail -F "EO study" -f "eostudy.2017@gmail.com" "', CONTACTEMAIL, '"', sep = '')

  system(cmdemail)
  return(ADNAME) # Way to check that the function has been evaluated
}

# send the emails!
# Do it in a loop to add a pause in the execution (otherwise Gmail complains)
for(i in seq_along(subdata$Ad_ID)){
  generateemail(i)
  Sys.sleep(4)
}


