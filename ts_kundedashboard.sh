#!/usr/bin/env bash

TICKET_FILE="ts_tickets.csv"

ticketsuche=$(echo $QUERY_STRING | grep -o 'ticketsuche=[^&]*' | sed 's/^ticketsuche=//g')
statusfilter=$(echo $QUERY_STRING | grep -o 'statusfilter=[^&]*' | sed 's/^statusfilter=//g')
kategoriefilter=$(echo $QUERY_STRING | grep -o 'kategoriefilter=[^&]*' | sed 's/^kategoriefilter=//g')

echo "Content-Type: text/html"
echo

echo "<!DOCTYPE html>
      <html>
        <head>
          <meta charset='utf-8'>
          <title> Dashboard | Kunde </title>
          <link rel='stylesheet' type='text/css' href='https://informatik.hs-bremerhaven.de/docker-step2023-team-04-web/css/kunde.css'>
          <style>
            table { 
                    width:100%;
                    border-collapse: collapse;
                  }
            th, td { 
                    border: 1px solid #ddd;
                    padding: 8px;
                    text-align: left;
                  }
            th {
                  background-color: #3ab09e;
                }      
        </style>        
        </head>
        <body>
          <h1>Dashboard</h1>
          <h2> Filter </h2>
          <p> Es kann nach einem Filter pro Suche gefiltert werden </p>
         <!-- Suchen --> 
          <form action='ts_kundedashboard.sh' method='get'>
            <input type='text' name='ticketsuche' placeholder='Ticketsuche' value='$ticketsuche'>
            <input type='submit' value='Nach Ticketnummer suchen'>
           </form>
         <!-- Filter -->
         <form action='ts_kundedashboard.sh' method='get'>
          <select name='statusfilter'>
            <option value=''>Alle</option>
            <option value='Neu' $(if test "$statusfilter" == "Neu"; then echo 'selected'; fi)>Neu</option>
            <option value='Bearbeitung' $(if test "$statusfilter" == "Bearbeitung"; then echo 'selected'; fi)>Bearbeitung</option>
            <option value='Geschlossen' $(if test "$statusfilter" == "Geschlossen"; then echo 'selected'; fi)>Geschlossen</option>
            </select>
            <input type='submit' value='Nach Status filtern'>
            </form>
            <form action='ts_kundedashboard.sh' method='get'>
              <select name='kategoriefilter'>  
            <option value=''>Alle</option>
              <option value='IT-Support' $(if test "$kategoriefilter" == "IT-Support"; then echo 'selected'; fi)>IT-Support</option>
              <option value='Verkauf' $(if test "$kategoriefilter" == "Verkauf"; then echo 'selected'; fi)>Verkauf</option>
              </select>
              <input type='submit' value='Nach Kategorie filtern'>
              </form>
          <h2> Tickets </h2>
          <table>
            <tablehead>
              <tr>
                <th>Ticket ID</th>
                <th>Kunde</th>
                <th>Kategorie</th>
                <th>Beschreibung</th>
                <th>Telefonnummer</th>
                <th>Bearbeiter</th>
                <th>Status</th>
                <th>Priorität</th>
                <th>Erstelldatum</th>
              </tr>
            </tablehead>
            <tablebody>"
       
while IFS='|' read -r id kunde kategorie beschreibung telefonnummer bearbeiter status prio datum; do
  if test -z "$ticketsuche" || test "$id" == "$ticketsuche"; then
    if test -z "$statusfilter" || test "$status" == "$statusfilter"; then
      if test -z "$kategoriefilter" || test "$kategorie" == "$kategoriefilter"; then
                echo "<tr><td><a href="ts_kundeticketdetail.sh?ticketid=$id">$id</a></td><td>$kunde</td><td>$kategorie</td><td>$beschreibung</td><td>$telefonnummer</td><td>$bearbeiter</td><td>$status</td><td>$prio</td><td>$datum</td></tr>"
                ((++ticketid))
  fi 
  fi 
  fi
              done < "$TICKET_FILE"

          echo "
          </tablebody>
          </table><br>
          <form action='ts_kundeticketform.sh' method='get'>
            <input type='submit' value='Ticket erstellen'>
          </form><br>
          <form action='ts_logout.sh' method='get'>
            <input type='submit' value='Logout'>
          </form>  
        </body>
      </html>"  
