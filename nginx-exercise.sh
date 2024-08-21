#!/bin/bash
while true; do
	clear
	echo -e "Welcome to the NGINX Server Manager, what would you like to do today - "
	echo -e "1. Print server logs"
	echo -e "2. Restart a service"
	echo -e "3. Print in-use ports"
	echo -e "4. Modify ports"
	echo -e "9. Exit"
	echo -e "\nhttp://$(awk '/server_name/{sub(";","");print $2}' /etc/nginx/sites-enabled/default):$(awk '/listen/{sub(";"," "); print $2}' /etc/nginx/sites-enabled/default) \n"
	read -srn1 choice1
	case $choice1 in
	1)
		clear
		echo -e "Is there any specific date you would like to see? y/n"
		read -srn1 choice2
		if [[ "$choice2" == "n" ]] || [[ "$choice2" == "N" ]]; then
			echo -e "Server access logs :"
			read
			less /var/log/nginx/access.log
			echo -e "Server error logs :"
			read
			less /var/log/nginx/error.log
		else
			clear
			echo -e "Please enter data to look for in Server Access Log or Server Error Log"
			read -r input1
			echo -e "Access Log Results -"
			awk '/'$input1'/' /var/log/nginx/access.log
			read
			echo -e "Error Log Results -"
			awk '/'$input1'/' /var/log/nginx/error.log
			read
		fi
		;;
	2)
		sudo service nginx restart
		if [[ $? ]]; then
			echo -e "Server restarted"
			read
		else
			echo -e "Error occured"
			read
		fi
		;;
	3)
		clear
		echo -e "TCP ports in use -"
		awk '/listen/{sub(";"," "); print $2}' /etc/nginx/sites-enabled/default
		read
		;;
	4)
		clear
		echo -e "Which TCP port would you like to use ?"
		read -r newport1
		oldport1=$(awk '/listen/{sub(";"," "); print $2}' /etc/nginx/sites-enabled/default)
		sed -i 's/'"$oldport1"'/'"$newport1"'/' /etc/nginx/sites-enabled/default
		sudo service nginx restart
		echo -e "Changes made - new TCP port in use - $(awk '/listen/{sub(";"," "); print $2}' /etc/nginx/sites-enabled/default)"
		read
		;;
	9)
		echo -e "\nGoodbye now thanks"
		read
		clear
		exit
		;;
	esac
done
