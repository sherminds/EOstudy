#!/bin/bash

# Argument: month (3 letter version, e.g., Apr)

# Exit if no argument supplied. 
if [ -z "$1" ]
then
  printf "\nERROR: No argument supplied. \n       Supply 3-letter version of month (Apr, May, ...)\n\n"
  exit 1
fi

echo "${1}"

# Get today's date
todaydate=$(date +%Y-%m-%d)

# Download the Google Spreadsheet
curl "https://docs.google.com/spreadsheets/d/1i67UACuGm4gKLlunEzIHdxCBSZJP2bhZWB3lSPkEocg/export?gid=0&format=csv" > data/data.csv

# Save it, and append today's date to the file name for future reference
# (technically this is not need because we are using git...!)
cp data/data.csv data/data${todaydate}.csv

# Run the R script that will generate the pages
# (the series of '" are here because we need " for the R argument to be considered as text, 
#  the args have to be within ', but $ is expanded within ")
cd R/
R CMD BATCH --no-save --no-restore '--args themonth="'"${1}"'"' fill-pages.R
cd ../

# Git
git add .
git commit -m "new webpages"
git push origin gh-pages