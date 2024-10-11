#! /bin/bash
# This script calculates the weather accuracy for all days using the infos from the log (Alternate version of a single day)

log_file="rx_poc.log"

# Initialize the previous record
prev_record=""

# Extract the records without the header then loop it to extract required infos for weather accuracy report of all days
tail +2 $log_file | while read -r record; do
  # Extract the infos if prev_record is not empty
  if [ -n "$prev_record" ]; then
    year=$(echo $record | cut -d " " -f1)
    month=$(echo $record | cut -d " " -f2)
    day=$(echo $record | cut -d " " -f3)

    obs_temp=$(echo $record | cut -d " " -f4)
    forecasted_for_today=$(echo $prev_record | cut -d " " -f5)

    # Calculate the difference between today and forecasted temperature for accuracy range
    accuracy_range=$(($obs_temp-$forecasted_for_today))
    # Make it positive if it's negative
    [ "$accuracy_range" -lt 0 ] && accuracy_range=$((-$accuracy_range))

    if [ "$accuracy_range" -le 1 ]; then
      accuracy_label=excellent
    elif [ "$accuracy_range" -eq 2 ]; then
      accuracy_label=good
    elif [ "$accuracy_range" -eq 3 ]; then
      accuracy_label=fair
    elif [ "$accuracy_range" -ge 4 ]; then
      accuracy_label=poor
    fi

    echo "$year, $month, $day, $obs_temp, $forecasted_for_today, $accuracy_label, $accuracy_range"

    # Calculate the forecast accuracy
    if [ "$obs_temp" -eq "$forecasted_for_today" ]; then
      echo "Today's temperature is the same as the forecasted temperature. Forecast accuracy is $accuracy_label."
    elif [ "$obs_temp" -gt "$forecasted_for_today" ]; then
      echo "Today's temperature is hotter by $accuracy_range. Forecast accuracy is $accuracy_label."
    elif [ "$obs_temp" -lt "$forecasted_for_today" ]; then
      echo "Today's temperature is colder by $accuracy_range. Forecast accuracy is $accuracy_label."
    fi

    # Append the report to the historical forecast accuracy file
    report=$(echo -e "$year\t$month\t$day\t$obs_temp\t$forecasted_for_today\t$accuracy_label\t$accuracy_range")
    echo $report >> historical_fc_accuracy.tsv
  fi

  # Since prev_record is empty, the first record is stored in prev_record to extract forecasted temperature then exists
  prev_record=$record
done