#!/usr/bin/env bash

echo "Content-Type: text/html"
echo 

echo "<!DOCTYPE html>
      <html>
      <head>
        <meta charset='utf-8'>
        <title> Dashboard | Kunde </title>
      </head>
      <body>
        <h1> Ticket Formular </h1>
        <form action='ts_adminticketspeichern.sh' method='get'>
        <input type='text' name='kundenname' placeholder='Name des Kunden' required><br>
          <select name='kategorie' required>
            <option value='' disabled selected hidden>Kategorie wählen</option>
            <option value='IT-Support'>IT-Support</option>
            <option value='Verkauf'>Verkauf</option>
          </select><br>

          <textarea name='beschreibung' placeholder='Beschreibung des Problems' required></textarea><br>
          <input type='tel' name='telefonnummer' placeholder='5 bis 15 Ziffern erlaubt' pattern='[0-9]{5,15}' required><br>
          <input type='submit' value='Problem melden'>
          </form>
          <form action='ts_logout.sh' method='get'>
            <input type='submit' value='Logout'>  
        </form>
      </body>
    </html>"  
