#!/bin/bash
###############################################################################################################################################
# Bash exercises taken from www.devopsschool.com, plus some other cool exercises
###############################################################################################################################################


###############################################################################################################################################
# Running an infinite loop to comfortably navigate between programs
###############################################################################################################################################
while true ; do
 clear

###############################################################################################################################################
# Function to read a string and find out if directory with such name exists, if it does, print its size and location
###############################################################################################################################################

get-directory-size(){
  clear
  dir1="1"
  while [[ "$dir1" != "0" ]]; do
    if [[ "$dir1" == "0" ]]; then break
    else
      clear
     echo -e "Please enter a directory's name in order to see its size, to exit, press 0"
     read dir1
     if [ $dir1 = "0" 2>/dev/null ]; then :
     elif (( $(sudo find / -name $dir1 2>/dev/null | wc -l) > "0" )); then
     sudo find / -type d -name $dir1 -exec du -sh '{}' \; 2>/dev/null | less -e
     clear
     echo -e "Press any key to try again, otherwise enter 0 to exit"
     read -n1 dir1
     else
       clear
       echo -e "No such directory , press any key to try again, otherwise enter 0 to exit"
      read -n1 dir1
    fi
   fi
  done
}

##########################################################################################
# Gets a directory name and displays its status regarding executability, file type
##########################################################################################

get-directory-status(){
   get-dir(){
   clear
   if [ $filedir = "E" ]; then
    echo $filedir read exit
   fi
   echo -e "Please enter a directory or a file to view its status"
   read filedir
   if (( $(sudo find / -name $filedir | wc -l) > "0" )); then
     clear
    sudo find / -name $filedir -exec stat '{}' \; | less
   else
     clear
    echo -e "Sorry, no such directory"
   fi
  }
  while true; do
      clear
      echo -e "Print directory status, enter y to proceed, any other key to exit"
      read -n1 choice1
      if [[ "$choice1" == y ]]; then
        get-dir
      else
        break
      fi
    done
    clear
}

 ################################################################################################
 # Prints CPU threshold and current CPU usage
 ################################################################################################

  get-cpu-threshold(){
   clear
   maxi=90
   use1=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage ""}')
   echo -e "CPU Threshold $maxi %"
   echo -e "Current CPU usage $use1 %"
   read
}

 ################################################################################################
 # Prints disk space threshold and current disk space usage
 ################################################################################################

get-disk-space(){
  clear
  maxi=90
  use1=$(df -h | awk '{n=1} {if(NR==1){n=0} if(n){print $3" "$5} }' | sort -u | awk 'BEGIN{c=0} {c=c+$2} END{print c}')
  echo -e "Disk space threshold %$maxi"
  echo -e "Disk space in use %$use1"
  read
  }

##############################################################################################
# Show hardware information
##############################################################################################

get-hw-info(){
  clear
  sudo lshw | less
  read
  }

  ############################################################################################
  # Check if a number is odd or even
  ############################################################################################

even-odd-number(){
num1="0"
   while [ $num1 != "X" ]; do
   clear
   echo -e "Please enter a number to check if its odd or even, thanks. To exit, enter X and press ENTER key"
   read -r num1
   if [[ "$num1" =~ ^[0-9]+$ ]]; then
    if (( (( $num1 / 1 )) != $num1 )); then
         echo -e "Only numbers allowed, thanks"
         read
    elif (( $num1 == "0" )); then
        echo -e "Zero is an even number, thanks."
        read
    elif (( (( $num1 % "2" )) == "0" )); then
        echo -e "The entered number is even, thanks."
        read
    elif (( (( $num1 % "2" != "0" )) )); then
        echo -e "The entered number is odd, thanks."
        read
    fi
   fi
   done
   }

   ################################################################################################
# Check if a number is an Armstrong number
################################################################################################

armstrong-number(){
clear
   stop1=0
   while [ "$stop1" == "0" ]; do
     sum1=0
     echo -e "Please enter a number to check if it is an Armstrong number, press any key to exit otherwise"
     read -r num1
     if [[ "$num1" =~ ^[0-9]+$ ]]; then
      for (( i=0; i<${#num1}; i++ ));
       do
         i1=$(($i+1))
         sum1=$(( $sum1+$(($(echo $num1 | cut -c $i1)**${#num1} )) ))
       done
      if (( $sum1 == $num1 )); then
       echo -e "This number is indeed an Armstrong number, goodbye now"
       read
       clear
      else
       echo -e "Given number is unfortunately not an Armstrong number, goodbye now"
       read
       clear
      fi
      else
       stop1="1"
      read
     fi
    done
    }

################################################################################################
# Prints a list of all Armstrong numbers
################################################################################################

list-all-armstrong-numbers(){
clear
  echo -e "To stop at any time, press CTRL+C"
  read
  for (( s1=0; s1<4679307774; s1++ ));
   do
    sum1=0
    for (( i=0; i<${#s1}; i++ ));
     do
      i1=$(($i+1))
      sum1=$(( $sum1+$(($(echo $s1 | cut -c $i1)**${#s1} )) ))
     done
    if [ $sum1 -eq $s1 ]; then
     echo -e "$s1"
    fi
   done
   }

   #################################################################################################
# Check a prime nubmer by input
################################################################################################

check-prime-number(){
   stop1=0
   while [ $stop1 == "0" ]; do
     clear
     echo -e "Please enter a number to check if it is an Prime number, press any key to exit otherwise"
     read -r num1
     if [[ "$num1" =~ ^[0-9]+$ ]]; then
       if [[ "$num1" -ne "1" && "$num1" -le "99" && "$num1" -ne "0" ]]; then
         prime1="0"
         for (( i=1; i<100; i++ ));
          do
            if (( "$num1" % "$i" == "0" )); then
              prime1=$(($prime1+1))
            fi
          done
         if [[ "$prime1" != "2" ]]; then
          echo -e "No, not a prime number, sorry"
         else
          echo -e "Yes, this one is a prime number"
         fi
       else
        echo -e "Prime numbers exist only in the range of 2-99, thanks"
       fi
     else
       stop1="1"
     fi
     read
    done
    }

#################################################################################################
# Check if a number is of Fibonacci sequence
################################################################################################

fibonacci-check(){
clear
   stop1=0
   arr1=(0 1)
   while [ $stop1 == "0" ]; do
     flag1=0
     clear
     echo -e "Please enter a number to check if it is of Fibonacci sequence, press any key to exit otherwise"
     read -r num1
        if [[ "$num1" =~ ^[0-9]+$ ]]; then
            s=2
            while (( $((arr1[$(($s-1))]+arr1[$(($s-2))])) <= $num1 )); do
                arr1[$s]=$((arr1[$(($s-1))]+arr1[$(($s-2))]))
                s=$(($s+1))
            done
            echo -e "Fibonacci sequence - ${arr1[@]}"
            for (( i=0; i<${#arr1[@]}; i++ )); do
               if (( ${arr1[$i]} == $num1 )); then
                 echo -e "This number is within Fibonacci sequence"
                 flag1=1
                 i=${#arr1[@]}
               fi
            done
        else
          stop1="1"
          flag1="1"
        fi
        if (( $flag1 == 0 )); then
          echo -e "No, this number is not within Fibonacci sequence"
        fi
        read
   done
}

#################################################################################################
# Convert decimal value to binary
################################################################################################

decimal-to-bin(){
  flag1=1;
  while [ $flag1 -eq 1 ]; do 
    clear
    awk '//' <<<"Enter a number to see its binary value"
    read -r number1
    if [[ "$number1" =~ ^[0-9]+$ ]]; then
      awk '{i=0;num1=$0;while(num1>0){bin1[i]=num1%2;num1=int(num1/2);i++};while( (i)%4 != 0 ){bin1[i]=0;i++}} END{for(i1=i;i1>=0;i1--){printf "%s",bin1[i1]} print""}' <<<$number1
      read
      clear
    else
      echo -e "Only numbers, thanks."
    fi
    awk '//' <<<"Try again? y/n"
    read -n1 choice1
    if [[ $choice1 == "n"  ]]; then
      flag1=0 
    fi
  done
}

##############################################################################################
  # Find geographical location of a given IP Address
##############################################################################################

find-ip-location(){
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


##############################################################################################
  # Rename a file
##############################################################################################

file-renamer(){
  clear
  stop="0"
    while [ $stop = "0" ]; do
      echo "Please type the name of the file you wish to rename, and press enter, to cancel, type EXIT"
      ls -Flsh
      read -r file1
      if [[ $file1 == "EXIT" ]] ; then stop="1"
      elif [[ -f $file1 ]] ; then
        echo "Rename to ?"
        read -r name1
        if [[ -f $name1 ]] ; then
          echo "File with this name already exists, Please choose another name"
        else
          mv $file1 $name1
          stop="1"
          ls -Flsh
          read
        fi
      else echo "Sorry, file not found, please try again"
        read
      fi
    done
}

##############################################################################################
  # Exterminate a file
##############################################################################################

file-extermination(){
  clear
  echo "enter the name for the file you wish to exterminate, to cancel, type EXIT"
    ls -Flsh
    read -r del1
    if [ $del1 != "EXIT" ]; then
      echo "About to remove $del1, are you sure? press y to confirm"
      read -r confirm
      if [ $confirm = "y" ]; then
        rm -r $del1
        echo "File removed"
        ls -Flsh
        read
      else echo "File was not exterminated"
        read
      fi
    fi
}

##############################################################################################
  # Create a new file
##############################################################################################

file-creator(){
  clear
  echo "enter a name for the newly created file, to cancel, type EXIT"
    read -r newfile1
    if [ $newfile1 != "EXIT" ]; then
      if ! [[ -f $newfile1 ]] ; then
        touch $newfile1
      else echo "File with this name already exists"
        read
      fi
    fi
    ls -Flsh
    read
}

##############################################################################################
  # Archive a directory
##############################################################################################

directory-archiver(){
  clear
  echo -e "Choose a folder or a file to archive, to cancel, type EXIT\n"
  ls -Flash | awk '{if(NR!=1){print $0}}' 
  read -r folder1
  echo "Please choose a name for the new Archive you would like to create"
  read -r archive1
  if [[ "$archive1" != "EXIT" ]]; then
    tar cfJ "$archive1".tar $folder1
    echo -e "Archive created successfuly !\n"
    ls -Flash | awk '{if(NR!=1){print $0}}'
    read
  fi
}

##############################################################################################
  # Copy a file
##############################################################################################
file-copier(){
copy-function1(){
  clear
  echo -e "Welcome to the file copier. Please enter a file name you wish to copy"
  read -r tocopy1
  findresults1=$(sudo find / -name "*$tocopy1*" 2>/dev/null)
  if [[ "$findresults1" ]]; then
    resultslocation1=$(pwd)
    clear
    echo -e "Which one ? Please enter the number of the file"
    awk '{print NR," ",$0}' <<<$findresults1
    read -r filenumber1
    echo -e "\n"
    stop1="/"
    while [ "$stop1" != "0" ]; do
      clear
      echo -e "Where would you like the file ---$(awk -v row1=$filenumber1 '{if(NR==row1){print $0}}' <<<$findresults1)--- to be placed at? If here ---"$(pwd)"--- is fine, enter 0, to go back, enter .. , to cancel, enter !\n"
      ls $stop1 -Flash | awk '{if(NR!=1){print $0}}'
      read -r stop2
      if [[ "$stop2" == "!" ]]; then
        break
      fi
      if [[ -d "$(pwd)/$stop2" ]]; then
        stop1+="/$stop2"
      else
        echo -e "\nNo such directory exists, try again"
        read
        clear
      fi
      if [[ "$stop2" != "0" ]]; then
        cd $stop1
      else
        if [[ -f "$(pwd)/$tocopy1" ]]; then
          echo -e "File already exists, cannot copy ---$tocopy1--- to ---$(pwd)---, sorry"
        else
          cp $(awk -v row1=$filenumber1 '{if(NR==row1){print $0}}' <<<$findresults1) $(pwd)
          echo -e "Successfuly copied"
          ls -Flsh
          fi
        break
      fi
    done
    read
  else
    echo -e "No such file was found, sorry"
  fi
}
choice1="y"
while [ "$choice1" != "n" ]; do
  copy-function1
  clear
  echo -e "Try again? y/n"
  read -n1 choice1
 done
}

##############################################################################################
  # Print open files against open file limit
##############################################################################################

open-files(){
  clear
  echo -e "Currently open files - $(lsof -w  | tr -s ' ' | cut -d' ' -f 1 | sort -u | sed '/COMMAND/d' | wc -l )"
  echo "Maximum open files - $(sudo prlimit --noheadings -n -o SOFT)"
  read
}

##############################################################################################
  # Print open ports
##############################################################################################

print-open-ports(){
  clear
  netstat -tulpn | less
  sudo lsof -itcp -stcp:LISTEN | less
  read
}

##############################################################################################
  # Validate an israeli id number
##############################################################################################

id-validator(){
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
}

###############################################################################################
  # Show a letter in its NATO phonetic alphabet
##############################################################################################

letter-to-phonetic(){
  clear
  input1=""
  echo -e "Enter a letter or multiple letters to see its NATO phonetic alphabet translation, when finished, enter !"
  while true ; do
    read -rn1 letter1
    if [[ "$letter1" != "!" ]]; then
        input1+=$letter1
    else
      break
    fi
  done
  input1=$(echo $input1 | tr [a-z] [A-Z])
  alphabet1="Alfa Bravo Charlie Delta Echo Foxtrot Golf Hotel India Juliett Kilo Lima Mike November Oscar Papa Quebec Romeo Sierra Tango Uniform Victor Whiskey X-ray Yankee Zulu"
  echo -e "\n"
  for i in $(seq 0 $((${#input1}-1))); do
    if [[ "${input1:$i:1}" =~ ^[A-Z]+$ ]]; then
      awk '{for(i=1;i<=NF;i++){if(match($i,/'"${input1:$i:1}"'/)){print $i}}}' <<<$alphabet1
    elif [[ "${input1:$i:1}" =~ ^[0-9]+$ ]]; then
      echo -e "${input1:$i:1}"
    fi
  done
  echo -e "\nDone, press a key to exit"
  read -rn1
}
################################################################################################################################################
# Main menu 
################################################################################################################################################

 echo -e "1. Output a specified direcoty's size"
 echo -e "2. Output a status of a file/directory"
 echo -e "3. Print max CPU and CPU usage"
 echo -e "4. Print disk usage"
 echo -e "5. Show hardware information"
 echo -e "6. Check if a number is odd or even"
 echo -e "7. Check if a number is an Armstrong number"
 echo -e "8. List of Armstrong numbers"
 echo -e "9. Check if a number is a Prime number"
 echo -e "10. Check if a number is a Fibonacci number"
 echo -e "11. Convert decimal value to binary"
 echo -e "12. Find location of a given IP Address"
 echo -e "13. Rename a file"
 echo -e "14. Remove a file"
 echo -e "15. Create a file"
 echo -e "16. Create an archive of a file"
 echo -e "17. Make a copy of a file"
 echo -e "18. Show CPU usage"
 echo -e "19. Print how many open files / maximum open files"
 echo -e "20. Print open ports"
 echo -e "21. Identify a valid Israeli ID Number"
 echo -e "22. Convert a letter to its NATO Phonetic equivalent"
 echo -e "99. Exit"
 read -rn2 choice1

 case $choice1 in
 1)
  get-directory-size
 ;;

 2)
  get-directory-status
 ;;

 3)
  get-cpu-threshold
 ;;

 4)
  get-disk-space
 ;;

 5)
  get-hw-info
  ;;

  6)
   even-odd-number
   ;;

  7)
   armstrong-number
  ;;

 8)
  list-all-armstrong-numbers
 ;;

  9)
check-prime-number
  ;;

  10)
   fibonacci-check
  ;;

  11)
   decimal-to-bin
  ;;

  12)
   find-ip-location
  ;;

  13)
   file-renamer
  ;;

  14)
    file-extermination
  ;;

  15)
    file-creator
  ;;

  16)
    directory-archiver
  ;;

  17)
   file-copier
  ;;

  18)
    trap SIGINT
    htop
  ;;

  19)
        open-files
  ;;

  20)
print-open-ports
  ;;

  21)
    id-validator
  ;;
22)
  letter-to-phonetic
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

    read
}
