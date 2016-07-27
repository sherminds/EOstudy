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

if [ -f "R/Backup_Rout/send-reminder_${1}.Rout" ];
then
printf "ATTENTION! \n    Reminders have already been sent once for ${1}! \n    Aborting.\n\n"
exit 1
fi

