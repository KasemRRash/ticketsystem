#!/usr/bin/env bash

echo "Content-Type: text/html"
echo

echo "<!DOCTYPE html>
      <html>
      <head>
      <meta charset='utf-8'>
      <link rel='stylesheet' type='text/css' href='https://informatik.hs-bremerhaven.de/docker-step2023-team-04-web/css/loginpage.css'>
      <title>Login | Team 04</title>
      </head>
      <body>
        <header>
        <nav>
          <ul>
            <li><a href='index.sh'>Home</a></li>
            <li><a href='ais_aisdaten.sh'>AIS-Daten</a></li>
            <li><a href='ts_login.sh'>Ticketsystem</a></li>
            <li><a href='about.sh'>Über uns</a></li>
            </ul>
            </nav>
            </header>
        
        <main>
          <form action="ts_loginskript.sh" method="get">
          <h1>Login</h1>
          <h2> Loggen sie sich bitte ein </h2>
          <input type="text" name="username" placeholder="Benutzername"><br>
          <input type="password" name="password" placeholder="Passwort"><br>
          <input type="submit" value="Login">
          </form>
      </body>
      </html>"
