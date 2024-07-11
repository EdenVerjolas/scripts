#!/bin/bash
trap '' SIGINT
while true ; do
clear
cols=$(tput cols)
for ((i=0; i<cols; i++));do printf "@"; done; echo
echo "Hello and Welcome to "THE FILER""
echo "Please carefuly select a function to execute from the options below -"
echo "1. Rename a file"
echo "2. Remove a file"
echo "3. Create a file"
echo "4. Create an archive of a folder"
echo "5. Make a copy of a file"
echo "6. Show CPU usage"
echo "7. Print how many open files / maximum open files"
echo "8. Print open ports"
echo "10. Exit"
read -rn2 choice
case $choice in
1)
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
  fi
  else echo "Sorry, file not found, please try again"
  read
 fi
done
;;
2)
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
 else echo "File was not exterminated"
 read
 fi
fi
;;
3)
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
;;
4)
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
5)
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
  if [[ "$dest1" != "/" ]]; then cd $pwd/$dest1
  else cd $dest1
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
6)
trap SIGINT
htop
;;
7)
echo "Currently open files -"
lista=$(lsof -w  | tr -s ' ' | cut -d' ' -f 1 | sort -u | sed '/COMMAND/d' )
echo $lista | wc -w
echo "Maximum open files -"
sudo prlimit --noheadings -n -o SOFT
read
;;
8)
netstat -tulpn
sudo lsof -itcp -stcp:LISTEN
read
;;
10)
exit
;;
esac
done
