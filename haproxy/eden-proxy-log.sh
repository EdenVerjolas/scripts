#!/bin/bash
clear
length0=$(awk 'END{print NR}' /var/log/haproxy.log)
while true; do
	length1=$(awk 'END{print NR}' /var/log/haproxy.log)
	if [[ length1 -gt length0 ]]; then
		length0=$length1
		echo -e "Current HAPROXY redirection - "
		awk '//' /var/log/haproxy.log | awk -F "/" 'c=0;/frontend/{for(i=1;i<=NF;i++){if($i ~ /server[0-9]/){gsub(0,"",$i);array[c]=$i;c++}}} END{print array[c-1]}'
	fi
done
