#!/usr/bin/env bash

echo "Content-Type: text/html"
echo 

username=$(echo $QUERY_STRING | grep -o 'username=[^&]*' | sed 's/^username=//g')
password=$(echo $QUERY_STRING | grep -o 'password=[^&]*' | sed 's/^password=//g')


if test "$username" = "theo" && test "$password" = "tester"; then
  ./ts_kundedashboard.sh
elif test "$username" = "bruno" && test "$password" = "beispiel"; then
  ./ts_admindashboard.sh
else 
echo "<html><head><title>Login fehlgeschlagen</title></head><body><h1>Login fehlgeschlagen</h1><p>Anmeldedaten ungültig.</p></body></html>"
fi 

