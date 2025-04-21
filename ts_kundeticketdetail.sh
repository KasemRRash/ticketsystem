#!/usr/bin/env bash

DOK_FILE="ts_doku.csv"
TICKET_FILE="ts_tickets.csv"

echo "Content-Type: text/html"
echo 

ticketid=$(echo $QUERY_STRING | grep -o 'ticketid=[^&]*' | sed 's/^ticketid=//g')

zeile=$(head -n "$ticketid" "$TICKET_FILE" | tail -n 1)

IFS='|' read -r id kundenname kategorie beschreibung telefonnummer bearbeiter status prio datum <<< "$zeile"

echo "<!DOCTYPE>
      <html>
      <head>
      <meta charset='utf-8'>
      <title>Ticket $ticketid</title>
      <style>
        table {width: 100%; border-collapse: collapse;}
        th, td {border:1px solid #ddd; padding:8px; text-align:left;}
        </style>
      </head>
      <body>
      <h2>Ticket $ticketid</h2>
       <p>Kd.Name: $kundenname<p><br>
       <p>Kategorie: $kategorie</p><br>
       <p>Bearbeiter: $bearbeiter</p><br>
       <p>Status: $status</p><br>
       <p>Telefonnummer: $telefonnummer</p>
       <p>Priorität: $prio </p><br>
       <table>
        <tr>
          <th>Datum</th>
          <th>Dokumentation</th>
        </tr>
        <tr>
            <th>$datum</th>
            <th>$beschreibung</th>
        </tr>"
        while IFS='|' read -r id datum doku; do
          if test "$id" == "$ticketid"; then
            echo "<tr><th>$datum</th><th>$doku</th></tr>"
          fi
        done < "$DOK_FILE"
        echo "
    </table>
        <form action='ts_kundedashboard.sh' method='get'>
          <input type='submit' value='Zum Dashboard'>
         </form> 
       
        </body>
      </html>"
