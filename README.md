# How-to

## Create the webpages
type 
```{sh}
./generatepages.sh Mon
```
in a terminal, where `Mon` is the three-letter version of the month.  
The script will return an error if the month is not supplied.  
The script automatically pushes the new pages to Github. 

## Create an index
 - Update `createindex.sh` to include the month you want in the loop
 
 - Type 
```{sh}
./createindex.sh
```
in a terminal. This creates a page `pagedir.html` that lists all the pages we created.  
The script automatically pushes this new page to Github.

## Send the emails

### Checklist

- Check a few of the generated pages (using `pagedir.html` to easily find them); check numbers, shape of the tables, whether ad and website links work. 

- Check the AllData table (Google Drive): 
  - You can sort it by Month and by Include to focus on the emails that will be sent;  
  - Check the column "Short name": has to be concise and precise, because this will be the email's subject line  
  - Check the column "Event type": has to be one of Workshop, Conference, Symposium, Summer School, Course.  
  - Check consistency between names and emails.  
The script will download the current state of this table as `csv` file (in the `data/` folder), make a copy with today's date.

- In a terminal, type
```{sh}
./send-emails.sh Mon
```
where Mon is a 3-letter version of the month you want to send the emails for (Apr, May, ...).

- Go to the EOstudy Gmail account, check the `Sent` folder. 

## Send the reminders

### Checklist

- Make sure that you have integrated the Responses in the AllData file!
  (TODO: a R script to check this)



# Acknowledgements

Trick for the forms found there <https://github.com/toperkin/staticFormEmails/blob/master/README.md>
