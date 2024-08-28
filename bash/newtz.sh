#!/bin/bash
clear
printf "\n \n"
echo "Please enter a number below in order to vaildate a legitimate Israeli National Identification Number"
printf "\n \n"
tz=()
one_two=()
kefel=()
for ((i=1;i<=9;i++)) do
  read -rn1 ADD
  tz+=($ADD)
  if [ $((i%2)) -eq 0 ]; then
   one_two+=(2);
  else one_two+=(1);
 fi
done
printf "\n"
if [ ${#tz[@]} -lt 9 ]; then
  argi=9-${#tz[@]}
 while ((argi>0)); do
  tz=("0" "${tz[@]}")
  argi=$argi-1
 done
fi
for i in "${!tz[@]}"; do
 if [ ${tz[$i]} -ge 0 ] 2> /dev/null; then
  :
 else
  echo "${tz[$i]}-----Digits only please thank you."
 exit;
 fi
done
for i in "${!tz[@]}"; do
 kefel[$i]+=$((${tz[$i]}*${one_two[$i]}));
done
for i in "${!kefel[@]}"; do
 if [ $((${kefel[$i]})) -eq 10 ]; then
 kefel[$i]=1
 elif [ $((${kefel[$i]})) -eq 12 ]; then
 kefel[$i]=3
 elif [ $((${kefel[$i]})) -eq 14 ]; then
 kefel[$i]=5
 elif [ $((${kefel[$i]})) -eq 16 ]; then
 kefel[$i]=7
 elif [ $((${kefel[$i]})) -eq 18 ]; then
 kefel[$i]=9
 fi
done
sum=$(IFS=+; echo "$((${kefel[*]}))")
printf "\n \n"
if [ $(($sum%10)) != 0 ]; then echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! The entered number is NOT a legitimate Israeli National Identification Number !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
 else echo "The entered number is a legitimate Israeli National Identification Number, congratulations champion"
 printf "\n"
fi
