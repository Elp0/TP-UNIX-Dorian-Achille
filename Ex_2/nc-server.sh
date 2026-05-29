#!/bin/bash

# Pour se connecter, tapez: "nc [ip du serveur] 12345"

rm ./fifo
mkfifo ./fifo

function interpret(){
	echo "Bienvenue sur le serveur"
	date
	while read line;
	do
		eval echo \$\($line\)
	done
}

nc -l -p 12345 < ./fifo | interpret > ./fifo

./nc-server.sh
