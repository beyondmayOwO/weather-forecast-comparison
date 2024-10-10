#! /bin/bash

log_file="rx_poc.log"

# Extract the records without the header then loop it to extract required infos for weather accuracy report of all days
tail +2 $log_file | while read -r record; do
  year=$(echo $record | cut -d " " -f1)
  month=$(echo $record | cut -d " " -f2)
  day=$(echo $record | cut -d " " -f3)
  echo "Year: $year, month: $month, and day: $day"
  #echo $record
done