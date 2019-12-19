#!/bin/bash
case $2 in
1)
	cat $1 | cut -d ' ' -f 1 | sort | uniq -c | sort -nr | head -n 1 | cut -d " " -f 7
	;;
2)
	cat $1 | grep "html " | cut -d ' ' -f 7 | sort | uniq -c | sort -nr | head -n 1 | cut -d " " -f 7
	;;
3)
	cat $1 | cut -d ' ' -f 1 | sort | uniq -c | sort -nr
	;;
4)
	cat $1 | awk -F " " '{if (($9 == 404) && ($7 ~ "htm"))  print $7 }' | uniq 
	;;
5)
	cat $1 | cut -d ' ' -f 4 | cut -d ':' -f 2 | sort | uniq -c | sort -nr | head -n 1 | cut -d " " -f 6
	;;
6)	
	cat $1 | grep 'compatible' | grep -i 'bot' | cut -d ' ' -f 1,12-40 | sort | uniq
	;;
esac

