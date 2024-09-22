######################################################################################
# Bash script to read a string and check whether it is an existing user in the system
######################################################################################

#!/bin/bash

check-user() {
	echo "Please enter a username to check whether it exists in this system"
	read -r name1
	if (($(cat /etc/passwd | cut -d':' -f 1 | grep -x $name1 | wc -l) > "0")); then
		echo "This username exists in this system"
	else
		echo "This username does not exist in this system"
	fi
	read
}
while true; do
	clear
	echo -e "Username search, proceed ? y/n"
	read -rn1 choice1
	if [[ "$choice1" == "y" ]]; then
		clear
		check-user
	else
		echo -e "Goodbye now, thanks"
		clear
		break
	fi
done
exit
