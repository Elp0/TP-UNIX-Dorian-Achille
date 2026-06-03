#!/bin/bash

# Pour se connecter, tapez: "nc [ip du serveur] 12345"

rm ./fifoNCS
mkfifo ./fifoNCS

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
	echo "Entrez la clef de chiffrement: "
	read key
	date
	echo "Bienvenue sur le serveur"
	while read line;
	do
		eval echo \$\($line\)
	done
}

nc -l -p 12345 < ./fifoNCS | interpret > ./fifoNCS

./nc-server.sh
