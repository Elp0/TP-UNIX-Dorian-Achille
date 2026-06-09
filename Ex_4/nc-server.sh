#!/bin/bash

rm ./fifoNCS
mkfifo ./fifoNCS

mdp=$(sed '1q;d' configNCS.cfg)

echo "Lancement du server"

function interpret(){
	ecrire "Entrez le mot de passe: "
	while lire;
	do
		if [ "$line" == $mdp ]; then
			break
		fi
		ecrire "Mauvais mot de passe"
	done
	if [ "$line" == quit ]; then
		return
	fi
	ecrire $(date)
	ecrire "Bienvenue sur le serveur"
	while lire;
	do
		eval ecrire \$\("$line"\)
	done
}	

function lire() {
	read line
	line=$(echo "$line" | tr $(sed '2q;d' configNCS.cfg) 'A-Za-z')
	if [ "$line" == quit ] || [ "$line" == "^C" ]; then
		return 1
	fi
}

function ecrire() {
	echo $@ | tr 'A-Za-z' $(sed '2q;d' configNCS.cfg)
}



nc -l -p 12345 < ./fifoNCS | interpret > ./fifoNCS

echo "Fin du serv"

./nc-server.sh
