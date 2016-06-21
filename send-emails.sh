#!/bin/bash

# Argument: month (3 letter version, e.g., Apr)

echo "${1}"

# Run the R script that will generate the pages
# (the series of '" are here because we need " for the R argument to be considered as text, 
#  the args have to be within ', but $ is expanded within ")
R CMD BATCH --no-save --no-restore '--args themonth="'"${1}"'"' send-emails.R

less send-emails.Rout
