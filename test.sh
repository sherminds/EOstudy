#!/bin/bash

# Argument: month (3 letter version, e.g., Apr)

# Exit if no argument supplied. 
ARG1=$1
if [ -z "$1" ]
then
printf "\nATTENTION: No argument supplied \n-> using the current month as argument.\n\n"
BIP=$(date +%b) 
ARG1=${1:-${BIP}}
fi
echo "${ARG1}"

