#!/bin/bash
echo -e "Hello, here we read a username and decide if its an existing user in this system \n"
read -r name1
if lslogins -o USER $name1 | grep $name1 1>/dev/null 2>/dev/null; then
 echo -e "This username exists in this system, goodbye now \n"
read
 exit
fi
echo -e "This username does not exist in this system, goodbye now \n"
read
exit
