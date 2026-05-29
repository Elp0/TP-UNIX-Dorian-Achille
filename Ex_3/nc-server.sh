#!/bin/bash

# Pour se connecter, tapez: "nc [ip du serveur] 12345"

rm ./fifo
mkfifo ./fifo

mdp=$(cat config.cfg)

function interpret(){
	echo "Entrez le mot de passe: "
	while read line;
	do
		if [ $line == $mdp ]; then
			break
		fi
		echo "Mauvais mot de passe"
	done
	echo "Bienvenue sur le serveur"
	date
	while read line;
	do
		eval echo \$\($line\)
	done
}

nc -l -p 12345 < ./fifo | interpret > ./fifo

./nc-server.sh
