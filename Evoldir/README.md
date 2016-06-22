
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

AND do put a comment in the Comments column (last one) to justify the decision. 

## Contents of AllData

Column | Description
-------|------------- 
Ad_ID | ID in the database; evoldir email subject (entered automatically)
Ad_date | Date evoldir email was sent (entered automatically)
Ad_Type | evoldir category (entered automatically)
Date_collection | date at which the rest of the data for this line was entered
Name_collector (F/N/S/L) | Initial of the person who entered these data
Short_name | Short name for the event, *will be email subject*, so be concise and precise
Type | Type of event (Symposium, Conference, Workshop, Course, Summer School), *will be in email*
Include | whether to include in the study/send email. If FALSE, detail in Comments
Location | Country where event is taking place
Website | website address of the event *will be in the questionnaire*
Org_country | Country of the main organizer	
Invited_nb | Total number of featured speakers (keynote+invited)	
Invited_W	| Number of female featured speakers (keynote+invited)
Instructor_nb | Total number of instructors (in case of course)	
Instructor_W | Number of female instructors (in case of course)	
Org_nb | Total number of organizers (either local org. committee, or unspecified)	
Org_W	| Number of female organizers
SciCom_nb | Total number of people in Scientific Committee (in case it is specified)	
SciCom_W | Number of women in scientific committee (in case it is specified)
Org_name1 | Last name of the main organizer	
Org_email1	| email address of the  main organizer
Org_name2 | Last name of another organizer	
Org_email2 | email of this other organizer	
Org_contacted | whether orgazinizer was contacted	
Date_emailsent | date at which emails were sent	
Org_reply | whether organizers replied	
Date_replyreceived | date at which the reply was received	
Q1	
Q2	
Q3	
Q4	
Q5	
Comments | In particular decision not to include


