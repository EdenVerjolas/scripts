#!/bin/bash

# Display menu
show_menu() {
	clear
	last_line1=$(($(tput lines) - 1))
	tput cup "$last_line1" 0
	echo "(ENTER)Open (B)Back (T)Top (L)Last (C)Copy (P)Paste (M)Move (D)Delete (H)Home (F)Find (X)Exit"
	tput cup 0 0
	if [[ "$(ls -Fla | wc -l)" -lt $(($(tput lines) - 5)) ]]; then
		for i in $(seq 0 "${#file_list[@]}"); do
			if [[ $i -eq $current_index ]]; then
				echo -e "\e[1;32m> ${file_list[$i]}\e[0m" # Highlight selected item
			else
				echo "  ${file_list[$i]}"
			fi
		done
	else
		for i in $(seq "$current_index" "$(("$current_index" + $(tput lines) - 5))"); do
			if [[ $i -eq $current_index ]]; then
				echo -e "\e[1;32m> ${file_list[$i]}\e[0m" # Highlight selected item
			else
				echo "  ${file_list[$i]}"
			fi
		done
	fi
}

up_dir1="$(
	cd ..
	pwd
)"

current_index=0

# Disable echo and enable raw input
stty -echo -icanon time 0 min 0

# Handle navigation
while true; do
	mapfile -t file_list < <(
		ls -Fla | awk -v var1="$(pwd)" -v var2="$up_dir1" '{ if(NR==2){print $9,"<Current Directory>",var1}; if(NR==3){print $9,"<Up>",var2} ; if(NR>3){print $0} }'
	)
	max_index=$((${#file_list[@]} - 1))
	show_menu
	read -rsn1 key # Read a single keypress
	case "$key" in
	$'\x1b')        # Handle arrow keys (escape sequences)
		read -rsn2 key # Read the next 2 characters
		case "$key" in
		'[A') # Up arrow
			((current_index--))
			if [[ $current_index -lt 0 ]]; then
				current_index=$max_index
			fi
			;;
		'[B') # Down arrow
			((current_index++))
			if [[ $current_index -gt $max_index ]]; then
				current_index=0
			fi
			;;
		esac
		;;
	"") # Enter key (detected as empty string)
		if [[ "${file_list[$current_index]}" =~ "./ " ]] || [[ "${file_list[$current_index]}" =~ "../" ]]; then
			dir_to_open1="$(awk '{print $1}' <<<${file_list[$current_index]})"
		else
			dir_to_open1="$(awk '{print $9}' <<<${file_list[$current_index]})"
		fi
		if [[ -d "$dir_to_open1" ]]; then
			cd "$dir_to_open1"
		fi
		current_index=0
		;;
	"c") # When "c" is pressed
		message_line1=$(($(tput lines) - 3))
		tput cup "$message_line1" 0
		if [[ "$(pwd)" != "/" ]]; then
			file_to_copy1="$(pwd)/$(awk '{print $9}' <<<${file_list[$current_index]})"
		else
			file_to_copy1="$(pwd)$(awk '{print $9}' <<<${file_list[$current_index]})"
		fi
		echo -e "$file_to_copy1 Copied"
		read -rsn1
		tput cup 0 0
		;;
	"p")
		tput cup $(($(tput lines) - 4))
		if [[ "$file_to_copy1" ]]; then
			if [[ -f $(awk -F "/" '{print $NF}' <<<$file_to_copy1) ]] || [[ -d $(awk -F "/" '{print $NF}' <<<$file_to_copy1) ]]; then
				echo -e "A file or directory named $file_to_copy1 , already exists in $pwd , cannot copy"
			else
				cp "$file_to_copy1" "$(pwd)"
				file_to_copy1=""
				tput cup $(($(tput lines) - 3))
				echo -e "Done"
			fi
		elif [[ "$file_to_move1" ]]; then
			if [[ -f $(awk -F "/" '{print $NF}' <<<$file_to_move1) ]] || [[ -d $(awk -F "/" '{print $NF}' <<<$file_to_move1) ]]; then
				echo -e "A file or directory named $file_to_move1 , already exists in $pwd , cannot move"
			else
				echo -e "$file_to_move1"
				mv "$file_to_move1" "$(pwd)"
				file_to_move1=""
				tput cup $(($(tput lines) - 3))
				echo -e "Done"
			fi
		else
			echo -e "Nothing to paste, sorry"
		fi
		read -rsn1
		;;
	"m")
		file_to_move1="$(awk '{print $9}' <<<${file_list[$current_index]})"
		if [[ "$file_to_move1" != "/.." ]] && [[ "$file_to_move1" != "/." ]]; then
			if [[ "$(pwd)" != "/" ]]; then
				file_to_move1="$(pwd)/$file_to_move1"
			else
				file_to_move1="$(pwd)$file_to_move1"
			fi
			tput cup $(("$(tput lines)" - 3))
		fi
		read -rsn1
		;;
	"d")
		file_to_delete1=$(awk '{print $9}' <<<${file_list[$current_index]})
		tput cup $(($(tput lines) - 9))
		echo -e "About to delete $file_to_delete1\nPress [ENTER] to approve\nPress any other key to cancel"
		read -srn1 choice1
		if ! [[ "$choice1" ]]; then
			if [[ -f "$file_to_delete1" ]]; then
				rm "$file_to_delete1"
				echo -e "Done"
				read -rsn1
			else
				echo -e "$file_to_delete1 is a directory, delete anyway?\n[ENTER] to approve\nAny other key to cancel"
				if ! [[ $(read -rsn1) ]]; then
					rmdir "$file_to_delete1"
				else
					echo -e "Delete canceled"
					read -rsn1
				fi
			fi
		else
			echo -e "Delete canceled"
			read -rsn1
		fi
		;;
	"h")
		if [[ "$USER" != "root" ]]; then
			cd "/home/$USER"
		else
			cd /root/
		fi
		;;
	"x")
		tput cup $(("$(tput lines)" - 5))
		echo -e "About to exit\nConfirm [ENTER]\nCancel [ANY KEY]"
		read -rsn1 choice1
		if ! [[ "$choice1" ]]; then
			clear
			exit
		else
			continue
		fi
		;;
	"f")
		stty sane
		clear
		echo "Find: "
		read -r to_find1
		find / -name $to_find1
		sleep 5
		stty -echo -icanon time 0 min 0
		;;
	"t")
		current_index=0
		;;
	"b")
		cd ..
		;;
	"l")
		current_index="$max_index"
		;;
	esac
done

# Re-enable echo and normal input
stty sane
