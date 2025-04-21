#!/usr/bin/env bash

TICKET_FILE="ts_tickets.csv"
TEMP_FILE="ts_temp.csv"
DOK_FILE="ts_doku.csv"

> "$TEMP_FILE"

ticketid=$(echo $QUERY_STRING | grep -o 'ticketid=[^&]*' | sed 's/^ticketid=//g')
dokumentationneu=$(echo $QUERY_STRING | grep -o 'dokumentationneu=[^&]*' | sed 's/^dokumentationneu=//g ; s/+/ /g ; s/%C3%A4/ä/g ; s/%C3%B6/ö/g ; s/%C3%BC/ü/g ; s/%C3%84/Ä/g ; s/%C3%96/Ö/g ; s/%C3%9C/Ü/g ; s/%2C/,/g ; s/%3F/?/g; s/%21/!/g'  )
prioneu=$(echo $QUERY_STRING | grep -o 'prio=[^&]*' | sed 's/^prio=//g')
statusneu=$(echo $QUERY_STRING | grep -o 'status=[^&]*' | sed 's/^status=//g')
datumneu=$(date '+%d.%m.%Y %H:%M')
bearbeiterneu="Bruno"
kategorieneu=$(echo $QUERY_STRING | grep -o 'kategorie=[^&]*' | sed 's/^kategorie=//g')

while IFS='|' read -r id kundenname kategorie beschreibung telefonnummer bearbeiter status prio datum; do 
  if test "$id" == "$ticketid"; then
    if test -n "$prioneu"; then
      prio=$prioneu
    fi
    if test -n "$kategorieneu"; then
      kategorie=$kategorieneu
    fi
    if test -n "$statusneu"; then
      status=$statusneu
      bearbeiter=$bearbeiterneu
    fi 
    echo "$id|$kundenname|$kategorie|$beschreibung|$telefonnummer|$bearbeiter|$status|$prio|$datum" >> "$TEMP_FILE"
  else
    echo "$id|$kundenname|$kategorie|$beschreibung|$telefonnummer|$bearbeiter|$status|$prio|$datum" >> "$TEMP_FILE"
  fi
done < "$TICKET_FILE"

cat "$TEMP_FILE" > "$TICKET_FILE"

if test -n "$dokumentationneu"; then
  echo "$ticketid|$datumneu|$dokumentationneu" >> "$DOK_FILE"
fi


echo "Content-Type: text/html"
echo 

echo "<!DOCTYPE>
      <html>
      <head>
      <meta charset='utf-8'>
      <meta http-equiv='Refresh' content='1; url=ts_adminticketdetail.sh?ticketid=$ticketid'>
      </head>
      <body>
      <h1> Ticketupdate erfolgreich! </h1>
      </body>
      </html>"
