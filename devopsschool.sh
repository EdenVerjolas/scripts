#!/bin/bash
#
# Testing of exercises from devopsschool.com
# Running the entire scripts in a while loop so we can comfortably test one exercise after another

while true ; do
 clear
 echo -e "\n 1. Output a specified direcoty's size \n"
 echo -e "\n 2. Output a status of a file/directory \n"
 echo -e "\n 3. Print max CPU and CPU usage \n"
 echo -e "\n 4. print disk usage \n"
 read -rn2 choice1

 ##########################################################################
 # 1) Get a name of a directory and displays its size using 'find' command 
 ##########################################################################
 case $choice1 in
 1)
  clear
  dir1="1"
  while [ $dir1 != "0" ]; do
    if [ $dir1 -eq "0" 2>/dev/null ]; then :
    else
     clear
     echo -e "\n Please enter a directory's name in order to see its size, to exit, press 0 \n"
     read -r dir1
     if [ $dir1 = "0" 2>/dev/null ]; then :
     elif (( $(sudo find / -name $dir1 2>/dev/null | wc -l) > "0" )); then
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
  clear
  filedir="1"
  while [ $filedir != "0" ]; do
   if [ $filedir = "0" 2>/dev/null ]; then :
   fi
   clear
   echo -e "\n Please enter a directory or a file to view its status, to exit, press 0 \n"
   read -r filedir
   if [ $filedir = "0" 2>/dev/null ]; then :
   elif (( $(sudo find / -name $filedir 2>/dev/null | wc -l) > "0" )); then
    sudo find / -name $filedir -exec stat '{}' \; 2>/dev/null | less
    clear
    echo -e "\n Press any key to try again, otherwise enter 0 to exit \n"
    read -srn1 filedir
   else
    clear
    echo -e "\n No such directory , press any key to try again, otherwise enter 0 to exit \n"
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
 esac
 clear
done
