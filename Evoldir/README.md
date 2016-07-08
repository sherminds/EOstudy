
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

  In the `_summary.md` file for each ad (in `Evoldir/ads/MON`, where MON is 3-letter month), compile all the names of speakers and organisers that you can find in the evoldir ad and on the ad website (remove *, - and superfluous things to end up with clean lists with one name per line)

 3) Fill in the Data set

   For each ad, fill in the AllData table in Google drive 

## Inclusion rule

Set include = FALSE if

 - no information on invited speakers/info at all (neither in ad nor website)
 - if Course: if run by private company like prstatistics (we want to focus on "academic" events)

AND do put a comment in the Comments column (last one) to justify the decision. 

## Assumptions

If no other piece of information is found about the organizers, assume that the person who sent the evoldir email is an organizers. We need to try to always fill in entries for the organizers as well.

## Contents of AllData

Column | Description
-------|------------- 
Ad_ID | ID in the database; evoldir email subject (entered automatically)
Ad_date | Date evoldir email was sent (entered automatically)
Ad_Type | evoldir category (entered automatically)
Date_collection | date at which the rest of the data for this line was entered
Name_collector (F/N/S/L) | Initial of the person who entered these data
Short_name | Short name for the event, **will be email subject**, so be concise and precise
Type | Type of event (Symposium, Conference, Workshop, Course, Summer School), **will be in email**
Include | whether to include in the study/send email. If FALSE, detail in Comments
Location | Country where event is taking place
Website | website address of the event **will be in the questionnaire**
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
Month	| 3-letter month (extracted from Ad_date), for sorting
Comments | In particular decision not to include
Date_emailsent | date at which emails were sent	
Org_reply1 | Whether organizer replied	after the first email
Date_relance | Date at which 2nd email was sent
Org_reply2 | Whether organizer replied after second email
Timestamp	| *data from answers file:* date of reply
Event name | *data from answers file:* code of event (quality check, has to be the same as Ad_ID)
Question 0 | *data from answers file:* 
New_Invited_nb	| *data from answers file*
New_Invited_W | *data from answers file*
New_Instructor_nb | *data from answers file*
New_Instructor_W | *data from answers file*
New_Org_nb | *data from answers file*
New_Org_W | *data from answers file*
New_SciCom_nb | *data from answers file*
New_SciCom_W | *data from answers file*
Question 1 | *data from answers file*
Question 2 | *data from answers file*
Question 3 | *data from answers file*
Question 4 | *data from answers file*
Question 5 | *data from answers file*
KeepInformed | *data from answers file*
