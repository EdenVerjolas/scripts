#!/bin/bash
 echo -e "Hello, here we read a username and decide if its an existing user in this system \n"
 read -r name1
 if  (( $(cat /etc/passwd | cut -d':' -f 1 | grep -x $name1 | wc -l) > "0" ))  ; then
  echo -e "This username exists in this system, goodbye now \n"
 else echo -e "This username does not exist in this system, goodbye now \n"
 fi
 read
 exit
