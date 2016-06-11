#!/bin/bash

# Argument 1: month

# Print error if no argument supplied
if [[ $# -eq 0 ]] ; then
  echo 'Error: You need to supply the month (Jan, Fev, ...) as argument'
  exit 1
fi

mkdir "ads/${1}"

for typeevent in "Conferences" "WorkshopsCourses"
do
  echo ================================== $typeevent ==================================
  # Download the evoldir webpage
  curl "http://life.mcmaster.ca/cgi-bin/my_wrap/brian/evoldir/${typeevent}/" > ${typeevent}.txt

  # Extract information from the source code: take lines with ads and with month
  grep "~brian/evoldir/.* $1 " ${typeevent}.txt > ${typeevent}_tmp.txt

  # Reformat
  # 1: remove end of link </a>
  # 2: remove beginning of link ...">
  # 3: remove spaces before month
  # 4: remove hour at the end
  # 5: reformat date so that they all have same length
  # 6: add typeevent at the end of the line
  sed -e 's/<\/a>//g' -e 's/^.*">//g' -e "s/ .*$1/, $1/g" -e 's/ [0-9]\{2\}:[0-9]\{2\}//g' -e "s/$1  /$1 0/g" -e "s/$/, ${typeevent}/g" ${typeevent}_tmp.txt > ${typeevent}_tmp2.txt

  # Download the ads
  cat ${typeevent}_tmp2.txt | cut -d, -f1 | while read line
  do
    echo $line
curl "http://life.mcmaster.ca/cgi-bin/my_wrap/brian/evoldir/${typeevent}/${line}" > ads/${1}/${line}.txt
  done
done

# Concatenate the files
cat Conferences_tmp2.txt WorkshopsCourses_tmp2.txt > ads_$1.csv

# Clean dir
rm *tmp*.txt
rm Conferences.txt
rm WorkshopsCourses.txt

# Copy the output file in the working directory, to later add them to the whole file
cp ads_$1.csv ../TMP_ads_$1.csv

