#!/usr/bin/env bash

#Script Variables
offsetfile="/tmp/$1.offset"
current_last_line=$(wc -l $1 |cut -f1 -d' ')
temp_file=/tmp/$1.tmp

#Verifying if the OFFSET file exist
if [ -e $offsetfile ]
then
    #If the OFFSET exist, check if it bigger than the current log I'm monitoring
    previous_last_line=$(cat $offsetfile)
    if [ ${previous_last_line} -gt $current_last_line ]
    then
        #If previsous_last_line bigger than current_last_line (possible due a rotation),
        #reset it to read the whole log file
        echo 1 > $offsetfile
    fi
else
    #Case the OFFSET doesnt exist (Ex.: first execution), I'll create it to read the file from now.
    wc -l $1 |cut -f1 -d' ' > $offsetfile
    previous_last_line=$(cat $offsetfile)
    exit 0
fi


sed -n ${previous_last_line},${current_last_line}p $1 |awk '$0 !~ /healthcheck.html/ {print $10}'|sort|uniq -c  > $temp_file
while IFS='' read -r line || [[ -n "$line" ]]; do
    number=$(echo $line|cut -d' ' -f1)
    status_code=$(echo $line|cut -d' ' -f2)
    echo "STATUS CODE=${status_code}" 
done < $temp_file

#Setting the new value of the OFFSET
expr $current_last_line + 1 > $offsetfile
