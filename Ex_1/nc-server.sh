#!/bin/bash

while :
do
	date | nc -l -p 12345
done
