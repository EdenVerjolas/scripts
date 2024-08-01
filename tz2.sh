#!/bin/bash
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
