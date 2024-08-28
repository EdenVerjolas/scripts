######################################################################################
# Bash script to read a string and check whether it is an existing user in the system
######################################################################################

#!/bin/bash
echo "Hello, here we read a username and decide if its an existing user in this system"
read -r name1
if (( $(cat /etc/passwd | cut -d':' -f 1 | grep -x $name1 | wc -l) > "0" )); then
  echo "This username exists in this system, goodbye now"
else
  echo "This username does not exist in this system, goodbye now"
fi
read
exit
