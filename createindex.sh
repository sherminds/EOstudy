#!/bin/bash

# This script creates an index of all the evoldir-related pages on the website
# ! You need to update the list of months in the for loop to include new ones.
# ! Do not forget to add the new pagedir.html to github!

for month in Apr May Jun
do
  # List the ads in this month
  ls ${month} > list.txt

  # Print the month
  echo '<h3>'"${month}"'</h3>'
  echo '<p>'

  # For each ad, print a line with the link
  cat list.txt | while read line
  do 
    echo '<a href="'"${month}"'/'"${line}"'">'"${month}"'/'"${line}"'</a><br>'
  done
  echo '</p>'
done > tmplist

# Concatenate the files
cat  R/pagedir_part1 tmplist R/pagedir_part2 > pagedir.html

# Clean
rm tmplist
rm list.txt

# Git 
git add pagedir.html
git commit -m "adding toc page"
git push origin gh-pages
