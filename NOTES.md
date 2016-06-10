# Setting up emails
Source:
http://www.anujgakhar.com/2011/12/09/using-macosx-lion-command-line-mail-with-gmail-as-smtp/

## Configure Postfix for Gmail SMTP
Edit file `/etc/postfix/main.cf`

```
sudo vim /etc/postfix/main.cf
```
and add in the following below the commented out relayhosts :-
```
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_use_tls = yes
```
## Generate sasl_password if not already exists
```
sudo vim /etc/postfix/sasl_passwd
```
and enter in the following:

```
[smtp.gmail.com]:587 username@gmail.com:password
```

## Run the following commands
```
sudo chmod 600 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd
sudo launchctl stop org.postfix.master
sudo launchctl start org.postfix.master
```
And you are done...

Now, you should be able to send emails from within the command line e.g. to send the contents of a directory as a tree to an email address

```
tree /var/www/somefolder | mail -s "contents" your@yourdomain.com
```
Hope someone finds this useful!

