#!/bin/bash

# Pour se connecter, tapez: "nc [ip du serveur] 12345"

while :
do
	date | nc -l -p 12345
done
