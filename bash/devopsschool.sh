#!/bin/bash
#
# Testing of exercises from devopsschool.com
# Running the entire scripts in a while loop so we can comfortably test one exercise after another
#
while true; do
	clear
	echo -e "1. Output a specified direcoty's size"
	echo -e "2. Output a status of a file/directory"
	echo -e "3. Print max CPU and CPU usage"
	echo -e "4. Print disk usage"
	echo -e "5. Show hardware information"
	echo -e "6. Check if a number is odd or even"
	echo -e "7. Check if a number is an Armstrong number"
	echo -e "8. List of Armstrong numbers"
	echo -e "9. Check if a number is a Prime number"
	echo -e "10. List all prime numbers"
	echo -e "11. Check if a number is a Fibonacci number"
	echo -e "12. Convert decimal value to binary"
	echo -e "13. Find location of a given IP Address"
	echo -e "14. Rename a file"
	echo -e "15. Remove a file"
	echo -e "16. Create a file"
	echo -e "17. Create an archive of a folder"
	echo -e "18. Make a copy of a file"
	echo -e "19. Show CPU usage"
	echo -e "20. Print how many open files / maximum open files"
	echo -e "21. Print open ports"
	echo -e "22. Validate an Israeli ID Number"
	echo -e "99. Exit"
	read -rn2 choice1

	##########################################################################
	# 1) Get a name of a directory and displays its size using 'find' command
	##########################################################################
	case $choice1 in
	1)
		clear
		dir1="1"
		while [ $dir1 != "0" ]; do
			if [[ "$dir1" == "0" ]]; then
				:
			else
				clear
				echo -e "\n Please enter a directory's name in order to see its size, to exit, press 0 \n"
				read -r dir1
				if [ $dir1 = "0" ]; then
					:
				elif (($(sudo find / -name $dir1 2>/dev/null | wc -l) > "0")); then
					sudo find / -name $dir1 -exec du -sh '{}' \; 2>/dev/null | less -e
					clear
					echo -e "\n Press any key to try again, otherwise enter 0 to exit \n"
					read -rn1 dir1
				else
					clear
					echo -e "\n No such directory , press any key to try again, otherwise enter 0 to exit \n"
					read -n1 dir1
				fi
			fi
		done
		;;

	##########################################################################################
	# 2) Gets a directory name and displays its status regarding executability, file type
	##########################################################################################

	2)
		filedir=0
		while true; do
			if [[ $filedir == "E" ]]; then
				break
			fi
			clear
			echo -e "\nPlease enter a directory or a file to view its status, to exit, press E \n"
			read -r filedir
			if [[ $filedir == "E" ]]; then
				:
			elif (($(sudo find / -name $filedir 2>/dev/null | wc -l) > "0")); then
				sudo find / -name $filedir -exec stat '{}' \; 2>/dev/null | less
				clear
				echo -e "\nPress any key to try again, otherwise enter E to exit \n"
				read -srn1 filedir
			else
				clear
				echo -e "\nNo such directory , press any key to try again, otherwise enter E to exit \n"
				read -srn1 filedir
			fi
		done
		;;

	################################################################################################
	# 3) Prints CPU threshold and current CPU usage
	################################################################################################

	3)
		maxi=90
		use1=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage ""}')
		echo -e "\nCPU Threshold $maxi % \n"
		echo -e "\nCurrent CPU usage $use1 % \n"
		read
		;;

	################################################################################################
	# 4) Prints disk space threshold and current disk space usage
	################################################################################################

	4)
		maxi=90
		use1=$(df -h --output=pcent | grep -v Use | cut -d'%' -f 1 | paste -sd+ | bc)
		echo -e "\n Disk space threshold $maxi \n"
		echo -e "\n Disk space in use $use1 \n"
		read
		;;

	##############################################################################################
	# 5) Show hardware information
	##############################################################################################

	5)
		clear
		sudo lshw | less
		read
		;;

	############################################################################################
	# 6) Check if a number is odd or even
	############################################################################################

	6)
		clear
		echo -e "Enter a number please"
		read num1
		while [[ "$num1" =~ ^[0-9]+$ ]]; do
			if [[ $num1 == 0 ]]; then
				echo -e "Zero"
				read
			elif [[ $((num1 % 2)) == 0 ]]; then
				echo -e "Even number"
				read
			else
				echo -e "Odd number"
				read
			fi
			clear
			echo -e "Enter a number to try again, otherwise, press any other key to exit, thanks"
			read num1
			clear
		done
		;;

		################################################################################################
		# 7) Check if a number is an Armstrong number
		################################################################################################

	7)

		stop1=y
		while [[ "$stop1" == "y" ]]; do
			clear
			awk '{print $0}' <<<"Enter a number to check whether it is an Armstrong number"
			read num1
			sum1=0
			if [[ "$num1" =~ ^[0-9]+$ ]]; then
				for i in $(seq 0 $((${#num1} - 1))); do
					sum1=$((sum1 + $((${num1:i:1} ** ${#num1}))))
				done
				if ((num1 == sum1)); then
					echo -e "Armstrong number"
					read
				else
					echo -e "Not an Armstrong number"
					read
				fi
			else
				echo -e "Wrong input, sorry thanks"
				read
			fi
			clear
			echo -e "To try again, press 'y', otherwise, press any key to exit"
			read -rn1 stop1
		done
		;;

		################################################################################################
		# 8) List of all Armstrong numbers
		################################################################################################

	8)

		clear
		echo -e "Hit Ctrl+C at any time to stop\n"
		for ((s1 = 1; s1 < 115132219018763992565095597973971522401; s1++)); do
			sum1=0
			for ((i = 0; i < ${#s1}; i++)); do
				i1=$(($i + 1))
				sum1=$(($sum1 + $(($(echo $s1 | cut -c $i1) ** ${#s1}))))
			done
			if [ $sum1 -eq $s1 ]; then
				echo -e "$s1"
			fi
		done
		;;

		#################################################################################################
		# 9) Check a prime nubmer by input
		################################################################################################

	9)
		clear
		stop1=0
		while [ $stop1 == "0" ]; do
			echo -e "Please enter a number to check if it is an Prime number, press any key to exit otherwise \n"
			read -r num1
			if [ -n "$num1" ] && [ "$num1" -eq "$num1" ] 2>/dev/null; then
				if (($num1 != "1" && $num1 <= "99" && $num1 != "0")); then
					prime1="0"
					for ((i = 1; i < 100; i++)); do
						if (($num1 % $i == 0)); then
							prime1=$(($prime1 + 1))
						fi
					done
					if [ $prime1 != "2" ]; then
						echo -e "No, not a prime number, sorry"
					else
						echo -e "Yes, this one is a prime number"
					fi
				else
					echo -e "Prime numbers exist only in the range of 2-99, thanks"
				fi
			else
				stop1="1"
				read
			fi
		done
		;;

		#################################################################################################
		# 10) Check a prime nubmer by input
		################################################################################################

	10)
		clear
		for ((num1 = 2; num1 < 100; num1++)); do
			prime1=0
			for ((i = 1; i < 100; i++)); do
				if (($num1 % $i == 0)); then
					prime1=$(($prime1 + 1))
				fi
			done
			if [ $prime1 != "2" ]; then
				:
			else
				echo -e "$num1"
			fi
		done
		read
		;;

		#################################################################################################
		# 11) Check if a number is of Fibonacci sequence
		################################################################################################

	11)
		clear
		continue1="y"
		while [ $continue1 == "y" ]; do
			echo -e "Please enter a number to check if it is of Fibonacci sequence"
			read -r num1
			if [[ "$num1" =~ ^[0-9]+$ ]]; then
				fibsequence="0 1"
				i=3
				while (($(cut -d' ' -f "$((i - 1))" <<<"$fibsequence") < num1)); do
					i2=$((i - 2))
					i1=$((i - 1))
					fibadd1=$(($(awk -F " " -v var1=$i1 '{print var1}' <<<"$fibsequence") + $(cut -d' ' -f $i2 <<<"$fibsequence")))
					fibsequence+=" $fibadd1"
					i=$((i + 1))
				done
				echo -e "Fibonacci sequence - $fibsequence"
				if [[ $(grep $num1 <<<"$fibsequence") ]]; then
					echo -e "$num1 is in Fibonacci sequence"
				else
					echo "NO"
				fi
				read
				clear
				echo -e "Try again? press y for yes, otherwise press any key to exit, thanks"
				read continue1
				clear
			else
				echo -e "Digits only please"
				read
				clear
			fi
		done
		;;

		#################################################################################################
		# 12) Convert decimal value to binary
		################################################################################################

	12)
		continue1="y"
		while [ "$continue1" == "y" ]; do
			clear
			echo -e "Enter a number to see its binary value"
			read -r number1
			bin1=""
			if [[ "$number1" =~ ^[0-9]+$ ]]; then
				while [ $number1 -gt 0 ]; do
					bin1+=$(($number1 % 2))
					number1=$((number1 / 2))
				done
				while [ $((${#bin1} % 4)) -ne 0 ]; do
					bin1+=0
				done
				bin2=""
				lastdigit=${#bin1}
				while [ ${#bin2} -lt ${#bin1} ]; do
					bin2+=${bin1:$lastdigit:1}
					lastdigit=$(($lastdigit - 1))
				done
				echo $bin2
				read
			else
				echo -e "Digits only here please"
			fi
			echo -e "Try again? press y for yes, otherwise press any other key to exit"
			read -rn1 continue1
		done
		if [[ "$continue1" == "y" ]]; then
			:
		fi
		;;

		##############################################################################################
		# 13)Find location of a given IP Address
		##############################################################################################

	13)
		check_ip_address() {
			clear
			flag1=0
			errmsg1="Invalid input"
			echo -e "Please enter an ip address"
			read -r ipaddress1
			if ! [[ $ipaddress1 =~ ^[0-9.]+$ ]]; then
				echo $errmsg1
				read
				flag1=1
			elif [[ $(awk -F\. '{print NF-1}' <<<"$ipaddress1") -ne 3 ]]; then
				echo $errmsg1
				read
				flag1=1
			else
				for ((i = 1; i < 5; i++)); do
					ss=$(awk -F "." -v i1=$i '{print $i1}' <<<"$ipaddress1")
					if [[ $ss -gt 255 ]] || [[ $ss -lt 0 ]]; then
						echo $errmsg1
						read
						flag1=1
					fi
				done
			fi
			if [[ $flag1 == 0 ]]; then
				curl https://ipinfo.io/$ipaddress1
				read
			fi
		}
		while true; do
			clear
			echo -e "IP address' location checker. Press y to continue, otherwise press any key to exit"
			read -rn1 exit1
			if [[ "$exit1" == y ]]; then
				check_ip_address
			else
				break
			fi
		done
		;;

	14)
		stop="0"
		while [ $stop = "0" ]; do
			echo "Please type the name of the file you wish to rename, and press enter, to cancel, type EXIT"
			ls -Flsh
			read -r file1
			if [[ $file1 == "EXIT" ]]; then
				stop="1"
			elif [[ -f $file1 ]]; then
				echo "Rename to ?"
				read -r name1
				if [[ -f $name1 ]]; then
					echo "File with this name already exists, Please choose another name"
				else
					mv $file1 $name1
					stop="1"
				fi
			else
				echo "Sorry, file not found, please try again"
				read
			fi
		done
		;;

	15)
		echo "enter the name for the file you wish to exterminate, to cancel, type EXIT"
		ls -Flsh
		read -r del1
		if [ $del1 != "EXIT" ]; then
			echo "About to remove $del1, are you sure? press y to confirm"
			read -r confirm
			if [ $confirm = "y" ]; then
				rm -r $del1
				echo "File removed"
				read
			else
				echo "File was not exterminated"
				read
			fi
		fi
		;;

	16)
		echo "enter a name for the newly created file, to cancel, type EXIT"
		read -r newfile1
		if [ $newfile1 != "EXIT" ]; then
			if ! [[ -f $newfile1 ]]; then
				touch $newfile1
			else
				echo "File with this name already exists"
				read
			fi
		fi
		ls -Flsh
		read
		;;

	17)
		echo "Choose a folder to archive, to cancel, type EXIT"
		ls -Flsh
		echo "Please choose a name for the new Archive you would like to create"
		read -r archive1
		if [ $archive1 != "EXIT" ]; then
			echo "Please choose the folder you wish to archive"
			read -r folder1
			tar czf "$archive1".tar $folder1
			read
		fi
		;;

	18)
		echo "Choose a file to copy, to cancel, type EXIT"
		ls -Flsh
		read -r copy1
		if [ $copy1 != "EXIT" ]; then
			copy1=$pwd/$copy1
			stop="0"
			dest1='/'
			while [ "$stop" == "0" ]; do
				printf "\n"
				echo "$dest1"
				printf "\n"
				if [[ "$dest1" != "/" ]]; then
					cd $pwd/$dest1
				else
					cd $dest1
				fi
				ls -Flsh
				printf "\n"
				echo "Where to ? enter 'here' if here is fine. To go back, press X"
				read -r dest1
				printf "\n"
				if [[ "$dest1" == "here" ]]; then
					stop="1"
					cp ~/$copy1 $pwd/$copy1
				elif [[ "$dest1" == "X" ]]; then
					cd ..
					dest1=$pwd
				else
					cd $pwd/$dest1
				fi
			done
		fi
		cd ~/
		;;

	19)
		trap SIGINT
		htop
		;;

	20)
		clear
		echo -e "Currently open files -"
		lista=$(lsof -w | tr -s ' ' | cut -d' ' -f 1 | sort -u | sed '/COMMAND/d')
		echo $lista | wc -w
		echo "Maximum open files -"
		sudo prlimit --noheadings -n -o SOFT
		read
		;;

	21)
		ss -tulpn
		sudo lsof -itcp -stcp:LISTEN
		read
		;;

	22)
		validate_id() {
			clear
			echo -e "Enter ID - "
			read tz
			sum1=0
			if ! [[ "$tz" =~ ^[0-9]+$ ]]; then
				echo -e "Only digits allowed, thanks"
			elif [[ ${#tz} -gt 9 ]]; then
				echo -e "Maximum of 9 digits allowed, thanks"
			else
				count=$((9 - ${#tz} - 1))
				for i in $(seq 0 $count); do
					tz=$(echo $tz | sed '1s/^/0/')
				done
				for i in $(seq 1 ${#tz}); do
					c1=${tz:$(($i - 1)):1}
					if [[ $(($i % 2)) -eq 0 ]]; then
						if [[ $(($c1 * 2)) -gt 9 ]]; then
							sum1=$(($sum1 + $(($c1 * 2)) / 10))
							sum1=$(($sum1 + $(($c1 * 2)) % 10))
						else
							sum1=$(($sum1 + $c1 * 2))
						fi
					else
						sum1=$(($sum1 + $c1))
					fi
				done
				sum1=$(($sum1 % 10))
				if [[ $sum1 -eq 0 ]]; then
					echo -e "ID is valid"
				else
					echo -e "Invalid ID"
				fi
			fi
			read
		}
		while true; do
			clear
			echo -e "Israeli ID validation, enter y to proceed, any other key to exit"
			read -rn1 choice1
			if [[ "$choice1" == y ]]; then
				validate_id
			else
				break &>/dev/null
			fi
		done
		clear
		;;

		################################################################################################
		# 99) Exit
		################################################################################################

	99)
		clear
		exit
		;;

	esac
	clear
done
