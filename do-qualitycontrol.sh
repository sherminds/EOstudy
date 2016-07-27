#!/bin/bash


# Argument: month (3 letter version, e.g., Apr)

# If no argument supplied, use the current month
ARG1=$1
if [ -z "$1" ]
then
printf "\nATTENTION: No argument supplied \n-> using the current month as argument.\n\n"
BIP=$(date +%b) 
ARG1=${1:-${BIP}}
fi
echo "${ARG1}"


echo "${1}"

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


# OPEN THE R SCRIPT TO DO QUALITY CONTROL
# Run the R script that will generate the pages
# (the series of '" are here because we need " for the R argument to be considered as text, 
#  the args have to be within ', but $ is expanded within ")
cd R/
R CMD BATCH --no-save --no-restore '--args themonth="'"${ARG1}"'"' qualitycontrol.R
cd ../

less R/qualitycontrol.Rout 
