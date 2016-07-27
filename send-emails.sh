#!/bin/bash

# Argument: month (3 letter version, e.g., Apr)

# Exit if no argument supplied. 
if [ -z "$1" ]
then
printf "\nERROR: No argument supplied. \n       Supply 3-letter version of month (Apr, May, ...)\n\n"
exit 1
fi

echo "${1}"

# Check that emails have not already been sent
if [ -f "R/Backup_Rout/send-emails_${1}.Rout" ];
then
printf "ATTENTION! \n    Emails have already been sent once for ${1}! \n    Aborting.\n\n"
exit 1
fi


# Run the R script that will generate the pages
# (the series of '" are here because we need " for the R argument to be considered as text, 
#  the args have to be within ', but $ is expanded within ")
cd R/
R CMD BATCH --no-save --no-restore '--args themonth="'"${1}"'"' send-emails.R
cd ../


# Keep a copy of the Rout file as a reminder that reminders have been send.
cp R/send-emails.Rout R/Backup_Rout/send-emails_${1}.Rout

# Check the output
less R/Backup_Rout/send-emails_${1}.Rout

