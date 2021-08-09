#!/bin/bash

head="https://s.weibo.com/"
resou="https://s.weibo.com/top/summary?cate=realtimehot"

html=$(curl "$resou")

topics=$(echo "$html" | grep "href=\"/weibo" | awk -F ">" '{ print NR " " $2 }' | sed 's/<*\/a//')
links=$(echo "$html" | grep "href=\"/weibo" | awk -F " " '{ print $2 }' | awk -v head="$head" -F "\"" '{ print head $2 }')

echo "$topics"

while :
do
    read -p "Enter topic number [any letter to quit]: " answer
    if [[ "$answer" =~ ^[1-9]$|^[1-4][0-9]$|^5[0-1]$ ]]
    then
	topic_chose=$(echo "$links" | head -n "$answer" | tail -n 1 )
	vivaldi-stable "$topic_chose"    
    else
	 exit 0
    fi
done

exit 0
