#!/usr/bin/env bash

TICKET_FILE="ts_tickets.csv"

kundenname=$(echo $QUERY_STRING | grep -o 'kundenname=[^&]*' | sed 's/^kundenname=//g ; s/+/ /g ; s/%C3%A4/ä/g ; s/%C3%B6/ö/g ; s/%C3%BC/ü/g ; s/%C3%84/Ä/g ; s/%C3%96/Ö/g ; s/%C3%9C/Ü/g ; s/%2C/,/g ; s/%3F/?/g ; s/%21/!/g')
kategorie=$(echo $QUERY_STRING | grep -o 'kategorie=[^&]*' | sed 's/^kategorie=//g')
beschreibung=$(echo $QUERY_STRING | grep -o 'beschreibung=[^&]*' | sed 's/^beschreibung=//g; s/+/ /g ; s/%C3%A4/ä/g ; s/%C3%B6/ö/g ; s/%C3%BC/ü/g ; s/%C3%84/Ä/g ; s/%C3%96/Ö/g ; s/%C3%9C/Ü/g ; s/%2C/,/g ; s/%3F/?/g ; s/%21/!/g')
telefonnummer=$(echo $QUERY_STRING | grep -o 'telefonnummer=[^&]*' | sed 's/^telefonnummer=//g')
bearbeiter="Agent"
status="Neu"
prio=3
datum=$(date '+%d.%m.%Y %H:%M')

zeile=$(wc -l < "$TICKET_FILE")
neueid=$((zeile + 1))

echo "$neueid|$kundenname|$kategorie|$beschreibung|$telefonnummer|$bearbeiter|$status|$prio|$datum" >> "$TICKET_FILE"
 
echo "Content-Type: text/html"
echo

echo "<!DOCTYPE html>
      <html>
        <head>
        <meta charset='utf-8'>
        <title> Ticket erstellt</title>
        </head>
        <body>
        <h1>Ticket erfolgreich erstellt!</h1>
        <a href="ts_kundedashboard.sh">Zum Dashboard</a>
        </body>
        </html>"
