#!/bin/bash

##############################################################################################################################
# Function to print NGINX server log files
##############################################################################################################################

print-server-logs() {
	clear
	echo -e "Is there any specific date you would like to see? y/n"
	read -srn1 choice2
	if [[ "$choice2" == "n" ]] || [[ "$choice2" == "N" ]]; then
		if [[ -f /var/log/nginx/access.log ]]; then
			echo -e "Server access logs :"
			read
			less /var/log/nginx/access.log
		else
			echo -e "\nNo access log file found"
			read
		fi
		if [[ -f /var/log/nginx/error.log ]]; then
			echo -e "Server error logs :"
			read
			less /var/log/nginx/error.log
		else
			echo -e "No error log file found"
			read
		fi
	else
		clear
		echo -e "Please enter data to look for in Server Access Log or Server Error Log"
		read -r input1
		echo -e "Access Log Results -"
		awk '/'$input1'/' /var/log/nginx/access.log 2>/dev/null
		read
		echo -e "Error Log Results -"
		awk '/'$input1'/' /var/log/nginx/error.log 2>/dev/null
		read
	fi
}

#######################################################################################################################################################################
# Function to restart NGINX service
######################################################################################################################################################################

restart-nginx-service() {
	sudo service nginx restart
	if [[ $? ]]; then
		echo -e "Server restarted"
		read
	else
		echo -e "Error occured"
		read
	fi

}

###########################################################################################################################################################################
# Function to print in-use tcp ports by NGINX server
###########################################################################################################################################################################

print-tcp-port() {
	clear
	echo -e "TCP ports in use -"
	awk '/listen/{sub(";"," "); print $2}' /etc/nginx/sites-enabled/default
	read

}

##########################################################################################################################################################################
# Function to change tcp port for NGINX server
###########################################################################################################################################################################

change-tcp-port() {
	clear
	echo -e "Which TCP port would you like to use ?"
	read -r newport1
	if ! [[ $newport1 =~ [0-9]+$ ]]; then
		echo -e "Numbers only please, thanks"
		read
	else
		oldport1=$(awk '/listen/{sub(";"," "); print $2}' /etc/nginx/sites-enabled/default)
		sed -i 's/'"$oldport1"'/'"$newport1"'/' /etc/nginx/sites-enabled/default
		sudo service nginx restart
		echo -e "Changes made - new TCP port in use - $(awk '/listen/{sub(";"," "); print $2}' /etc/nginx/sites-enabled/default)"
		read
	fi

}

##############################################################################################################################################################################
# Function to delete NGINX access log and error log files
##############################################################################################################################################################################

delete-nginx-logs() {
	clear
	echo -e "About to delete NGINX Server logs, proceed? y/n"
	read -srn1 choice2
	if [[ $choice2 == "y" ]] || [[ $choice2 == "Y" ]]; then
		rm /var/log/nginx/access.log 2>/dev/null
		rm /var/log/nginx/error.log 2>/dev/null
		echo -e "Logs deleted"
		read
	else
		echo -e "Logs not deleted"
		read
	fi

}

#########################################################################################################################################################################
# Infinite loop to print selection menu
#########################################################################################################################################################################

while true; do
	clear
	echo -e "Welcome to the NGINX Server Manager, what would you like to do today - "
	echo -e "1. Print server logs"
	echo -e "2. Restart a service"
	echo -e "3. Print in-use ports"
	echo -e "4. Modify ports"
	echo -e "5. Clear logs"
	echo -e "9. Exit"

	##########################################################################################################################################################################
	# print NGINX server link for browser use
	#########################################################################################################################################################################

	echo -e "\nServer address"
	echo -e "http://$(awk '/server_name/{sub(";","");print $2}' /etc/nginx/sites-enabled/default):$(awk '/listen/{sub(";"," "); print $2}' /etc/nginx/sites-enabled/default) \n"
	read -srn1 choice1

	#######################################################################################################################################################################
	# case selection by input
	#######################################################################################################################################################################

	case $choice1 in
	1)
		print-server-logs
		;;
	2)
		restart-nginx-service
		;;
	3)
		print-tcp-port
		;;
	4)
		change-tcp-port
		;;
	5)
		delete-nginx-logs
		;;
	9)
		echo -e "\nGoodbye now thanks"
		read
		clear
		exit
		;;
	esac
done
