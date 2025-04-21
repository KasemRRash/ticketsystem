#!/usr/bin/env bash

TICKET_FILE="ts_tickets.csv"

ticketsuche=$(echo $QUERY_STRING | grep -o 'ticketsuche=[^&]*' | sed 's/^ticketsuche=//g')
kundensuche=$(echo $QUERY_STRING | grep -o 'kundensuche=[^&]*' | sed 's/^kundensuche=//g')
statusfilter=$(echo $QUERY_STRING | grep -o 'statusfilter=[^&]*' | sed 's/^statusfilter=//g')
priofilter=$(echo $QUERY_STRING | grep -o 'priofilter=[^&]*' | sed 's/^priofilter=//g')
kategoriefilter=$(echo $QUERY_STRING | grep -o 'kategoriefilter=[^&]*' | sed 's/^kategoriefilter=//g')
bearbeiterfilter=$(echo $QUERY_STRING | grep -o 'bearbeiterfilter=[^&]*' | sed 's/^bearbeiterfilter=//g')

echo "Content-Type: text/html"
echo

echo "<!DOCTYPE html>
      <html>
        <head>
          <meta charset='utf-8'>
          <title> Dashboard | Admin </title>
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
                  background-color: #f3f3f3;
                }      
        </style>        
        </head>
        <body>
          <h1>Dashboard</h1>
          <h2> Filter </h2>
          <p> Es kann nach einem Filter pro Suche gefiltert werden </p>
          <form action='ts_admindashboard.sh' method='get'>
            <input type='text' name='ticketsuche' placeholder='Ticketsuche' value='$ticketsuche'>
            <input type='submit' value='Nach Ticketnummer suchen'>
          </form>  
          <form action='ts_admindashboard.sh' method='get'>
            <input type='text' name='kundensuche' placeholder='Kundensuche' value='$kundensuche'>
            <input type='submit' value='Nach Kundennamen suchen'>
            </form>
          <form action='ts_admindashboard.sh' method='get'>
            <select name='bearbeiterfilter'>
              <option value=''>Alle</option>
              <option value='Agent' $(if test "$bearbeiterfilter" == "Agent"; then echo 'selected'; fi)>Agent</option>
              <option value='Bruno' $(if test "$bearbeiterfilter" == "Bruno"; then echo 'selected'; fi)>Bruno</option>
              </select>
              <input type='submit' value='Nach Bearbeiter filtern'>
              </form>
          <form action='ts_admindashboard.sh' method='get'>
            <select name='statusfilter'>
              <option value=''>Alle</option>
              <option value='Neu' $(if test "$statusfilter" == "Neu"; then echo 'selected'; fi)>Neu</option>
              <option value='Bearbeitung' $(if test "$statusfilter" == "Bearbeitung"; then echo 'selected'; fi)>Bearbeitung</option>
              <option value='Geschlossen' $(if test "$statusfilter" == "Geschlossen"; then echo 'selected'; fi)>Geschlossen</option>
              </select>
              <input type='submit' value='Nach Status filtern'>
         </form>
         <form action='ts_admindashboard.sh' method='get'>
          <select name='kategoriefilter'>
            <option value=''>Alle</option>
            <option value='IT-Support' $(if test "$kategoriefilter" == "IT-Support"; then echo 'selected'; fi)>IT-Support</option>
            <option value='Verkauf' $(if test "$kategoriefilter" == "Verkauf"; then echo 'selected'; fi)>Verkauf</option>
          </select>
          <input type='submit' value='Nach Kategorie filtern'>
         </form>
         <form action='ts_admindashboard.sh' method='get'>
            <select name='priofilter'>
              <option value=''>Alle</option>
              <option value='1' $(if test "$priofilter" == "1"; then echo 'selected'; fi)>1</option>
              <option value='2' $(if test "$priofilter" == "2"; then echo 'selected'; fi)>2</option>
              <option value='3' $(if test "$priofilter" == "3"; then echo 'selected'; fi)>3</option>
            </select>
          <input type='submit' value='Nach Priorität filtern'>
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
    if test -z "$kundensuche" || test "$kunde" == "$kundensuche"; then
    if test -z "$statusfilter" || test "$status" == "$statusfilter"; then
     if test -z "$priofilter" || test "$prio" == "$priofilter"; then
      if test -z "$kategoriefilter" || test "$kategorie" == "$kategoriefilter"; then
       if test -z "$bearbeiterfilter" || test "$bearbeiter" == "$bearbeiterfilter"; then 
                echo "<tr><td><a href='ts_adminticketdetail.sh?ticketid=$id'>$id</a></td><td>$kunde</td><td>$kategorie</td><td>$beschreibung</td><td>$telefonnummer</td><td>$bearbeiter</td><td>$status</td><td>$prio</td><td>$datum</td></tr>"
                ((++ticketid))
    fi 
  fi 
    fi 
  fi 
  fi 
  fi
  
              done < "$TICKET_FILE"

          echo "</table>
          <br>
          <form action='ts_adminticketform.sh' method='get'>
            <input type='submit' value='Ticket erstellen'>
          </form><br>
          <form action='ts_logout.sh' method='get'>
            <input type='submit' value='Logout'>
          </form>  
        </body>
      </html>"  
