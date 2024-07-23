#!/bin/bash
clear
dir1="1"
while [ $dir1 != "0" ]; do
if [ $dir1 -eq "0" 2>/dev/null ]; then :
else
 echo -e "\n Please enter a directory's name in order to see its size, to exit, press 0 \n"
 read -r dir1
 if [ $dir1 = "0" 2>/dev/null ]; then :
 elif (( $(sudo find / -name $dir1 2>/dev/null | wc -l) > "0" )); then
  sudo find / -name $dir1 -exec du -sh '{}' \; 2>/dev/null | less -e
  clear
  echo -e "\n Press any key to try again, otherwise enter 0 to exit \n"
  read -rn1 dir1
 else echo -e "\n No such directory , press any key to try again, otherwise enter 0 to exit \n"
 read -n1 dir1
 fi
fi
done
