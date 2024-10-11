#! /bin/bash

log_file="rx_poc.log"

# Initialize the previous record
prev_record=""

# Extract the records without the header then loop it to extract required infos for weather accuracy report of all days
tail +2 $log_file | while read -r record; do
  year=$(echo $record | cut -d " " -f1)
  month=$(echo $record | cut -d " " -f2)
  day=$(echo $record | cut -d " " -f3)

  # Extract today and forecasted temperature if prev_record is not empty
  if [ -n "$prev_record" ]; then
    obs_temp=$(echo $record | cut -d " " -f4)
    forecasted_for_today=$(echo $prev_record | cut -d " " -f5)

    echo "$year, $month, $day, Today's temp = $obs_temp, Forecasted for today = $forecasted_for_today"
  fi

  # Since previous record is empty, the record is stored in prev_record to extract forecasted temperature
  prev_record=$record
done