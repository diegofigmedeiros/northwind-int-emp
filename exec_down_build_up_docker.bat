@echo off 
Rem Executa docker compose build e up
docker compose down --volumes && docker compose build && docker compose up