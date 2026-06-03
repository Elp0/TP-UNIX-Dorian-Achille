#!/bin/bash

# Pour se connecter, tapez: "nc [ip du serveur] 12345"

rm ./fifoNCS
mkfifo ./fifoNCS

mdp=$(sed '1q;d' config.cfg)

function interpret(){
	ecrire "Entrez le mot de passe: "
	while lire;
	do
		if [ $line == $mdp ]; then
			break
		fi
		ecrire "Mauvais mot de passe"
	done
	ecrire $(date)
	ecrire "Bienvenue sur le serveur"
	while lire;
	do
		eval ecrire \$\($line\)
	done
}

function lire() {
	read line
	line=$(echo $line | tr $(sed '2q;d' config.cfg) 'A-Za-z')
}

function ecrire() {
	echo $@ | tr 'A-Za-z' $(sed '2q;d' config.cfg)
}

nc -l -p 12345 < ./fifoNCS | interpret > ./fifoNCS

./nc-server.sh

