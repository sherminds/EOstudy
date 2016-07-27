#!/bin/bash

# Argument: month (3 letter version, e.g., Apr)

# Exit if no argument supplied. 
if [ -z "$1" ]
then
printf "\nERROR: No argument supplied. \n       Supply 3-letter version of month (Apr, May, ...)\n\n"
exit 1
fi

echo "${1}"

# Check that reminders have not already been sent
if [ -f "R/Backup_Rout/send-reminder_${1}.Rout" ];
then
printf "ATTENTION! \n    Reminders have already been sent once for ${1}! \n    Aborting.\n\n"
exit 1
fi

# DOWNLOAD THE DATA
# Get today's date
todaydate=$(date +%Y-%m-%d)

# Download the Google Spreadsheet
curl "https://docs.google.com/spreadsheets/d/1i67UACuGm4gKLlunEzIHdxCBSZJP2bhZWB3lSPkEocg/export?gid=0&format=csv" > data/data.csv

# Save it, and append today's date to the file name for future reference
# (technically this is not need because we are using git...!)
cp data/data.csv data/data${todaydate}.csv

# Download the Responses Spreadsheet (for quality control)
curl "https://docs.google.com/spreadsheets/d/15cnAojpxX1E2B6Sgyit1435OB9nxi1T_kBzIXCk_1ns/pub?gid=1277286923&single=true&output=csv" > data/responses.csv
cp data/responses.csv data/responses${todaydate}.csv


# RUN THE R SCRIPT TO SEND REMINDERS
# Run the R script that will generate the pages
# (the series of '" are here because we need " for the R argument to be considered as text, 
#  the args have to be within ', but $ is expanded within ")
printf "\nSending reminders...\nNOTE: This takes a while because there is a 4-second pause between two emails (otherwise Gmail complains).\n\n"
cd R/
R CMD BATCH --no-save --no-restore '--args themonth="'"${1}"'"' send-reminder.R
cd ../

# Keep a copy of the Rout file as a reminder that reminders have been send.
cp R/send-reminder.Rout R/Backup_Rout/send-reminder_${1}.Rout

# Check the output
less R/Backup_Rout/send-reminder_${1}.Rout
