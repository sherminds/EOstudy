
# Get data from the evoldir website

type
```
./getlist Month
```
where `Month` is the three letter version of the month (Jan, Fev, ...). 

This (replace `Month` by the 3-letter month)
- creates a `.csv` file `ads_Month.csv` listing all the ads, their date and type (Conferences/WorkshopsCourses).
- downloads all the texts of the ads, stored in a folder `ads/Month/`.
- copies the list of ads in the working directory, to later include it in the file with all data.
- creates `_summary.md` file for each ad, that will be filled in later.

# Compile evoldir data

## Tasks

 1) Add the ads in the AllData file on Google Drive
   Copy-paste the list generated with the above-mentionned script ad the end of the table.

 2) Fill in the summary file

    In the `_summary.md` file for each ad, compile all the names of speakers and organisers that you can find in the evoldir ad and on the ad website (remove *, - and superfluous things to end up with clean lists with one name per line)

 3) Fill in the Data set

   For each ad, fill in the AllData table in Google drive 

## Inclusion rule

Set include = FALSE if

 - no information on invited speakers/info at all (neither in ad nor website)
 - if Course: if run by private company like prstatistics (we want to focus on "academic" events)


