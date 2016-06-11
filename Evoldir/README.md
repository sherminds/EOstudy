
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



