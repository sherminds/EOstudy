#!/bin/bash

# Argument: month (3 letter version, e.g., Apr)

# Exit if no argument supplied. 
if [ -z "$1" ]
then
printf "\nERROR: No argument supplied. \n       Supply 3-letter version of month (Apr, May, ...)\n\n"
exit 1
fi

echo "${1}"

# Run the R script that will generate the pages
# (the series of '" are here because we need " for the R argument to be considered as text, 
#  the args have to be within ', but $ is expanded within ")
cd R/
R CMD BATCH --no-save --no-restore '--args themonth="'"${1}"'"' send-emails.R
cd ../

less R/send-emails.Rout
