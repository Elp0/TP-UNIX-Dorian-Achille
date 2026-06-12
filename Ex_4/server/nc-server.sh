#!/bin/bash

rm ./fifoNCS
mkfifo ./fifoNCS

mdpServ=$(cat configNCS.cfg | grep "pwd" | cut -d ' ' -f 2)
clefServ=$(cat configNCS.cfg | grep "key" | cut -d ' ' -f 2)
portServ=$(cat configNCS.cfg | grep "port" | cut -d ' ' -f 2)

echo "Serveur lancé"

function interpret(){
	ecrire "Entrez le mot de passe: "
	while read line;
	do
		line=$(echo $line | tr "$clefServ" 'A-Za-z')
		if [ "$line" == "$mdpServ" ]; then
			break
		fi
		ecrire "Mauvais mot de passe"
	done
	ecrire $(date)
	ecrire "Bienvenue sur le serveur"
	while read line;
	do
		line=$(echo $line | tr "$clefServ" 'A-Za-z')
		eval ecrire \$\($line\)
	done
}

function ecrire() {
	echo $@ | tr 'A-Za-z' "$clefServ"
}

nc -l -p "$portServ" < ./fifoNCS | interpret > ./fifoNCS

echo "Redémarrage du serveur"

./nc-server.sh

