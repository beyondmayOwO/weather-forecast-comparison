#! /bin/bash

# Extract the current day, month, and year
year=$(tail -1 rx_poc.log | cut -d " " -f1)
month=$(tail -1 rx_poc.log | cut -d " " -f2)
day=$(tail -1 rx_poc.log | cut -d " " -f3)

# Extract Today's current Temperature
obs_temp=$(tail -1 rx_poc.log | cut -d " " -f4)
echo "Today's temperature is $obs_temp"

# Extract the forecasted temprature for today
forecasted_for_today=$(tail -2 rx_poc.log | head -1 | cut -d " " -f5)
echo "Forecasted temperature for today is $forecasted_for_today"

# Calculate the difference between today and forecasted temperature
accuracy_range=$(($obs_temp-$forecasted_for_today))
# Make it positive if it's negative
[ "$accuracy_range" -lt 0 ] && accuracy_range=$((-$accuracy_range))

# Calculate the accuracy range then assign the label
if [ "$accuracy_range" -le 1 ]
then
  accuracy_label=excellent
elif [ "$accuracy_range" -eq 2 ]
then
  accuracy_label=good
elif [ "$accuracy_range" -eq 3 ]
then
  accuracy_label=fair
elif [ "$accuracy_range" -ge 4 ]
then
  accuracy_label=poor
fi

# Calculate the forecast accuracy
if [ "$obs_temp" -eq "$forecasted_for_today" ]
then
  echo "Today's temperature is the same as the forecasted temperature. Forecast accuracy is $accuracy_label."
elif [ "$obs_temp" -gt "$forecasted_for_today" ]
then
  echo "Today's temperature is hotter by $accuracy_range. Forecast accuracy is $accuracy_label."
elif [ "$obs_temp" -lt "$forecasted_for_today" ]
then
  echo "Today's temperature is colder by $accuracy_range. Forecast accuracy is $accuracy_label."
fi

# Append the record to the historical forecast accuracy file
record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$forecasted_for_today\t$accuracy_label\t$accuracy_range")
echo $record >> historical_fc_accuracy.tsv