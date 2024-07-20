#!/bin/bash
echo -e "Hello, here we read a username and decide if its an existing user in this system \n"
read -r name1
if [[ $(lslogins -l $name1 -o USER | grep $name1 | wc -l) -ne 0 ]] ;then
 echo -e "This username exists in this system, goodbye now \n"
read
 exit
fi
echo -e "This username does not exist in this system, goodbye now \n"
read
exit
