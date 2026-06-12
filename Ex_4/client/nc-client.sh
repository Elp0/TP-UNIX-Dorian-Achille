#!/bin/bash

clefServ=$(cat configNCC.cfg | grep "key" | cut -d ' ' -f 2)
portServ=$(cat configNCC.cfg | grep "port" | cut -d ' ' -f 2)

if [ $# == 1 ]; then
	ipServ="$1"
else
	ipServ="localhost"
fi

echo "Connection au server..."

function decrypt() {
	while read line;
	do
		line=$(echo $line | tr "$clefServ" 'A-Za-z')
		echo $line
	done
}

function crypt(){
	while read line;
	do
		line=$(echo $line | tr 'A-Za-z' "$clefServ")
		echo $line
	done
}

crypt | nc "$ipServ" "$portServ" | decrypt
