#!/bin/bash clef.key A-Za-z

# Tant que pas recut bienvenue sur le serv

rm ./fifoNCC
mkfifo ./fifoNCC

fonction interpret(){
	while read line;
	do
		if [ $line =  
}


nc localhost 12345
