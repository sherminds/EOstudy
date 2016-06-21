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

# Load the xtable package (to export tables as html)
# install.packages("xtable")
require("xtable", quietly = TRUE)

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

generatepage <- function(i){
  # Generate a personalized webpage for a given line of the table
  # Column names in the table
  ## Invited_nb	Invited_W	Instructor_nb	Instructor_W	Org_nb	Org_W	SciCom_nb	SciCom_W
  v <- subdata[i,]
  ADNAME <- v$Ad_ID
  ADDATE <- v$Ad_date
  EVENTTYPE <- v$Type
  EVOLDIR <- paste("http://life.mcmaster.ca/~brian/evoldir/", v$Ad_Type, "/", ADNAME, sep = "")
  WEBSITE <- v$Website
  NBW <- v$Invited_W
  NBS <- v$Invited_nb
  PC <- round(NBW/NBS* 100, digits=2)
  CONTACTNAME <- v$Org_name1
  QADDRESS <- paste("https://flodebarre.github.io/EOstudy/", themonth, "/", ADNAME, ".html", sep = "")
  EVENTSHORTNAME <- v$Short_name

  # Prepare the table that will be printed
  subcol <- v[, c("Invited_nb", "Invited_W", "Instructor_nb", "Instructor_W", "Org_nb", "Org_W", "SciCom_nb", "SciCom_W")]
  # More explicit names
  namsub <- c("#Invited", "#Invited_Women", "#Instructors", "#Instructor_Women", "#Organizers", "#Organizers_Women", "#ScientificCommittee", "#ScientificCommittee_Women")
  # Only include the ones that are not NA:
  colinclude <- c(!is.na(subcol))
  thetab <- subcol[colinclude]
  names(thetab) <- namsub[colinclude]
  htmltab <- print(xtable(thetab, align = rep("l", length(thetab)+1)), include.rownames = FALSE, type = "html", comment = FALSE)
  htmltab2 <- gsub("\n", " ", htmltab)

  # Edit index.html and save it under the ad's name
  cmd <- paste("sed -e 's/XXADNAME/", ADNAME, "/g' -e 's/XXEVENTTYPE/", tolower(EVENTTYPE), "/g' -e 's,XXEVOLDIR,", EVOLDIR, ",g' -e 's,XXWEBSITE,", WEBSITE, ",g' -e 's/XXNBW/", NBW, "/g' -e 's/XXNBS/", NBS, "/g' -e 's/XXDATE/", ADDATE, "/g' -e 's/XXPC/", PC, "/g'  -e 's,XXTABLE,", htmltab2, ",g' -e 's,stylesheets/,../stylesheets/,g' -e 's,pics/,../pics/,g' < pagetemplate.html > ", themonth, "/", ADNAME, ".html", sep="")
  system(cmd)
  }


# Generate the pages!
lapply(seq_along(subdata$Ad_ID), generatepage)


