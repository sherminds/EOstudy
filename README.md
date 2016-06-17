# How-to
## Create the webpages
type 
```{sh}
./generatepages.sh Mon
```
in a terminal, where `Mon` is the three-letter version of the month. 

## Create an index
 - Update `createindex.sh` to include the month you want in the loop
 
 - Type 
```{sh}
./createindex.sh
```
in a terminal. This creates a page `pagedir.html` that lists all the pages we created.

** and do not forget to commit and push to the `gh-pages` branch! ** 


# Acknowledgements
Trick for the forms found there <https://github.com/toperkin/staticFormEmails/blob/master/README.md>
