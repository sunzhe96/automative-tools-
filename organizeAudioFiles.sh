#!/bin/bash

sample=$(ls | grep wav | head -1)
year=$(echo $sample | awk -F "-" {'print $1'})
month=$(echo $sample | awk -F "-" {'print $2'})
day=$(echo $sample | awk -F "-" {'print $3'})

year_month="$year-$month"
date="$year-$month-$day"

function create_date() {
    mkdir -v "$HOME/Audio/$year/$year_month/$date"
}

function create_month_date() {
    mkdir -v "$HOME/Audio/$year/$year_month" && mkdir -v "$HOME/Audio/$year/$year_month/$date"
}

function create_full_path() {
    mkdir -v "$HOME/Audio/$year" && mkdir -v "$HOME/Audio/$year/$year_month/" && mkdir -v "$HOME/Audio/$year/$year_month/$date"
}


if [[ -d "$HOME/Audio/$year" ]]
then
   if [[ -d "$HOME/Audio/$year/$year_month" ]]
   then
       if [[ ! -d "$HOME/Audio/$year/$year_month/$date" ]]
       then
	   create_date
       fi
   else
       create_month_date
   fi
else
    create_full_path
fi

mv -v ~/Audio/*.wav "$HOME/Audio/$year/$year_month/$date/"
echo "Finished"
